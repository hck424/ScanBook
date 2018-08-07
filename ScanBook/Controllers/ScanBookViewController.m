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
#import "BookCollectionViewCell.h"
#import "BookInfo.h"

static NSString *const kReuseCellID = @"BookCollectionViewCell";

@interface ScanBookViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btmAdd;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnScanner;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *arrData;
@property (assign, nonatomic) NSInteger totalColumn;

@end

@implementation ScanBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.totalColumn = 3;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BookCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kReuseCellID];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
}

#pragma mark -- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_arrData.count == 0) {
        return 1;
    }
    return _arrData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BookCollectionViewCell" owner:self options:nil].firstObject;
    }
    
    BookInfo *bookInfo = [_arrData objectAtIndex:indexPath.row];
    if (_arrData.count == 0) {
        [cell configurationWidthData:nil cellType:CELL_TYPE_EMPTY];
    }
    else {
        [cell configurationWidthData:bookInfo cellType:CELL_TYPE_NORMAL];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.frame.size.width - (_totalColumn + 1) * 8) / _totalColumn , 150);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 8, 8, 8);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrData.count == 0) {
        [self showScannerViewCon];
    }
    else {
        
    }
}

- (IBAction)onClickButtonAction:(id)sender {
    if (sender == _btmAdd) {
        [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
    }
    else if (sender == _btnEdit) {
        [self.sideMenuController showRightViewAnimated:YES completionHandler:nil];
    }
    else if (sender == _btnScanner) {
        [self showScannerViewCon];
    }
    
}
- (void)showScannerViewCon {
    ScannerViewController *viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
    [self.navigationController pushViewController:viewCon animated:YES];
}

@end
