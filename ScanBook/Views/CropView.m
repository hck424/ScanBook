//
//  CropView.m
//  ScanBook
//
//  Created by 학철 on 12/12/2018.
//  Copyright © 2018 학철. All rights reserved.
//
/*
 single             double
  ___________        _________
 |     |     |      |         |
 |  1  |  2  |      |    1    |
 |_____|_____|      |_________|
 |     |     |      |         |
 |  4  |  3  |      |    2    |
 |_____|_____|      |_________|
 
 */

#import "CropView.h"
#import "Define.h"

#define SPACE_BOUND     10

@interface CropView ()
@property (strong, nonatomic) NSMutableArray *arrPointOrg;
@property (nonatomic, assign) CGRect area1;
@property (nonatomic, assign) CGRect area2;
@property (nonatomic, assign) CGRect area3;
@property (nonatomic, assign) CGRect area4;

@end
@implementation CropView
- (instancetype)initWithFrame:(CGRect)frame  {
    if (self = [super initWithFrame:frame]) {
        self.type = CROP_TYPE_SINGLE;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanGesture:)];
    [self addGestureRecognizer:pangesture];
    self.userInteractionEnabled = YES;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (_arrPoint == nil) {
        return;
    }
    
    CGContextRef ctxt = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctxt, RGBA(0x00, 0x00, 0x00, 0.6).CGColor);
    CGContextFillRect(ctxt, rect);
    
    CGMutablePathRef path = CGPathCreateMutable();
    for (NSInteger i = 0; i < _arrPoint.count; i++) {
        NSValue *val = [_arrPoint objectAtIndex:i];
        CGPoint point = [val CGPointValue];
        if (i == 0) {
            CGPathMoveToPoint(path, NULL, point.x, point.y);
        } else {
            CGPathAddLineToPoint(path, NULL, point.x, point.y);
        }
    }
    NSValue *val = [_arrPoint objectAtIndex:0];
    CGPoint point = [val CGPointValue];
    CGPathAddLineToPoint(path, NULL, point.x, point.y);
    
    CGContextClosePath(ctxt);
    CGContextAddPath(ctxt, path);
    CGContextClip(ctxt);
    CGContextClearRect(ctxt, rect);
    CGContextSetFillColorWithColor(ctxt, [UIColor clearColor].CGColor);
    
    
    CGContextAddPath(ctxt, path);
    CGContextSetStrokeColorWithColor(ctxt, DEFAULT_COLOR_BLUE.CGColor);
    CGContextSetLineWidth(ctxt, 2.0);
    CGContextDrawPath(ctxt, kCGPathEOFillStroke);
}

- (void)refreshComponet {
    if (_arrPointOrg == nil) {
        self.arrPointOrg = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            CGFloat posX = 0;
            CGFloat posY = 0;
            if (i == 0) {
                posX = SPACE_BOUND;
                posY = SPACE_BOUND;
            } else if (i == 1) {
                posX = self.frame.size.width - SPACE_BOUND;
                posY = SPACE_BOUND;
            } else if (i == 2) {
                posX = self.frame.size.width - SPACE_BOUND;
                posY = self.frame.size.height - SPACE_BOUND;
            } else {
                posX = SPACE_BOUND;
                posY = self.frame.size.height - SPACE_BOUND;
            }
            CGPoint point = CGPointMake(posX, posY);
            [_arrPointOrg addObject:[NSValue valueWithCGPoint:point]];
        }
        _area1 = CGRectMake(SPACE_BOUND, SPACE_BOUND, self.frame.size.width/2 - SPACE_BOUND, self.frame.size.height/2 - SPACE_BOUND);
        _area2 = CGRectMake(self.frame.size.width/2, SPACE_BOUND, self.frame.size.width/2 - SPACE_BOUND, self.frame.size.height/2 - SPACE_BOUND);
        _area3 = CGRectMake(self.frame.size.width/2, self.frame.size.height/2, self.frame.size.width/2 - SPACE_BOUND, self.frame.size.height/2 - SPACE_BOUND);
        _area4 = CGRectMake(SPACE_BOUND, self.frame.size.height/2, self.frame.size.width/2 - SPACE_BOUND, self.frame.size.height/2 - SPACE_BOUND);
        
//        NSLog(@"area 1 = %@", NSStringFromCGRect(_area1));
//        NSLog(@"area 2 = %@", NSStringFromCGRect(_area2));
//        NSLog(@"area 3 = %@", NSStringFromCGRect(_area3));
//        NSLog(@"area 4 = %@", NSStringFromCGRect(_area4));
    }
    
    if (_arrPoint == nil) {
        self.arrPoint = [NSMutableArray arrayWithArray:_arrPointOrg];
    }
    
    if (_type == CROP_TYPE_SINGLE) {
        
    }
    else if (_type == CROP_TYPE_DOUBLE) {
        
    }
    
    [self drawing];
    
}
- (void)drawing {
    [self setNeedsDisplay];
}
- (void)didPanGesture:(UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [gesture translationInView:gesture.view];
        CGPoint location = [gesture locationInView:gesture.view];
        
        [gesture setTranslation:CGPointZero inView:gesture.view];
        
        NSLog(@"pan point = %@, location = %@", NSStringFromCGPoint(point), NSStringFromCGPoint(location));
        if (_type == CROP_TYPE_SINGLE) {
            CGFloat posX = 0;
            CGFloat posY = 0;
            CGPoint spoint = CGPointZero;
            
            NSInteger idx = 0;
            if (CGRectContainsPoint(_area1, location)) {
                idx = 0;
                spoint = [[_arrPoint objectAtIndex:idx] CGPointValue];
                posX = spoint.x + point.x;
                posY = spoint.y + point.y;
            } else if (CGRectContainsPoint(_area2, location)) {
                idx = 1;
                spoint = [[_arrPoint objectAtIndex:idx] CGPointValue];
                posX = spoint.x + point.x;
                posY = spoint.y + point.y;
            } else if (CGRectContainsPoint(_area3, location)) {
                idx = 2;
                spoint = [[_arrPoint objectAtIndex:idx] CGPointValue];
                posX = spoint.x + point.x;
                posY = spoint.y + point.y;
            } else if (CGRectContainsPoint(_area4, location)) {
                idx = 3;
                spoint = [[_arrPoint objectAtIndex:idx] CGPointValue];
                posX = spoint.x + point.x;
                posY = spoint.y + point.y;
            }
            else {
                posX = 0;
                posY = 0;
            }
            
            if (posX > 0 || posY > 0) {
                spoint = CGPointMake(posX, posY);
                [_arrPoint replaceObjectAtIndex:idx withObject:[NSValue valueWithCGPoint:[self boundaryCheckPoint:spoint]]];
            }
        }
        
        [self drawing];
    }
}

- (CGPoint)boundaryCheckPoint:(CGPoint)point {
    
    CGFloat posX = point.x;
    CGFloat posY = point.y;
    
    if (point.x < SPACE_BOUND) {
        posX = SPACE_BOUND;
    }
    if (point.x > self.frame.size.width - SPACE_BOUND) {
        posX = self.frame.size.width - SPACE_BOUND;
    }
    
    if (point.y < SPACE_BOUND) {
        posY = SPACE_BOUND;
    }
    if (point.y > self.frame.size.height - SPACE_BOUND) {
        posY = self.frame.size.height - SPACE_BOUND;
    }
    
    return CGPointMake(posX, posY);
}

@end
