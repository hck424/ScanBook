//
//  ScanBookAppDelegate.h
//  ScanBook
//
//  Created by 학철 on 2018. 7. 3..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigationController.h"
#import "RootNavigationController.h"
#import "TutorialViewController.h"
#import "MainViewController.h"
#import "ScanBookAppDelegate.h"
#import "Utility.h"
#import "BannerViewController.h"
#import "ScanBookViewController.h"

@interface ScanBookAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainNavigationController *mainNavigationController;
@property (strong, nonatomic) RootNavigationController *rootNavigationController;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong, nonatomic) BannerViewController *bannerViewController;
@property (assign, nonatomic) BOOL hasAd;
- (void)startLaunch;
+ (ScanBookAppDelegate *)sharedAppDelegate;
- (MainNavigationController *)getMainNavigationController;
- (RootNavigationController *)getRootNavigationController;
@end

