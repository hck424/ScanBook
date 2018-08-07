//
//  Utility.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 7..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "Utility.h"
#import <UIKit/UIKit.h>

@implementation Utility
+ (CGRect)GetApplicationFrame {
    if (@available(ios 11.0, *)) {
        UIEdgeInsets safeInset = [[ScanBookAppDelegate sharedAppDelegate].window safeAreaInsets];
        UILayoutGuide *guide = [ScanBookAppDelegate sharedAppDelegate].window.safeAreaLayoutGuide;
        CGRect frame = [guide layoutFrame];
        return CGRectMake(frame.origin.x, 0, frame.size.width, [ScanBookAppDelegate sharedAppDelegate].window.frame.size.height - safeInset.bottom);
    }
    return [[UIScreen mainScreen] bounds];
}

+ (CGRect)GetApplicationSafeArea {
    if (@available(ios 11.0, *)) {
        UILayoutGuide *guide = [ScanBookAppDelegate sharedAppDelegate].window.safeAreaLayoutGuide;
        return [guide layoutFrame];
    }
    return [[UIScreen mainScreen] bounds];

}
@end
