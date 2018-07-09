//
//  ScanBookViewController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "ScanBookViewController.h"
#import "UIViewController+LGSideMenuController.h"
#import "ScannerViewController.h"
#import "ScanBookAppDelegate.h"

@interface ScanBookViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btmAdd;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnScanner;

@end

@implementation ScanBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}

- (IBAction)onClickButtonAction:(id)sender {
    if (sender == _btmAdd) {
        [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
    }
    else if (sender == _btnEdit) {
        [self.sideMenuController showRightViewAnimated:YES completionHandler:nil];
    }
    else if (sender == _btnScanner) {
        ScannerViewController *viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
        [self.navigationController pushViewController:viewCon animated:YES];
    }
    
}


@end
