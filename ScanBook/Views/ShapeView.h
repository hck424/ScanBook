//
//  CameraOverlayView.h
//  SapeViewTest
//
//  Created by 학철 on 2018. 7. 22..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
typedef enum {
    CLIPER_TYPE_SINGLE,
    CLIPER_TYPE_DOUBLE
} CLIPER_TYPE;
@interface ShapeView : UIView
@property (assign, nonatomic) CLIPER_TYPE cliperType;
@end
