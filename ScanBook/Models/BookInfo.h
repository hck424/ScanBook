//
//  BookInfo.h
//  ScanBook
//
//  Created by 학철 on 2018. 7. 10..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookInfo : NSObject
@property (nonatomic, strong) NSString *bookId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *createDate;
@end
