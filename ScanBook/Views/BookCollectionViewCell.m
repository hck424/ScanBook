//
//  BookCollectionViewCell.m
//  ScanBook
//
//  Created by 학철 on 2018. 7. 10..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "BookCollectionViewCell.h"
#import "Utility.h"
#import "UIImage+Utility.h"

@implementation BookCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 3.5f;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(8.0f, 8.0f);
    self.layer.shadowOpacity = 0.03f;
    self.layer.shadowRadius = 3.5;
    self.layer.shadowPath = [shadowPath CGPath];
}


- (void)configurationWidthData:(BookInfo *)bookInfo cellType:(CELL_TYPE)cellType {
    if (cellType == CELL_TYPE_EMPTY) {
        _ivBook.image = [UIImage imageNamed:@"empty_book"];
        _lbTitle.text = @"제목";
        _lbDate.text = @"생성 일";
    }
    else {
        _ivBook.image = [UIImage imageNamed:@"empty_book"];
        _lbTitle.text = bookInfo.title;
        _lbDate.text = bookInfo.createDate;
    }
}
@end
