//
//  TutorialViewController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 3..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "TutorialViewController.h"
#import "ScanBookAppDelegate.h"
#import "Utility.h"
#import "Define.h"

@interface TutorialViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _scrollView.hidden = NO;
    _pageController.hidden = NO;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    self.view.frame = [Utility getApplicationSafeArea];
}

- (IBAction)onClickButtonAction:(UIButton *)sender {
    if (sender == _btnClose) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TUTORIAL_SHOW];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[ScanBookAppDelegate sharedAppDelegate] startLaunch];
    }
}

- (IBAction)pageControllerAction:(UIPageControl *)sender {
    CGFloat posX = sender.currentPage * _scrollView.frame.size.width;
    _scrollView.contentOffset = CGPointMake(posX, 0);
}

#pragma mark -- ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageNum = scrollView.contentOffset.x / _scrollView.frame.size.width;
    _pageController.currentPage = pageNum;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
