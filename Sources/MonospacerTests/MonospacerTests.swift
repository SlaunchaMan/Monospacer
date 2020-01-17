//
//  MonospacerTests.swift
//  MonospacerTests-iOS
//
//  Created by Jeff Kelley on 7/11/18.
//

import XCTest
@testable import Monospacer

#if os(macOS)
// This method is swizzled so we can test what happens if
// `NSFont.init(descriptor:size:)` returns `nil`.
extension Font {
    @objc fileprivate static func swizzledFont(
        descriptor: NSFontDescriptor,
        size: CGFloat
    ) -> Font? {
        return nil
    } 
}
#endif

class MonospacerFontTests: XCTestCase {

    var originalFont: Font!
    var modifiedFont: Font!

    override func setUp() {
        originalFont = Font.systemFont(ofSize: 42)
        modifiedFont = try! originalFont?.withMonospaceDigits()
    }

    func testSendingAFontReturnsAFont() {
        XCTAssertNotNil(modifiedFont)
    }

    func testSendingAFontReturnsAModifiedFont() {
        XCTAssertNotEqual(originalFont, modifiedFont)
    }

    func testThatSendingAFontReturnsAFontWithTheSameName() {
        // On macOS, you start with ".AppleSystemUIFont" and end up with
        // ".SFNS-Regular".
        if #available(macOS 10.0, *) {
            XCTAssertTrue(
                (originalFont?.fontName == modifiedFont?.fontName) ||
                    (originalFont?.fontName == ".AppleSystemUIFont" &&
                        modifiedFont?.fontName == ".SFNS-Regular")
            )
        }
        else {
            XCTAssertEqual(originalFont?.fontName, modifiedFont?.fontName)
        }
    }

    func testThatSendingAFontReturnsAFontWithTheSameSize() {
        XCTAssertEqual(originalFont?.pointSize, modifiedFont?.pointSize)
    }

    func testThatSupportedFontsHaveTheCorrectAttributes() {
        XCTAssertTrue(modifiedFont.fontDescriptor.hasMonospacedFontSelector)
    }

    func testThatUnsupportedFontsThrow() {
        let font = Font(name: "Times New Roman", size: 42)!

        XCTAssertThrowsError(
            try font.withMonospaceDigits(),
            "Attempting to create a monospace-digit version of an unsupported font should fail") { error in
                let error = error as? MonospacerError

                XCTAssertEqual(error, MonospacerError.fontUnsupported)
        }
    }
    
    #if os(macOS)
    func testFontCreationFailuresThrow() {
        
        let fontClass = Font.self
        
        let originalMethod = class_getClassMethod(
            fontClass,
            #selector(Font.init(descriptor:size:))
        )
        
        let replacementMethod = class_getClassMethod(
            fontClass,
            #selector(Font.swizzledFont(descriptor:size:))
        )
        
        method_exchangeImplementations(originalMethod!, replacementMethod!)
        
        let font = Font(name: "Times New Roman", size: 42)!
        
        XCTAssertThrowsError(
            try font.withMonospaceDigits(),
            "If font creation fails, it should throw") { error in
                let error = error as? MonospacerError

                XCTAssertEqual(error, MonospacerError.fontCreationFailed)
        }

        method_exchangeImplementations(originalMethod!, replacementMethod!)
    }
    #endif

}

class MonospacerFontDescriptorTests: XCTestCase {

    func testModifyingADescriptorAddsAttributes() throws {
        #if targetEnvironment(macCatalyst)
        let font = try XCTUnwrap(Font(name: "Helvetica", size: 42))
        #else
        let font = Font.systemFont(ofSize: 42)
        #endif
        
        XCTAssertFalse(font.fontDescriptor.hasMonospacedFontSelector)
        
        let modifiedFontDescriptor = font.fontDescriptor.withMonospaceDigits
        XCTAssertTrue(modifiedFontDescriptor.hasMonospacedFontSelector)
    }

    func testModifyingUnsupportedDescriptors() {
        let font = Font(name: "Times New Roman", size: 42)!
        XCTAssertFalse(font.fontDescriptor.hasMonospacedFontSelector)
        let modifiedFontDescriptor = font.fontDescriptor.withMonospaceDigits
        XCTAssertTrue(modifiedFontDescriptor.hasMonospacedFontSelector)
    }

}
