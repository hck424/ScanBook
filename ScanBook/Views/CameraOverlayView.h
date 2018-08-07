//
//  CameraOverlayView.h
//  ScanBook
//
//  Created by 학철 on 2018. 7. 10..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CAMERAOVERAY_VIEW_TYPE) {
    CAMERAOVERAY_VIEW_TYPE_SINGLE,
    CAMERAOVERAY_VIEW_TYPE_DOUBLE
};
typedef NS_ENUM(NSUInteger, CAMERAOVERAY_BUTTON_TYPE) {
    CAMERAOVERAY_BUTTON_TYPE_UNDO,
    CAMERAOVERAY_BUTTON_TYPE_SHOT,
    CAMERAOVERAY_BUTTON_TYPE_TIMER
};
@protocol CameraOverlayViewDelegate <NSObject >
- (void)carmeraOverayViewOnClickedAction:(id)carmeraOverayView btnType:(CAMERAOVERAY_BUTTON_TYPE)btnType data:(id)data;
@end
@interface CameraOverlayView : UIView

@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UIButton *btnUndo;
@property (weak, nonatomic) IBOutlet UIButton *btnShot;
@property (weak, nonatomic) IBOutlet UIButton *btnTimer;
@property (assign, nonatomic) CAMERAOVERAY_VIEW_TYPE type;

@property (weak, nonatomic) id <CameraOverlayViewDelegate> delegate;

@end
