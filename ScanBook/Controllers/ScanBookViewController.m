//
//  ScanBookViewController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "ScanBookViewController.h"
#import "UIViewController+LGSideMenuController.h"

@interface ScanBookViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btmAdd;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;

@end

@implementation ScanBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onClickButtonAction:(id)sender {
    if (sender == _btmAdd) {
        [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
    }
    else if (sender == _btnEdit) {
        [self.sideMenuController showRightViewAnimated:YES completionHandler:nil];
    }
    
}


@end
