//
//  BannerViewController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 7..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "BannerViewController.h"
#import "ScanBookAppDelegate.h"
#import "Utility.h"
#import "Define.h"

@interface BannerViewController ()
@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[ScanBookAppDelegate sharedAppDelegate].window bringSubviewToFront:self.view];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect mainFrame = [Utility getApplicationFrame];
    if ([ScanBookAppDelegate sharedAppDelegate].hasAd) {
        self.view.hidden = NO;
        self.view.frame = CGRectMake(mainFrame.origin.x, mainFrame.size.height - BANNER_HEIGHT, mainFrame.size.width, BANNER_HEIGHT);
    }
    else {
        self.view.hidden = YES;
        self.view.frame = CGRectZero;
    }
    
}

@end
