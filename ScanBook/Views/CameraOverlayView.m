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
@property (nonatomic, strong) NSArray *arrTimerImgName;
@property (nonatomic, assign) NSInteger curSecond;
@property (nonatomic, strong) NSString *pageType;
@property (nonatomic, strong) NSMutableDictionary *userInfo;

@end

@implementation CameraOverlayView
- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self refreshButtonImage];
    [_btnPage setImage:[UIImage imageNamed:@"one_page" withTintColor:DEFAULT_COLOR_BLUE] forState:UIControlStateNormal];
    [_btnPage setImage:[UIImage imageNamed:@"two_page" withTintColor:DEFAULT_COLOR_BLUE] forState:UIControlStateSelected];
    self.pageType = @"1";
    self.userInfo = [NSMutableDictionary dictionary];
    [_userInfo setObject:_pageType forKey:@"page_type"];
}

- (void)refreshButtonImage {
    
    self.curSecond = 0;
    [_userInfo setObject:[NSNumber numberWithInteger:_curSecond] forKey:@"timer"];
    if (_shapeView.cliperType == CLIPER_TYPE_SINGLE) {
        self.arrTimerImgName = [NSArray arrayWithObjects:@"timer_0", @"timer_1", @"timer_2", @"timer_3", @"timer_4", @"timer_5", nil];
        
        [_btnUndo setImage:[UIImage imageNamed:@"undo" withTintColor:DEFAULT_COLOR_BLUE] forState:UIControlStateNormal];
        [_btnShot setImage:[UIImage imageNamed:@"screenshot" withTintColor:DEFAULT_COLOR_BLUE] forState:UIControlStateNormal];
        
        UIImage *imgTime = [UIImage imageNamed:[_arrTimerImgName objectAtIndex:_curSecond]
                                 withTintColor:DEFAULT_COLOR_BLUE];
        [_btnTimer setImage:imgTime forState:UIControlStateNormal];
        
    }
    else if (_shapeView.cliperType == CLIPER_TYPE_DOUBLE) {
        
        self.arrTimerImgName = [NSArray arrayWithObjects:@"timer_0_h", @"timer_1_h", @"timer_2_h", @"timer_3_h", @"timer_4_h", @"timer_5_h", nil];
        
        [_btnUndo setImage:[UIImage imageNamed:@"undo_h" withTintColor:DEFAULT_COLOR_BLUE] forState:UIControlStateNormal];
        [_btnShot setImage:[UIImage imageNamed:@"screenshot_h" withTintColor:DEFAULT_COLOR_BLUE] forState:UIControlStateNormal];
        
        UIImage *imgTime = [UIImage imageNamed:[_arrTimerImgName objectAtIndex:_curSecond]
                                 withTintColor:DEFAULT_COLOR_BLUE];
        
        [_btnTimer setImage:imgTime forState:UIControlStateNormal];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [_shapeView refreshViews];
}

- (IBAction)onClickButtonAcion:(UIButton *)sender {
    if (sender == _btnUndo && [self.delegate respondsToSelector:@selector(carmeraOverayViewOnClickedButtonAction:userInfo:)]) {
        [_delegate carmeraOverayViewOnClickedButtonAction:CAMERAOVERAY_BUTTON_TYPE_UNDO userInfo:nil];
    }
    else if (sender == _btnShot && [self.delegate respondsToSelector:@selector(carmeraOverayViewOnClickedButtonAction:userInfo:)]) {
        
        if (_shapeView.arrPoint != nil) {
            [_userInfo setObject:_shapeView.arrPoint forKey:@"edges_point"];
        }
        NSNumber *seperNum = [NSNumber numberWithFloat:_shapeView.heightSeperator];
        [_userInfo setObject:seperNum forKey:@"height_sepeartor"];
        
        [_delegate carmeraOverayViewOnClickedButtonAction:CAMERAOVERAY_BUTTON_TYPE_SHOT userInfo:_userInfo];
    }
    else if (sender == _btnTimer) {
        _curSecond++;
        if (_curSecond > 5) {
            _curSecond = 0;
        }
        UIImage *imgTime = [UIImage imageNamed:[_arrTimerImgName objectAtIndex:_curSecond]
                                 withTintColor:DEFAULT_COLOR_BLUE];
        
        [_btnTimer setImage:imgTime forState:UIControlStateNormal];
        [_userInfo setObject:[NSNumber numberWithInteger:_curSecond] forKey:@"timer"];
    }
    else if (_btnPage == sender) {
        sender.selected = !sender.selected;
        
        if (sender.selected) {
            _shapeView.cliperType = CLIPER_TYPE_DOUBLE;
            self.pageType = @"2";
        } else {
            _shapeView.cliperType = CLIPER_TYPE_SINGLE;
            self.pageType = @"1";
        }
        [_userInfo setObject:_pageType forKey:@"page_type"];
        [_shapeView refreshViews];
        [self refreshButtonImage];
    }
}

@end
