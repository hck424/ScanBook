//
//  CropView.h
//  ScanBook
//
//  Created by 학철 on 12/12/2018.
//  Copyright © 2018 학철. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
typedef enum {
    CROP_TYPE_SINGLE,
    CROP_TYPE_DOUBLE
} CROP_TYPE;

@interface CropView : UIView
@property (nonatomic, assign) CROP_TYPE type;
@property (strong, nonatomic) NSMutableArray *arrPoint;
@property (assign, nonatomic) CGFloat height_seperator;
- (void)refreshComponet;
@end

NS_ASSUME_NONNULL_END
