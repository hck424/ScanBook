//
//  CameraOverlayView.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 10..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "CameraOverlayView.h"
@interface CameraOverlayView ()
@property (nonatomic, strong) NSArray *imgBtnTimers;
@end

@implementation CameraOverlayView
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)barBtnDone:(UIBarButtonItem *)sender {
    if (sender == _btnUndo) {
        if (self.carmeraOverayViewBtnAction) {
            self.carmeraOverayViewBtnAction(sender, 0);
        }
    }
    else if (sender == _btnShot) {
        if (self.carmeraOverayViewBtnAction) {
            self.carmeraOverayViewBtnAction(sender, 1);
        }
    }
    else if (sender == _btnTimer) {
        
    }
}

@end
