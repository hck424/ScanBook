//
//  CameraOverlayView.h
//  ScanBook
//
//  Created by 학철 on 2018. 7. 10..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeView.h"
#import "CropView.h"
#import "CropInfo.h"

IB_DESIGNABLE

typedef NS_ENUM(NSUInteger, CAMERAOVERAY_BUTTON_TYPE) {
    CAMERAOVERAY_BUTTON_TYPE_UNDO,
    CAMERAOVERAY_BUTTON_TYPE_SHOT,
    CAMERAOVERAY_BUTTON_TYPE_TIMER,
    CAMERAOVERAY_BUTTON_TYPE_MODE
};
@protocol CameraOverlayViewDelegate <NSObject >
- (void)carmeraOverayViewOnClickedButtonAction:(CAMERAOVERAY_BUTTON_TYPE)btnType cropInfo:(CropInfo *)cropInfo;
@end
@interface CameraOverlayView : UIView

@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UIButton *btnUndo;
@property (weak, nonatomic) IBOutlet UIButton *btnShot;
@property (weak, nonatomic) IBOutlet UIButton *btnTimer;
@property (weak, nonatomic) IBOutlet UIButton *btnPage;
@property (weak, nonatomic) IBOutlet CropView *cropView;

- (void)refreshButtonImage;
@property (weak, nonatomic) id <CameraOverlayViewDelegate> delegate;

@end
