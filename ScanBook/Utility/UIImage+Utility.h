//
//  UIImage+Utility.h
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)
+ (UIImage *)imageNamed:(NSString *)name withTintColor:(UIColor *)tintColor;
+ (UIImage *)tintedImageWithColor:(UIColor *)tintColor image:(UIImage *)image;

@end
