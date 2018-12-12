//
//  CropInfo.m
//  ScanBook
//
//  Created by 학철 on 12/12/2018.
//  Copyright © 2018 학철. All rights reserved.
//

#import "CropInfo.h"

@implementation CropInfo
- (NSString *)description {
    NSMutableString *des = [NSMutableString stringWithString:[NSString stringWithFormat:@"page_type : %@\r", _page_type]];
    [des appendString:[NSString stringWithFormat:@"timer : %@\r", _timer]];
    [des appendString:[NSString stringWithFormat:@"height_sepeartor : %@\r", _height_sepeartor]];
    [des appendString:[NSString stringWithFormat:@"arrPoint : %@\r", _arrPoint]];
    
    return des;
}
@end
