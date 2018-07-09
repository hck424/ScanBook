//
//  LeftViewController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "LeftViewController.h"
#import "UIColor+Utility.h"
#import "Define.h"
#import "UIImage+Utility.h"
#import "UIViewController+LGSideMenuController.h"
#import "ScannerViewController.h"
#import "MainViewController.h"
#import "ScanBookAppDelegate.h"

@interface LeftViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) NSMutableArray *arrData;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIView *selectedBgView;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_btnHome setImage:[UIImage imageNamed:@"home" withTintColor:[UIColor colorOfHexColor:DEFAULT_COLOR_BLUE]] forState:UIControlStateNormal];
    
    self.tblView.tableHeaderView = _headerView;
    _tblView.tableHeaderView.frame = CGRectMake(0, 0, _tblView.frame.size.width, 100);
    _tblView.tableFooterView.frame = CGRectMake(0, 0, _tblView.frame.size.width, 30);
    
    self.arrData = [NSMutableArray array];
    [self makeData];
    
    self.tblView.tableFooterView = _footerView;
    
    self.tblView.delegate = self;
    self.tblView.dataSource = self;
    
    
}
- (void)makeData {
    NSMutableDictionary *itemSec = [NSMutableDictionary dictionary];
    [itemSec setObject:@"새로운 노트북" forKey:@"sec_title"];
    NSArray *arrRow = [NSArray arrayWithObject:@"스캔"];
    [itemSec setObject:arrRow forKey:@"row"];
    [_arrData addObject:itemSec];
    
    NSMutableDictionary *itemSec2 = [NSMutableDictionary dictionary];
    [itemSec2 setObject:@"가져오기" forKey:@"sec_title"];
    arrRow = [NSArray arrayWithObjects:@"사진 라이브러리", @"Google Drive", @"Drop Box", @"One Drive", @"Naver Drive", nil];
    [itemSec2 setObject:arrRow forKey:@"row"];
    [_arrData addObject:itemSec2];
    
}
- (IBAction)onClickButtonAction:(id)sender {
    NSLog(@"home buttom click");
    [self hideLeftViewAnimated:nil];
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[_arrData objectAtIndex:section] objectForKey:@"row"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectedBackgroundView = _selectedBgView;
    }
    NSString *txt = [[[_arrData objectAtIndex:indexPath.section] objectForKey:@"row"] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = txt;
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    sectionView.backgroundColor = RGB(0xf4, 0xf4, 0xf4);
    UILabel *lbSectitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, sectionView.frame.size.width - 10, sectionView.frame.size.height)];
    lbSectitle.text = [[_arrData objectAtIndex:section] objectForKey:@"sec_title"];
    lbSectitle.textColor = [UIColor darkTextColor];
    [sectionView addSubview:lbSectitle];
    
    return sectionView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"스캔");
            MainViewController *mainViewController = (MainViewController *)self.sideMenuController;
//            UINavigationController *naviCtrl = (UINavigationController *)mainViewController.rootViewController;
            ScannerViewController *viewCon = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewController"];
            [[[ScanBookAppDelegate sharedAppDelegate] GetRootNavigationController] pushViewController:viewCon animated:YES];
//            [naviCtrl setViewControllers:@[viewCon]];
            [mainViewController hideLeftViewAnimated:YES completionHandler:nil];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSLog(@"사진 라이브러리");
        }
        else if (indexPath.row == 1) {
            NSLog(@"Google Drive");
        }
        else if (indexPath.row == 2) {
            NSLog(@"Drop Box");
        }
        else if (indexPath.row == 3) {
            NSLog(@"One Drive");
        }
        else if (indexPath.row == 4) {
            NSLog(@"Naver Drive");
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
