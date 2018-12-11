//
//  Utility.h
//  ScanBook
//
//  Created by 학철 on 2018. 7. 7..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScanBookAppDelegate.h"

@interface Utility : NSObject
+ (CGRect)getApplicationFrame;
+ (CGRect)getApplicationSafeArea;
+ (UIImage *)cropImage:(UIImage *)originalImage toRect:(CGRect)rect;
@end
