//
//  CameraOverlayLandscapeView.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 11..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "CameraOverlayViewLandscape.h"

@implementation CameraOverlayViewLandscape


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)init {
    if (self = [super init]) {
        UIView *tmpView = [[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:self options:nil].firstObject;
        [self addSubview:tmpView];
        
        tmpView.translatesAutoresizingMaskIntoConstraints = NO;
        [tmpView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = YES;
        [tmpView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
        [tmpView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = YES;
        [tmpView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = YES;
        
        [self customizeConstraint];
    }
    return self;
}

- (void)customizeConstraint {
    self.toolBarView.translatesAutoresizingMaskIntoConstraints = NO;
    
    for (NSLayoutConstraint *constraint in self.toolBarView.constraints) {
        if ([constraint.identifier isEqualToString:@"leading"]) {
            [self.toolBarView removeConstraint:constraint];
        }
        else if ([constraint.identifier isEqualToString:@"height"]) {
            [self.toolBarView removeConstraint:constraint];
        }
    }
    
    NSLayoutConstraint *top = [self.toolBarView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0];
    top.identifier = @"top";
    top.active = YES;
    
    NSLayoutConstraint *width = [self.toolBarView.widthAnchor constraintEqualToConstant:60];
    width.identifier = @"width";
    width.active = YES;
    
    self.svToolBar.axis = UILayoutConstraintAxisVertical;
}
@end
