//
//  UIImage+Utility.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)
+ (UIImage *)imageNamed:(NSString *)name withTintColor:(UIColor *)tintColor {
    UIImage *img = [UIImage imageNamed:name];
    return [self tintedImageWithColor:tintColor image:img];
}
+ (UIImage *)tintedImageWithColor:(UIColor *)tintColor image:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // draw alpha-mask
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, image.CGImage);
    
    // draw tint color, preserving alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImage;
}
- (UIImage *) cropImageWithRect:(CGRect)cropRect viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight {

    // viewWidth, viewHeight are dimensions of imageView
    
    const CGFloat imageViewScaleW = self.size.width/viewWidth; //MAX(self.size.width/viewWidth, self.size.height/viewHeight);
    const CGFloat imageViewScaleH = self.size.height/viewHeight;
    // Scale cropRect to handle images larger than shown-on-screen size
    cropRect.origin.x *= imageViewScaleW;
    cropRect.origin.y *= imageViewScaleH;
    cropRect.size.width *= imageViewScaleW;
    cropRect.size.height *= imageViewScaleH;
    
    // Perform cropping in Core Graphics
    CGImageRef cutImageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    
    // Convert back to UIImage
    UIImage* croppedImage = [UIImage imageWithCGImage:cutImageRef scale:1.0f orientation:self.imageOrientation];
    
    // Clean up reference pointers
    CGImageRelease(cutImageRef);
    
    return croppedImage;
    
}
@end
