//
//  CropInfo.h
//  ScanBook
//
//  Created by 학철 on 12/12/2018.
//  Copyright © 2018 학철. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CropInfo : NSObject
@property (nonatomic, strong) NSString *timer;
@property (nonatomic, strong) NSMutableArray *arrPoint;
@property (nonatomic, strong) NSString *page_type;
@property (nonatomic, strong) NSString *height_sepeartor;
@end

NS_ASSUME_NONNULL_END
