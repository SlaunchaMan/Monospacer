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

extension Font {

    #if canImport(UIKit)
    /// Creates and returns the same font, but with monospaced digits.
    ///
    /// - Note: Not all fonts support this feature. If called on a font that doesn’t
    ///         support monospaced digits, this will return the same font.
    @objc(fontWithMonospaceDigits)
    public var withMonospaceDigits: Font {
        return Font(descriptor: fontDescriptor.withMonospaceDigits,
                    size: pointSize)
    }
    #elseif canImport(AppKit)
    /// Creates and returns the same font, but with monospaced digits.
    ///
    /// - Note: Not all fonts support this feature. If called on a font that doesn’t
    ///         support monospaced digits, this will return the same font.
    @objc(fontWithMonospaceDigits)
    public var withMonospaceDigits: Font? {
        return Font(descriptor: fontDescriptor.withMonospaceDigits,
                    size: pointSize)
    }
    #endif
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
            let featureSettings = fontAttributes[fontDescriptorFeatureSettingsAttribute]
                as? [[String: Int]]
            else { return false }

        return featureSettings.contains(where: { settings -> Bool in
            return settings[fontFeatureTypeIdentifierKey.rawValue] == kNumberSpacingType &&
                settings[fontFeatureSelectorIdentifierKey.rawValue] == kMonospacedNumbersSelector
        })
    }

}
