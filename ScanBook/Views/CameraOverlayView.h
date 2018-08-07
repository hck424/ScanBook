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

@protocol CameraOverlayViewDelegate <NSObject >

@end
@interface CameraOverlayView : UIView

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnUndo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnShot;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnTimer;
@property (assign, nonatomic) CAMERAOVERAY_VIEW_TYPE type;

@property (nonatomic, copy) void (^carmeraOverayViewBtnAction) (id sender, NSInteger btnIdx);
- (void)setCarmeraOverayViewBtnAction:(void (^)(id sender, NSInteger btnIndex))carmeraOverayViewBtnAction;

@end
