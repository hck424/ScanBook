//
//  ScanBookViewController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "ScanBookViewController.h"
#import "UIViewController+LGSideMenuController.h"
#import "ScanBookAppDelegate.h"
#import "BookCollectionViewCell.h"
#import "BookInfo.h"
#import <AVFoundation/AVFoundation.h>
#import "UIButtonEx.h"
#import "UIImage+Utility.h"
#import "UIColor+Utility.h"
#import "Define.h"
#import "CameraOverlayView.h"
#import "ScanBookAppDelegate.h"
#import "ScanImagePickerController.h"
#import "CameraOverlayView.h"

static NSString *const kReuseCellID = @"BookCollectionViewCell";

@interface ScanBookViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CameraOverlayViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btmAdd;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnPhotoLibray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnScreenShot;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableDictionary *cameraOverayInfo;
@property (strong, nonatomic) NSMutableArray *arrData;
@property (assign, nonatomic) NSInteger totalColumn;
@property (strong, nonatomic) ScanImagePickerController *imagePickerController;
@property (strong, nonatomic) CameraOverlayView *overlayView;
@property (strong, nonatomic) NSMutableArray <UIImage *> *arrOriginImg;
@property (weak, nonatomic) NSTimer *timerShot;
@property (strong, nonatomic) IBOutlet UIView *previousView;

@property (weak, nonatomic) IBOutlet UIImageView *ivNew;
@property (weak, nonatomic) IBOutlet UIImageView *ivOrign;

@end

@implementation ScanBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.totalColumn = 3;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BookCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kReuseCellID];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.arrOriginImg = [NSMutableArray array];
    
//    [ScanBookAppDelegate sharedAppDelegate].mainViewController.rootViewStatusBarHidden = YES;
    
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else {
        
    }
}

- (IBAction)onClickButtonAction:(id)sender {
    if (sender == _btmAdd) {
        [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
    }
    else if (sender == _btnPhotoLibray) {
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else if (sender == _btnScreenShot) {
        [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
}

#pragma mark -- ImagePickerViewController Permistion
- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"Unable to access the Camera"
                                                                          message:@"To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app."
                                                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alertCon dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertCon addAction:okAction];
        
        UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:settingsUrl]) {
                [[UIApplication sharedApplication] openURL:settingsUrl options:@{} completionHandler:nil];
            }
            else {
                [alertCon dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [alertCon addAction:settingAction];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self displayImagePicker:sourceType];
                });
            }
        }];
    }
    else {
        [self displayImagePicker:sourceType];
    }
}

- (void)displayImagePicker:(UIImagePickerControllerSourceType)soureType  {
    
    self.imagePickerController = [[ScanImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalPresentationStyle = (soureType == UIImagePickerControllerSourceTypeCamera) ? UIModalPresentationFullScreen : UIModalPresentationOverFullScreen;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePickerController.sourceType = soureType;
    
    if (soureType == UIImagePickerControllerSourceTypeCamera) {
        _imagePickerController.navigationBarHidden = YES;
        _imagePickerController.toolbarHidden = YES;
        _imagePickerController.allowsEditing = NO;
        _imagePickerController.showsCameraControls = NO;
        
        self.overlayView = [[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:self options:nil].firstObject;
        _overlayView.delegate = self;
        
        
        
        CGRect safeRect = [Utility getApplicationSafeArea];
        _overlayView.frame =  CGRectMake(0, 0, safeRect.size.width, safeRect.size.height);
        _imagePickerController.cameraOverlayView = _overlayView;
        _imagePickerController.view.frame = safeRect;
        
        CGSize screenSize = safeRect.size;

//        CGFloat ratio =  (safeRect.size.height - _overlayView.toolBarView.frame.size.height)/ safeRect.size.width;
        CGFloat rate = 4/3;
        
        CGFloat carmeraH = screenSize.width * rate;
        CGFloat scale = ceil((screenSize.height / carmeraH) *100)/100;
        _imagePickerController.cameraViewTransform = CGAffineTransformMakeTranslation(0, (screenSize.height -  carmeraH) / 2.0);
        _imagePickerController.cameraViewTransform = CGAffineTransformScale(_imagePickerController.cameraViewTransform, scale, scale);
    }
    else if (soureType == UIImagePickerControllerSourceTypePhotoLibrary) {
        _imagePickerController.navigationBarHidden = NO;
        _imagePickerController.toolbarHidden = NO;
        _imagePickerController.allowsEditing = NO;
    }
    
    [self.navigationController presentViewController:_imagePickerController animated:NO completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.overlayView refreshButtonImage];
        });
    }];
    
}

