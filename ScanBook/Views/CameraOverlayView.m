//
//  CameraOverlayView.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 10..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "CameraOverlayView.h"
#import "UIColor+Utility.h"
#import "UIImage+Utility.h"
#import "Define.h"

@interface CameraOverlayView ()
@property (nonatomic, strong) NSArray *imgBtnTimers;
@property (nonatomic, assign) NSInteger curSecond;
@end

@implementation CameraOverlayView
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setType:(CAMERAOVERAY_VIEW_TYPE)type {
    self.curSecond = 0;
    
    _type = type;
    if (_type == CAMERAOVERAY_VIEW_TYPE_SINGLE) {
        self.imgBtnTimers = [NSArray arrayWithObjects:@"timer_0", @"timer_1", @"timer_2", @"timer_3", @"timer_4", @"timer_5", nil];
        
        [_btnUndo setImage:[UIImage imageNamed:@"undo" withTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_btnShot setImage:[UIImage imageNamed:@"screenshot" withTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        
        UIImage *imgTime = [UIImage imageNamed:[_imgBtnTimers objectAtIndex:_curSecond]
                                 withTintColor:[UIColor whiteColor]];
        [_btnTimer setImage:imgTime forState:UIControlStateNormal];
    }
    else if (_type == CAMERAOVERAY_VIEW_TYPE_DOUBLE) {
        
        self.imgBtnTimers = [NSArray arrayWithObjects:@"timer_0_h", @"timer_1_h", @"timer_2_h", @"timer_3_h", @"timer_4_h", @"timer_5_h", nil];
        
        [_btnUndo setImage:[UIImage imageNamed:@"undo_h" withTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_btnShot setImage:[UIImage imageNamed:@"screenshot_h" withTintColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        
        UIImage *imgTime = [UIImage imageNamed:[_imgBtnTimers objectAtIndex:_curSecond]
                                 withTintColor:[UIColor whiteColor]];
        
        [_btnTimer setImage:imgTime forState:UIControlStateNormal];
    }
    
}

- (IBAction)onClickButtonAcion:(UIButton *)sender {
    if (sender == _btnUndo && [self.delegate respondsToSelector:@selector(carmeraOverayViewOnClickedAction:btnType:data:)]) {
        [_delegate carmeraOverayViewOnClickedAction:self btnType:CAMERAOVERAY_BUTTON_TYPE_UNDO data:nil];
    }
    else if (sender == _btnShot && [self.delegate respondsToSelector:@selector(carmeraOverayViewOnClickedAction:btnType:data:)]) {
        [_delegate carmeraOverayViewOnClickedAction:self btnType:CAMERAOVERAY_BUTTON_TYPE_SHOT data:nil];
    }
    else if (sender == _btnTimer) {
        _curSecond++;
        if (_curSecond > 5) {
            _curSecond = 0;
        }
        UIImage *imgTime = [UIImage imageNamed:[_imgBtnTimers objectAtIndex:_curSecond]
                                 withTintColor:[UIColor whiteColor]];
        
        [_btnTimer setImage:imgTime forState:UIControlStateNormal];
        
        if ([self.delegate respondsToSelector:@selector(carmeraOverayViewOnClickedAction:btnType:data:)]) {
            [_delegate carmeraOverayViewOnClickedAction:self btnType:CAMERAOVERAY_BUTTON_TYPE_TIMER data:[NSNumber numberWithInt:(int)_curSecond]];
        }
    }
}

@end
