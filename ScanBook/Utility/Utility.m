//
//  Utility.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 7..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "Utility.h"
#import <UIKit/UIKit.h>
#define rad(deg) deg / 180.0 * M_PI

@implementation Utility
+ (CGRect)getApplicationFrame {
    if (@available(ios 11.0, *)) {
        UIEdgeInsets safeInset = [[ScanBookAppDelegate sharedAppDelegate].window safeAreaInsets];
        UILayoutGuide *guide = [ScanBookAppDelegate sharedAppDelegate].window.safeAreaLayoutGuide;
        CGRect frame = [guide layoutFrame];
        return CGRectMake(frame.origin.x, 0, frame.size.width, [ScanBookAppDelegate sharedAppDelegate].window.frame.size.height - safeInset.bottom);
    }
    return [[UIScreen mainScreen] bounds];
}

+ (CGRect)getApplicationSafeArea {
    if (@available(ios 11.0, *)) {
        UILayoutGuide *guide = [ScanBookAppDelegate sharedAppDelegate].window.safeAreaLayoutGuide;
        return [guide layoutFrame];
    }
    return [[UIScreen mainScreen] bounds];

}

+ (UIImage *)cropImage:(UIImage *)originalImage toRect:(CGRect)rect {

//    CGAffineTransform rectTransform;
//    switch (originalImage.imageOrientation)
//    {
//        case UIImageOrientationLeft:
//            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(90)), 0, -originalImage.size.height);
//            break;
//        case UIImageOrientationRight:
//            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(-90)), -originalImage.size.width, 0);
//            break;
//        case UIImageOrientationDown:
//            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(rad(-180)), -originalImage.size.width, -originalImage.size.height);
//            break;
//        default:
//            rectTransform = CGAffineTransformIdentity;
//    };
//    rectTransform = CGAffineTransformScale(rectTransform, originalImage.scale, originalImage.scale);
//
//    CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectApplyAffineTransform(rect, rectTransform));
//    UIImage *result = [UIImage imageWithCGImage:imageRef scale:originalImage.scale orientation:originalImage.imageOrientation];
//    CGImageRelease(imageRef);
//    return result;
    
    UIGraphicsBeginImageContext(CGSizeMake(originalImage.size.width, originalImage.size.height));
    [originalImage drawInRect:CGRectMake(0, 0, originalImage.size.width, originalImage.size.height)];
    UIImage *cropImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imgRef = CGImageCreateWithImageInRect([cropImg CGImage], rect);
    
    UIImage *resultImg = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    return  resultImg;
}
@end
