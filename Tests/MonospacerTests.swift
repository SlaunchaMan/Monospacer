//
//  MonospacerTests.swift
//  MonospacerTests-iOS
//
//  Created by Jeff Kelley on 7/11/18.
//

import XCTest
@testable import Monospacer

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
        XCTAssertEqual(originalFont?.fontName, modifiedFont?.fontName)
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

}

class MonospacerFontDescriptorTests: XCTestCase {

    func testModifyingADescriptorAddsAttributes() {
        let font = Font.systemFont(ofSize: 42)
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
