//
//  UIColor+Utility.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)
+ (UIColor *)colorOfHexColor:(NSString *)hexStr {
    UIColor *color = [UIColor whiteColor];
    if (hexStr.length == 0) {
        return color;
    }
    unsigned int rgb;
    NSScanner *scanner = [NSScanner scannerWithString:[hexStr stringByReplacingOccurrencesOfString:@"#" withString:@""]];
    if ([scanner scanHexInt:&rgb]) {
        color = [UIColor colorWithRed:((rgb & 0xff0000) >> 16)/255.0f green:((rgb & 0xff00) >> 8)/255.0f blue:(rgb & 0xff)/255.0f alpha:1.0];
    }
    return color;
}
@end