#pragma mark -- CameraOverlayViewDelegate
- (void)carmeraOverayViewOnClickedButtonAction:(CAMERAOVERAY_BUTTON_TYPE)btnType userInfo:(NSDictionary *)userInfo {
    if (btnType == CAMERAOVERAY_BUTTON_TYPE_UNDO) {
        NSLog(@"btn action undo");
        [self finishAndUpdate];
        
        if (_arrOriginImg.count > 0) {
            [self processPhotos];
        }
    }
    else if (btnType == CAMERAOVERAY_BUTTON_TYPE_SHOT) {
        NSLog(@"btn action shot");
        NSLog(@"userInfo = %@", userInfo);
        //edges_point, height_sepeartor, page_type, timer
        
        [_arrOriginImg removeAllObjects];
        
        self.cameraOverayInfo = [NSMutableDictionary dictionaryWithDictionary:userInfo];
        NSInteger timeInterval = [[_cameraOverayInfo objectForKey:@"timer"] integerValue];
        
        if (timeInterval == 0) {
            [_imagePickerController takePicture];
        }
        else {
            __block NSInteger repeatCnt = timeInterval;
            _overlayView.lbTime.text = [NSString stringWithFormat:@"%ld's", repeatCnt];
            self.timerShot = [NSTimer scheduledTimerWithTimeInterval:timeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
                
                repeatCnt--;
                self.overlayView.lbTime.text = [NSString stringWithFormat:@"%ld's", repeatCnt];
                [self.imagePickerController takePicture];
                
                if (repeatCnt == 0) {
                    repeatCnt = timeInterval;
                }
            }];
        }
    }
}
- (void) processPhotos {
    
    NSString *page = [_cameraOverayInfo objectForKey:@"page_type"];
    NSArray *arrPoint = [_cameraOverayInfo objectForKey:@"edges_point"];
    CGFloat seperatorHeight = [[_cameraOverayInfo objectForKey:@"height_sepeartor"] floatValue];
    
    if ([page isEqualToString:@"1"]) {

        //0, 2
        CGFloat x = MIN([[arrPoint objectAtIndex:0] CGPointValue].x, [[arrPoint objectAtIndex:2] CGPointValue].x);
        CGFloat y = MAX([[arrPoint objectAtIndex:0] CGPointValue].y, [[arrPoint objectAtIndex:2] CGPointValue].y);
        
        CGFloat distanceX1 = [[arrPoint objectAtIndex:2] CGPointValue].x - [[arrPoint objectAtIndex:0] CGPointValue].x;
        CGFloat distanceX2 = [[arrPoint objectAtIndex:4] CGPointValue].x - [[arrPoint objectAtIndex:6] CGPointValue].x;
        CGFloat w = MIN(ABS(distanceX1), ABS(distanceX2));

        CGFloat distanceY1 = [[arrPoint objectAtIndex:6] CGPointValue].y - [[arrPoint objectAtIndex:0] CGPointValue].y;
        CGFloat distanceY2 = [[arrPoint objectAtIndex:4] CGPointValue].y - [[arrPoint objectAtIndex:2] CGPointValue].y;
        CGFloat h = MIN(ABS(distanceY1), ABS(distanceY2));
        
        
        _previousView.frame = CGRectMake(0, self.view.frame.size.height - 150, self.view.frame.size.width, 150);
        _previousView.hidden = NO;
        [self.view addSubview:_previousView];
        
        for (UIImage *img in _arrOriginImg) {
            
            CGFloat radio = img.size.width/self.view.frame.size.width;
//            UIImage *scaleImg = [[UIImage alloc] initWithCGImage:[img CGImage] scale:scale orientation:img.imageOrientation];
            
            CGRect cropRect = CGRectMake(x*radio, y*radio, w*radio, h*radio);
            
            NSLog(@"crop rect %@", NSStringFromCGRect(cropRect));
            
            UIImage *newImg = [Utility cropImage:img toRect:cropRect];
            
            NSLog(@"origin %@", img);
//            NSLog(@"scale %@", scaleImg);
            NSLog(@"new %@", newImg);
    
            _ivOrign.image = img;
            _ivNew.image = newImg;
            break;
        }
    }
    else {
        
    }
}
- (void) finishAndUpdate {
    if (_timerShot) {
        [_timerShot invalidate];
        [_timerShot fire];
        self.timerShot = nil;
    }
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil) {
        [_arrOriginImg addObject:image];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self setNeedsStatusBarAppearanceUpdate];
}


@end
