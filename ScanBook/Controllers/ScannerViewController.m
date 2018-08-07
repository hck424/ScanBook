//
//  ScannerViewController.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 4..
//  Copyright © 2018년 학철. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "ScannerViewController.h"
#import "UIButtonEx.h"
#import "UIImage+Utility.h"
#import "UIColor+Utility.h"
#import "Define.h"
#import "CameraOverlayView.h"
#import "ScanBookAppDelegate.h"
#import "ScanImagePickerController.h"

@interface ScannerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CameraOverlayViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIStackView *svContent;
@property (weak, nonatomic) IBOutlet UITextField *tfTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;
@property (weak, nonatomic) IBOutlet UIButton *btnCover;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UILabel *lbCoverEmpty;
@property (weak, nonatomic) IBOutlet UIButton *btnOnePage;
@property (weak, nonatomic) IBOutlet UIButton *btnHalfPage;
@property (strong, nonatomic) ScanImagePickerController *imagePickerController;
@property (nonatomic, strong) NSMutableArray *arrCover;
@property (nonatomic, assign) NSInteger scheduleTimer;
@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrCover = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"notebook_cover_%ld", i];
        [_arrCover addObject:imgName];
    }
    _coverView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _coverView.layer.borderWidth = 1.0f;
    _coverView.layer.masksToBounds = NO;
    _coverView.layer.cornerRadius = 3.5;
    
    _btnCreate.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _btnCreate.layer.borderWidth = 1.0f;
    _btnCreate.layer.masksToBounds = NO;
    _btnCreate.layer.cornerRadius = 3.5;
    
    
    [_btnOnePage setImage:[UIImage imageNamed:@"check_circle_off" withTintColor:[UIColor colorOfHexColor:@"#1564FA"]] forState:UIControlStateNormal];
    [_btnOnePage setImage:[UIImage imageNamed:@"check_circle_on" withTintColor:[UIColor colorOfHexColor:@"#1564FA"]] forState:UIControlStateSelected];
    
    [_btnHalfPage setImage:[UIImage imageNamed:@"check_circle_off" withTintColor:[UIColor colorOfHexColor:@"#1564FA"]] forState:UIControlStateNormal];
    [_btnHalfPage setImage:[UIImage imageNamed:@"check_circle_on" withTintColor:[UIColor colorOfHexColor:@"#1564FA"]] forState:UIControlStateSelected];
  
    _btnOnePage.selected = YES;
    
    [self decorateBookCover];
    
}

- (void)decorateBookCover {
    
    for (NSInteger i = 0; i < _arrCover.count; i++) {
        NSString *imgName = [_arrCover objectAtIndex:i];
        
        UIButtonEx *btn = [UIButtonEx new];
        btn.idx = i;
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn.widthAnchor constraintEqualToConstant:40].active = YES;
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(onClickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_svContent addArrangedSubview:btn];
    }
}

- (IBAction)onClickBtnAction:(id)sender {
    if (sender == _btnBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (sender == _btnCover) {
        UIButton *tmpBtn = (UIButton *)sender;
        if (tmpBtn.currentBackgroundImage != nil) {
            _btnCover.selected = !tmpBtn.selected;
            if (_btnCover.selected) {
                [_btnCover setImage:[UIImage imageNamed:@"trash"] forState:UIControlStateSelected];
            }
            else {
                [_btnCover setBackgroundImage:nil forState:UIControlStateNormal];
            }
        }
    }
    else if ([sender isKindOfClass:[UIButtonEx class]]) {
        _btnCover.selected = NO;
        NSInteger imgIdx = ((UIButtonEx *)sender).idx;
       [_btnCover setBackgroundImage:[UIImage imageNamed:[_arrCover objectAtIndex:imgIdx]] forState:UIWindowLevelNormal];
    }
    else if (sender == _btnOnePage) {
        _btnOnePage.selected = YES;
        _btnHalfPage.selected = NO;
    }
    else if (sender == _btnHalfPage) {
        _btnOnePage.selected = NO;
        _btnHalfPage.selected = YES;
    }
    else if (sender == _btnCreate) {
        [self showImagePickerForCamera];
    }
}

- (void)showImagePickerForCamera {
    
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
                    [self showImagePicker:UIImagePickerControllerSourceTypeCamera barButton:nil];
                });
            }
        }];
    }
    else {
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera barButton:nil];
    }
}

- (void)showImagePicker:(UIImagePickerControllerSourceType)soureType barButton:(UIBarButtonItem *)button {
    
    self.imagePickerController = [ScanImagePickerController new];
    _imagePickerController.delegate = self;
    _imagePickerController.modalPresentationStyle = UIModalPresentationCustom;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    _imagePickerController.sourceType = soureType;
    
//    _imagePickerController.modalPresentationStyle = (soureType == UIImagePickerControllerSourceTypeCamera) ? UIModalPresentationFullScreen : UIModalPresentationPopover;

//    UIPopoverPresentationController *presentationController = _imagePickerController.popoverPresentationController;
//    presentationController.barButtonItem = button;
//    presentationController.permittedArrowDirections = UIPopoverArrowDirectionAny; //UIPopoverArrowDirectionUp;// | UIPopoverArrowDirectionDown | UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight,UIPopoverArrowDirectionAny;
//
    if (soureType == UIImagePickerControllerSourceTypeCamera) {
        _imagePickerController.navigationBarHidden = YES;
        _imagePickerController.toolbarHidden = YES;
        _imagePickerController.allowsEditing = NO;
        _imagePickerController.showsCameraControls = NO;
    
        CameraOverlayView *overayView = [[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:self options:nil].firstObject;
        overayView.delegate = self;
        if (_btnOnePage.selected) {
            overayView.type = CAMERAOVERAY_VIEW_TYPE_SINGLE;
        }
        else {
            overayView.type = CAMERAOVERAY_VIEW_TYPE_DOUBLE;
        }
        
        CGRect safeRect = [Utility GetApplicationSafeArea];
        overayView.frame =  CGRectMake(0, 0, safeRect.size.width, safeRect.size.height);
        _imagePickerController.cameraOverlayView = overayView;
        
        CGSize screenSize = safeRect.size;
        CGFloat ratio = 4.0 / 3.0;
        CGFloat carmeraW = floorf(screenSize.width * ratio);
        CGFloat scale = ceilf(screenSize.height / carmeraW);

        _imagePickerController.cameraViewTransform = CGAffineTransformMakeTranslation(0, (screenSize.height - carmeraW) / 2.0);
        _imagePickerController.cameraViewTransform = CGAffineTransformScale(_imagePickerController.cameraViewTransform, scale, scale);
        
    }
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
 
}

#pragma mark -- CameraOverlayViewDelegate
- (void)carmeraOverayViewOnClickedAction:(id)carmeraOverayView btnType:(CAMERAOVERAY_BUTTON_TYPE)btnType data:(id)data{
    if (btnType == CAMERAOVERAY_BUTTON_TYPE_UNDO) {
        NSLog(@"btn action undo");
        [self finishAndUpdate];
    }
    else if (btnType == CAMERAOVERAY_BUTTON_TYPE_SHOT) {
        NSLog(@"btn action shot");
    }
    else if (btnType == CAMERAOVERAY_BUTTON_TYPE_TIMER) {
        if ([data isKindOfClass:[NSNumber class]]) {
            _scheduleTimer = [((NSNumber *) data) integerValue];
        }
        NSLog(@"schedule timer: %ld",_scheduleTimer);
    }
    
}
- (void)finishAndUpdate {
    [_imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}

@end
