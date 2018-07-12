//
//  Monospacer.swift
//  Monospacer
//
//  Created by Jeff Kelley on 7/11/18.
//

#if canImport(UIKit)
import UIKit

public typealias Font = UIFont
public typealias FontDescriptor = UIFontDescriptor

internal let fontFeatureTypeIdentifierKey = UIFontDescriptor.FeatureKey.featureIdentifier
internal let fontFeatureSelectorIdentifierKey = UIFontDescriptor.FeatureKey.typeIdentifier
internal let fontDescriptorFeatureSettingsAttribute = UIFontDescriptor.AttributeName.featureSettings

#elseif canImport(AppKit)
import AppKit

public typealias Font = NSFont
public typealias FontDescriptor = NSFontDescriptor

internal let fontFeatureTypeIdentifierKey = NSFontDescriptor.FeatureKey.typeIdentifier
internal let fontFeatureSelectorIdentifierKey = NSFontDescriptor.FeatureKey.selectorIdentifier
internal let fontDescriptorFeatureSettingsAttribute = NSFontDescriptor.AttributeName.featureSettings
#endif

@objc public enum MonospacerError: Int, Error {
    /// Thrown when the font does not support monospaced digits.
    case fontUnsupported

    #if canImport(AppKit)
    /// Thrown if creating a font failed.
    case fontCreationFailed
    #endif
}

extension Font {

    /// Creates and returns the same font, but with monospaced digits.
    ///
    /// - Throws:
    ///     - `MonospacerError.fontUnsupported` if the font does not support
    ///       monospaced digits.
    ///     - `MonospacerError.fontCreationFailed` if creating the new font fails
    ///       (macOS only).
    ///
    /// - Returns: The font modified to include the monospaced digits selector.
    @objc(fontWithMonospaceDigitsError:)
    public func withMonospaceDigits() throws -> Font {
        let newFont = Font(descriptor: fontDescriptor.withMonospaceDigits,
                           size: pointSize)

        #if canImport(AppKit)
        guard let font = newFont else {
            throw MonospacerError.fontCreationFailed
        }
        #else
        let font = newFont
        #endif

        guard font.fontDescriptor.hasMonospacedFontSelector else {
            throw MonospacerError.fontUnsupported
        }

        return font
    }

}

extension FontDescriptor {

    /// Returns the font descriptor with the “Monospaced Numbers” selector applied.
    @objc(descriptorForMonospaceDigits)
    public var withMonospaceDigits: FontDescriptor {
        let featureSettings = [
            fontFeatureTypeIdentifierKey: kNumberSpacingType,
            fontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
        ]

        let attributes = [
            fontDescriptorFeatureSettingsAttribute: [featureSettings]
        ]

        return addingAttributes(attributes)
    }

    /// Returns `true` if the font descriptor has the selector for monospaced digits
    /// enabled.
    @objc public var hasMonospacedFontSelector: Bool {
        guard
            let featureSettings =
            fontAttributes[fontDescriptorFeatureSettingsAttribute]
                as? [[String: Int]]
            else { return false }

        return featureSettings.contains { s -> Bool in
            return (
                s[fontFeatureTypeIdentifierKey.rawValue] == kNumberSpacingType &&
                    s[fontFeatureSelectorIdentifierKey.rawValue] ==
                kMonospacedNumbersSelector
            )
        }
    }

}
