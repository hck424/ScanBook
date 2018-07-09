//
//  ScanBookAppDelegate.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 3..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "ScanBookAppDelegate.h"
#import "Define.h"

@interface ScanBookAppDelegate ()

@end

@implementation ScanBookAppDelegate

+ (ScanBookAppDelegate *)sharedAppDelegate {
    return (ScanBookAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (MainNavigationController *)GetMainNavigationController {
    return self.mainNavigationController;
}
- (RootNavigationController *)GetRootNavigationController {
    return self.rootNavigationController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    BOOL tutorialShow = [[NSUserDefaults standardUserDefaults] boolForKey:TUTORIAL_SHOW];
    if (tutorialShow == NO) {
        TutorialViewController *tutorialVC = [storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
        tutorialVC.view.frame = [Utility GetApplicationFrame];
        tutorialVC.view.layer.borderColor = [UIColor redColor].CGColor;
        tutorialVC.view.layer.borderWidth = 1.0f;
        
        
        self.window.rootViewController = tutorialVC;
        [self.window makeKeyAndVisible];
    }
    else {
        [self startLaunch];
    }
    return YES;
}

- (void)startLaunch {
    NSLog(@"startLaunch");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.mainNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
    self.mainNavigationController.view.frame = [Utility GetApplicationFrame];
    self.mainViewController = [_mainNavigationController viewControllers].firstObject;
    
    
    [_mainViewController setupWithType:1];
    
    self.window.rootViewController.view.frame = [Utility GetApplicationFrame];
    self.rootNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"RootNavigationController"];
    [_mainViewController.view addSubview:_rootNavigationController.view];
    _mainViewController.rootViewController = _rootNavigationController;
    
    
    self.bannerViewController = [storyboard instantiateViewControllerWithIdentifier:@"BannerViewController"];
    [self.mainViewController.view addSubview:_bannerViewController.view];
    _bannerViewController.view.frame = CGRectZero;
    _bannerViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
//    _mainNavigationController.view.layer.borderColor = [UIColor blueColor].CGColor;
//    _mainNavigationController.view.layer.borderWidth = 1.0f;
//
//    _rootNavigationController.view.layer.borderColor = [UIColor purpleColor].CGColor;
//    _rootNavigationController.view.layer.borderWidth = 1.0f;

    
    self.window.rootViewController = _mainNavigationController;
    [self.window makeKeyAndVisible];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hasAd = YES;
        [self.mainViewController.view bringSubviewToFront:self.bannerViewController.view];
    });
}

- (void)setHasAd:(BOOL)hasAd {

    if (_hasAd != hasAd) {
        [self changeFrame:hasAd];
    }
    _hasAd = hasAd;

}

- (void)changeFrame:(BOOL)hasAd {
    CGRect mainFrame = [Utility GetApplicationFrame];
    if (hasAd) {
        _bannerViewController.view.hidden = NO;
        self.rootNavigationController.view.frame = CGRectMake(mainFrame.origin.x, mainFrame.origin.y, mainFrame.size.width, mainFrame.size.height - BANNER_HEIGHT);
        _bannerViewController.view.frame = CGRectMake(mainFrame.origin.x, mainFrame.size.height - BANNER_HEIGHT, mainFrame.size.width, BANNER_HEIGHT);
    }
    else {
        _bannerViewController.view.hidden = YES;
        self.rootNavigationController.view.frame = mainFrame;
        _bannerViewController.view.frame = CGRectZero;
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
