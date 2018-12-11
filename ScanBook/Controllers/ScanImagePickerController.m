//
//  ScanImagePickerController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 13..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "ScanImagePickerController.h"
#import "Utility.h"

@interface ScanImagePickerController ()

@end

@implementation ScanImagePickerController
- (instancetype) init {
    if (self = [super init]) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.view.frame = [Utility getApplicationSafeArea];
    self.cameraOverlayView.frame = self.view.bounds;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)orientationChange:(NSNotification *)noti {
    
    if (self.sourceType == UIImagePickerControllerSourceTypeCamera) {
//        self.cameraOverlayView.frame = self.view.safeAreaLayoutGuide.layoutFrame;
        //        UIEdgeInsets saftInset = self.view.safeAreaInsets;
        //        NSArray *constraint = self.cameraOverlayView.constraints;
        //        for (NSLayoutConstraint *con in constraint) {
        //            if ([con.identifier isEqualToString:@"overlayViewBottom"]) {
        //                con.constant = saftInset.bottom;
        //            }
        //        }
    }
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft
        || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
        // Landscape
        NSLog(@"===== Landscape");
        
    } else {
        // Portrait
        NSLog(@"===== Portrait");
        
    }
}
@end
