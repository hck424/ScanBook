//
//  BookCollectionViewCell.h
//  ScanBook
//
//  Created by 학철 on 2018. 7. 10..
//  Copyright © 2018년 학철. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookInfo.h"
typedef NS_ENUM(NSInteger, CELL_TYPE)  {
    CELL_TYPE_EMPTY,
    CELL_TYPE_NORMAL
};


@interface BookCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ivBook;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;


- (void)configurationWidthData:(BookInfo *)bookInfo cellType:(CELL_TYPE)cellType;
@end
