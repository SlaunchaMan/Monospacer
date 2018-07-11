# Monospacer

A framework for macOS, iOS, tvOS, and watchOS to create monospaced variants of fonts.

[![Version](https://img.shields.io/cocoapods/v/Monospacer.svg?style=flat)](http://cocoadocs.org/docsets/Monospacer)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Monospacer.svg?style=flat)](http://cocoadocs.org/docsets/Monospacer)
[![Platform](https://img.shields.io/cocoapods/p/Monospacer.svg?style=flat)](http://cocoadocs.org/docsets/Monospacer)

# Installation

## CocoaPods

To use Monospacer with [CocoaPods](https://cocoapods.org), add a dependency to your `Podfile`:

```Ruby
target 'MyAwesomeApp' do
  pod 'Monospacer'
end
```

Then run `pod install` and use the generated `.xcworkspace` to open your project.

## Carthage

To use Monospacer with [Carthage](https://github.com/Carthage/Carthage), add a dependency to your `Cartfile`:

```
github "SlaunchaMan/Monospacer"
```

Run `carthage update` to build the framework. Then follow the rest of the steps in [Carthage’s README](https://github.com/Carthage/Carthage#getting-started) to add the framework to your project, configure a Run Script build phase, etc.

## Manually

To integrate Monospacer manually into your project, drag `Monospacer.xcodeproj` into your Xcode project, then use the correct `Monospacer.framework` for your platform.

# Using Monospacer

## Swift

To use Monospacer, use the extension on `UIFont` (`NSFont` for macOS):

```Swift
let newFont = myFont.withMonospaceDigits
```

You can also use this on a font descriptor to add the monospaced digits attribute (useful if you need to perform other modifications to the descriptor before using it to create a font):

```Swift
let newFontDescriptor = myFontDescrpitor.withMonospaceDigits
```

## Objective-C

Monospacer also works with Objective-C:

```Objective-C
UIFont *newFont = myFont.fontWithMonospaceDigits;
UIFontDescriptor *newFontDescriptor = myFontDescriptor.descriptorForMonospaceDigits;
```