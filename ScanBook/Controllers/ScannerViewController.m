//
//  ScannerViewController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "ScannerViewController.h"

@interface ScannerViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)onClickBtnAction:(id)sender {
    if (sender == _btnBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
