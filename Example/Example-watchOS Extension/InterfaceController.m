//
//  InterfaceController.m
//  Example-watchOS Extension
//
//  Created by Jeff Kelley on 7/12/18.
//  Copyright © 2018 Jeff Kelley. All rights reserved.
//

#import "InterfaceController.h"

@import Monospacer;

@interface InterfaceController ()

@property (strong, nullable, nonatomic) IBOutlet WKInterfaceLabel *firstLabel;
@property (strong, nullable, nonatomic) IBOutlet WKInterfaceLabel *secondLabel;

@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    NSError *error = nil;
    UIFont *font = [[UIFont systemFontOfSize:17.0f] fontWithMonospaceDigitsError:&error];

    if (font == nil) {
        if (error.domain == MonospacerErrorDomain &&
            error.code == MonospacerErrorFontUnsupported) {
            NSLog(@"Whoops! This font isn't supported!");
        }

        return;
    }

    NSDictionary<NSAttributedStringKey, id> *attributes =
    @{ NSFontAttributeName: font };

    [self.firstLabel setAttributedText:
     [[NSAttributedString alloc] initWithString:@"11 22 33 44 55 66 77 88 99"
                                     attributes:attributes]];

    [self.secondLabel setAttributedText:
     [[NSAttributedString alloc] initWithString:@"99 88 77 66 55 44 33 22 11"
                                     attributes:attributes]];
}

@end
