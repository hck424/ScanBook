//
//  MainNavigationController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 5..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "MainNavigationController.h"
#import "Utility.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.view.frame = [Utility GetApplicationFrame];
    self.viewControllers.firstObject.view.frame = self.view.bounds;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
