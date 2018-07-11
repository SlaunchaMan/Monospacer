//
//  Monospacer.h
//  Monospacer
//
//  Created by Jeff Kelley on 7/11/18.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
#endif

//! Project version number for Monospacer.
FOUNDATION_EXPORT double MonospacerVersionNumber;

//! Project version string for Monospacer_iOS.
FOUNDATION_EXPORT const unsigned char MonospacerVersionString[];
