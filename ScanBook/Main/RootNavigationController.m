//
//  RootNavigationController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "RootNavigationController.h"
#import "UIViewController+LGSideMenuController.h"
#import "Utility.h"
#import "Define.h"
#import "ScanBookAppDelegate.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    BOOL hasAd = [ScanBookAppDelegate sharedAppDelegate].hasAd;
    
    CGRect mainFrame = [Utility GetApplicationFrame];
    if (hasAd) {
        self.view.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, mainFrame.size.height - BANNER_HEIGHT);
    }
    else {
        self.view.frame = mainFrame;
    }

    for (UIViewController *viewCon in self.viewControllers) {
        viewCon.view.frame = self.view.frame;
    }
    
}

//- (BOOL)shouldAutorotate {
//    return YES;
//}
//- (BOOL)prefersStatusBarHidden {
//    return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}
//
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
//    return self.sideMenuController.isRightViewVisible ? UIStatusBarAnimationSlide : UIStatusBarAnimationFade;
//}

@end
