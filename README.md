# Monospacer

A framework for macOS, iOS, tvOS, and watchOS to create monospaced variants of fonts.

[![Version](https://img.shields.io/cocoapods/v/Monospacer.svg?style=flat)](https://cocoapods.org/pods/Monospacer)
![Documentation](docs/badge.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Monospacer.svg?style=flat)](https://github.com/SlaunchaMan/Monospacer/blob/master/LICENSE)
![Platform](https://img.shields.io/cocoapods/p/Monospacer.svg?style=flat)

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
let newFont = try? myFont.withMonospaceDigits()
```

You can also use this on a font descriptor to add the monospaced digits attribute (useful if you need to perform other modifications to the descriptor before using it to create a font):

```Swift
let newFontDescriptor = myFontDescrpitor.withMonospaceDigits
```

## Objective-C

Monospacer also works with Objective-C:

```Objective-C
UIFont *newFont = [myFont fontWithMonospaceDigitsError:NULL];

UIFontDescriptor *newFontDescriptor = myFontDescriptor.descriptorForMonospaceDigits;
```

## Error Handling

Not all fonts support monospaced digits. In the case where a font doesn’t support this feature, Monospacer throws a `MonospacerError.fontUnsupported` error. On macOS, if font creations fails, Monospacer throws a `MonospacerError.fontCreationFailed` error.  You can handle these in Swift or Objective-C:

```Swift
// Swift
do {
    let font = try someFont.withMonospaceDigits()
}
catch MonospacerError.fontUnsupported {
    NSLog("Whoops! This font isn't supported!")
}
catch MonospacerError.fontCreationFailed {
    NSLog("Uh-oh. Creating this font failed.")
}
catch {
    fatalError("Unexpected error: \(error.localizedDescription)")
}
```

```Objective-C
// Objective-C
NSError *error = nil;
UIFont *font = [font fontWithMonospaceDigitsError:&error];

if (font == nil) {
    if (error.domain == MonospacerErrorDomain &&
        error.code == MonospacerErrorFontUnsupported) {
        NSLog(@"Whoops! This font isn't supported!");
    }
}
```
If you don’t care about the errors, you can safely ignore them:

```Swift
let newFont = try? font.withMonospaceDigits()

myLabel.font = newFont ?? font
```
