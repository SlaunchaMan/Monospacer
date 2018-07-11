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

private let fontFeatureTypeIdentifierKey = UIFontDescriptor.FeatureKey.featureIdentifier
private let fontFeatureSelectorIdentifierKey = UIFontDescriptor.FeatureKey.typeIdentifier
private let fontDescriptorFeatureSettingsAttribute = UIFontDescriptor.AttributeName.featureSettings
#elseif canImport(AppKit)
import AppKit

public typealias Font = NSFont
public typealias FontDescriptor = NSFontDescriptor

private let fontFeatureTypeIdentifierKey = NSFontDescriptor.FeatureKey.typeIdentifier
private let fontFeatureSelectorIdentifierKey = NSFontDescriptor.FeatureKey.selectorIdentifier
private let fontDescriptorFeatureSettingsAttribute = NSFontDescriptor.AttributeName.featureSettings
#else
#warning("Unsupported platform")
#endif

extension Font {

    #if canImport(UIKit)
    @objc(fontWithMonospaceDigits)
    public var withMonospaceDigits: Font {
        return Font(descriptor: fontDescriptor.withMonospaceDigits,
                    size: pointSize)
    }
    #elseif canImport(AppKit)
    @objc(fontWithMonospaceDigits)
    public var withMonospaceDigits: Font? {
        return Font(descriptor: fontDescriptor.withMonospaceDigits,
                    size: pointSize)
    }
    #endif
}

extension FontDescriptor {

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

}
