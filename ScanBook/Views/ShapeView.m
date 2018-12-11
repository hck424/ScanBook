//
//  ShapeView.m
//  SapeViewTest
//
//  Created by 학철 on 2018. 7. 22..
//  Copyright © 2018년 학철. All rights reserved.
//

#import "ShapeView.h"
#define BTN_WIDTH 15.0
#define RGB(r, g, b)[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a)[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ShapeView ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *arrButton;
@property (strong, nonatomic) NSMutableArray *arrPoint;
@property (strong, nonatomic) NSMutableArray *arrPointOrg;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSeperatorHeight;

@end

@implementation ShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self xibSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self xibSetup];
    }
    
    return self;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"draw rect");
    
    if (_arrPointOrg == nil) {
        self.arrPointOrg = [NSMutableArray array];
        for (UIButton *btn in _arrButton) {
            [_arrPointOrg addObject:[NSValue valueWithCGPoint:btn.center]];
        }
        self.arrPoint = [_arrPointOrg mutableCopy];
    }
    CGContextRef ctxt = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(ctxt, RGBA(0x00, 0x00, 0x0, 0.2).CGColor);
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
    CGContextSetStrokeColorWithColor(ctxt, RGB(0x11, 0x80, 0xff).CGColor);
    CGContextSetLineWidth(ctxt, 2.0);
    CGContextDrawPath(ctxt, kCGPathEOFillStroke);
    
}
- (void)xibSetup {
    
    self.cliperType = CLIPER_TYPE_DOUBLE;
    
    UIView *view = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"ShapeView" owner:self options:nil].firstObject;
    [self addSubview:view];
    view.frame = self.bounds;
    
    self.arrButton = [_arrButton sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"tag" ascending:YES]]];
    [self layoutIfNeeded];

    for (UIButton *btn in _arrButton) {
        [self addPanGesture:btn];
    }

    _seperatorView.hidden = YES;
    if (_cliperType == CLIPER_TYPE_DOUBLE) {
        _seperatorView.hidden = NO;
        _seperatorView.backgroundColor = RGBA(0x00, 0x00, 0x0, 0.2);
        _seperatorView.layer.borderColor = RGB(0x11, 0x80, 0xff).CGColor;
        _seperatorView.layer.borderWidth = 1.0f;

        for (UIButton *btn in _arrButton) {
            NSInteger targetIndex = btn.tag - 100;
            if (targetIndex % 2 == 0) {
                btn.hidden = YES;
            }
        }
    }
    
    [self drawingPolygon];
}

- (void)addPanGesture:(UIView *)view {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [view addGestureRecognizer:panGesture];
}

- (void)didPan:(UIPanGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"%s",__PRETTY_FUNCTION__);
        CGPoint point = [gesture translationInView:gesture.view];
        UIButton *targetBtn = (UIButton*)gesture.view;
        CGPoint transPoint = CGPointMake(targetBtn.center.x + point.x, targetBtn.center.y + point.y);
        
        transPoint = [self bounderCheckPoint:transPoint];
        
        [gesture setTranslation:CGPointZero inView:targetBtn];
        NSLog(@"pont x:%.2lf y:%.2lf, center x:%.2lf y:%.2lf", point.x, point.y, transPoint.x, transPoint.y);
        
        CGPoint recenter = transPoint;
        NSInteger targetIndex = targetBtn.tag - 100;
        
        if (targetIndex == 1 || targetIndex == 5) {
            recenter = CGPointMake(targetBtn.center.x, transPoint.y);
        }
        else if (targetIndex == 3 || targetIndex == 7) {
            recenter = CGPointMake(transPoint.x, targetBtn.center.y);
        }
        
        if (_cliperType == CLIPER_TYPE_SINGLE) {
            
            targetBtn.center = recenter;
            
            [_arrPoint replaceObjectAtIndex:targetIndex withObject:[NSValue valueWithCGPoint:recenter]];
            
            NSInteger tIdx1 = 0;
            NSInteger tIdx2 = 0;
            NSInteger fixIdx1 = 0;
            NSInteger fixIdx2 = 0;
            
            if (targetIndex % 2 == 0) {
                
                if (targetIndex == 0) {
                    //tIdx 0: (1, 7), fixIdx (2, 6)
                    tIdx1 = 1;      tIdx2 = 7;
                    fixIdx1 = 2;    fixIdx2 = 6;
                }
                else if (targetIndex == 2) {
                    tIdx1 = 1;      tIdx2 = 3;
                    fixIdx1 = 0;    fixIdx2 = 4;
                }
                else if (targetIndex == 4) {
                    tIdx1 = 3;      tIdx2 = 5;
                    fixIdx1 = 2;    fixIdx2 = 6;
                }
                else if (targetIndex == 6) {
                    tIdx1 = 5;      tIdx2 = 7;
                    fixIdx1 = 4;    fixIdx2 = 0;
                }
                
                CGPoint fixPoint1 = [[_arrPoint objectAtIndex:fixIdx1] CGPointValue];
                CGPoint fixPoint2 = [[_arrPoint objectAtIndex:fixIdx2] CGPointValue];
                
                CGPoint tPoint1 = [self middlePoint:recenter to:fixPoint1 type:@"A"];
                CGPoint tPoint2 = [self middlePoint:recenter to:fixPoint2 type:@"A"];
                tPoint1 = [self bounderCheckPoint:tPoint1];
                tPoint2 = [self bounderCheckPoint:tPoint2];
                
                [_arrPoint replaceObjectAtIndex:tIdx1 withObject:[NSValue valueWithCGPoint:tPoint1]];
                [_arrPoint replaceObjectAtIndex:tIdx2 withObject:[NSValue valueWithCGPoint:tPoint2]];
                
                UIButton *btn1 = [_arrButton objectAtIndex:tIdx1];
                UIButton *btn2 = [_arrButton objectAtIndex:tIdx2];
                btn1.center = tPoint1;
                btn2.center = tPoint2;
            }
            else  {
                NSInteger sIdx1 = 0;
                NSInteger sIdx2 = 0;
                NSString *type = nil;
                if (targetIndex == 1) {
                    sIdx1 = 0;      sIdx2 = 2;
                    tIdx1 = 7;      tIdx2 = 3;
                    fixIdx1 = 6;    fixIdx2 = 4;
                    type = @"B";
                }
                else if (targetIndex == 3) {
                    sIdx1 = 2;      sIdx2 = 4;
                    tIdx1 = 1;      tIdx2 = 5;
                    fixIdx1 = 0;    fixIdx2 = 6;
                    type = @"C";
                }
                else if (targetIndex == 5) {
                    sIdx1 = 4;      sIdx2 = 6;
                    tIdx1 = 3;      tIdx2 = 7;
                    fixIdx1 = 2;    fixIdx2 = 0;
                    type = @"B";
                }
                else if (targetIndex == 7) {
                    sIdx1 = 6;      sIdx2 = 0;
                    tIdx1 = 5;      tIdx2 = 1;
                    fixIdx1 = 4;    fixIdx2 = 2;
                    type = @"C";
                }
                
                CGPoint sPoint1 = [[_arrPoint objectAtIndex:sIdx1] CGPointValue];
                CGPoint sPoint2 = [[_arrPoint objectAtIndex:sIdx2] CGPointValue];
                if ([type isEqualToString:@"B"]) {
                    sPoint1 = CGPointMake(sPoint1.x, sPoint1.y + point.y);
                    sPoint2 = CGPointMake(sPoint2.x, sPoint2.y + point.y);
                }
                else if ([type isEqualToString:@"C"]) {
                    sPoint1 = CGPointMake(sPoint1.x + point.x, sPoint1.y);
                    sPoint2 = CGPointMake(sPoint2.x + point.x, sPoint2.y);
                }
                
                sPoint1 = [self bounderCheckPoint:sPoint1];
                sPoint2 = [self bounderCheckPoint:sPoint2];
                
                UIButton *btn1 = [_arrButton objectAtIndex:sIdx1];
                UIButton *btn2 = [_arrButton objectAtIndex:sIdx2];
                btn1.center = sPoint1;
                btn2.center = sPoint2;
                
                [_arrPoint replaceObjectAtIndex:sIdx1 withObject:[NSValue valueWithCGPoint:sPoint1]];
                [_arrPoint replaceObjectAtIndex:sIdx2 withObject:[NSValue valueWithCGPoint:sPoint2]];
                
                
                CGPoint fixPoint1 = [[_arrPoint objectAtIndex:fixIdx1] CGPointValue];
                CGPoint fixPoint2 = [[_arrPoint objectAtIndex:fixIdx2] CGPointValue];
                
                CGPoint tPoint1 = [self middlePoint:sPoint1 to:fixPoint1 type:type];
                CGPoint tPoint2 = [self middlePoint:sPoint2 to:fixPoint2 type:type];
                
                tPoint1 = [self bounderCheckPoint:tPoint1];
                tPoint2 = [self bounderCheckPoint:tPoint2];
                
                [_arrPoint replaceObjectAtIndex:tIdx1 withObject:[NSValue valueWithCGPoint:tPoint1]];
                [_arrPoint replaceObjectAtIndex:tIdx2 withObject:[NSValue valueWithCGPoint:tPoint2]];
                
                UIButton *btn3 = [_arrButton objectAtIndex:tIdx1];
                UIButton *btn4 = [_arrButton objectAtIndex:tIdx2];
                btn3.center = tPoint1;
                btn4.center = tPoint2;
                
            }
            
        }
        else if (_cliperType == CLIPER_TYPE_DOUBLE) {
            
            CGPoint tPoint1 = CGPointZero;
            CGPoint tPoint2 = CGPointZero;
            NSInteger tIdx1 = 0;
            NSInteger tIdx2 = 0;
            if (targetIndex == 1 || targetIndex == 5) {
                    //1: (0, 2) 5: (4, 6)
                tIdx1 = targetIndex - 1;      tIdx2 = targetIndex + 1;
                if (targetIndex == 1) {
                    if (recenter.y > self.frame.size.height/2 - 100) {
                        recenter.y = self.frame.size.height/2 - 100;
                    }
                }
                else {
                    if (recenter.y < self.frame.size.height/2 + 100) {
                        recenter.y = self.frame.size.height/2 + 100;
                    }
                }
                
                targetBtn.center = recenter;
                
                tPoint1 = [[_arrPoint objectAtIndex:tIdx1] CGPointValue];
                tPoint1.y = recenter.y;
                
                tPoint2 = [[_arrPoint objectAtIndex:tIdx2] CGPointValue];
                tPoint2.y = recenter.y;
            }
            else if (targetIndex == 3 || targetIndex == 7) {
                //3: (2, 4), 7: (6, 0)
                
                CGRect seperFrame = CGRectZero;
                
                tIdx1 = targetIndex - 1; tIdx2 = targetIndex + 1;
                if (tIdx2 > 7) {
                    tIdx2 = 0;
                }
                if (targetIndex == 7) {
                    if (recenter.x > self.frame.size.width/2 - 100) {
                        recenter.x = self.frame.size.width/2 - 100;
                    }
                    seperFrame = CGRectMake(recenter.x, _seperatorView.frame.origin.y, CGRectGetMaxX(_seperatorView.frame) - recenter.x, _seperatorView.frame.size.height);
                }
                else {
                    if (recenter.x < self.frame.size.width/2 + 100) {
                        recenter.x = self.frame.size.width/2 + 100;
                    }
                    seperFrame = CGRectMake(_seperatorView.frame.origin.x, _seperatorView.frame.origin.y, recenter.x - CGRectGetMinX(_seperatorView.frame), _seperatorView.frame.size.height);
                }
                
                _seperatorView.frame = seperFrame;
                targetBtn.center = recenter;
                
                tPoint1 = [[_arrPoint objectAtIndex:tIdx1] CGPointValue];
                tPoint1.x = recenter.x;
                
                tPoint2 = [[_arrPoint objectAtIndex:tIdx2] CGPointValue];
                tPoint2.x = recenter.x;
            }
            
            [_arrPoint replaceObjectAtIndex:tIdx1 withObject:[NSValue valueWithCGPoint:tPoint1]];
            [_arrPoint replaceObjectAtIndex:tIdx2 withObject:[NSValue valueWithCGPoint:tPoint2]];
            [_arrPoint replaceObjectAtIndex:targetIndex withObject:[NSValue valueWithCGPoint:recenter]];
        }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        
    }
    
    [self drawingPolygon];
}
- (CGPoint)middlePoint:(CGPoint)frome to:(CGPoint)to type:(NSString *)type{
    CGPoint point = CGPointZero;
    CGFloat x = 0;
    CGFloat y = 0;
//    if ([type isEqualToString:@"A"]) {
        x = frome.x + (to.x - frome.x) / 2;
        y = frome.y + (to.y - frome.y) / 2;
//    }
//    else if ([type isEqualToString:@"B"]){
//        x = frome.x;
//        y = frome.y + (to.y - frome.y) / 2;
//    }
//    else if ([type isEqualToString:@"C"]) {
//        x = frome.x + (to.x - frome.x) / 2;
//        y = frome.y;
//    }
    point = CGPointMake(x, y);
    return point;
}
- (CGPoint)bounderCheckPoint:(CGPoint)point {
    
    CGPoint transPoint = point;
    if (transPoint.x + BTN_WIDTH > self.frame.size.width) {
        transPoint.x = self.frame.size.width - BTN_WIDTH;
    } else if (transPoint.x - BTN_WIDTH < 0) {
        transPoint.x = BTN_WIDTH;
    }
    
    if (transPoint.y + BTN_WIDTH > self.frame.size.height) {
        transPoint.y = self.frame.size.height - BTN_WIDTH;
    }
    else if (transPoint.y - BTN_WIDTH < 0) {
        transPoint.y = BTN_WIDTH;
    }
    return transPoint;
}

- (IBAction)onClickButtonAction:(UIButton *)sender {
    
    if (sender.tag == 103 || sender.tag == 107) {
        CGFloat increaseH = 6;
        CGFloat heightSeperatorView = _seperatorView.frame.size.height + increaseH;
        if (heightSeperatorView > 100) {
            heightSeperatorView = 10;
        }
        _seperatorView.frame = CGRectMake(_seperatorView.frame.origin.x, (self.frame.size.height - heightSeperatorView)/2, _seperatorView.frame.size.width, heightSeperatorView);
    }
}
- (void)drawingPolygon {
    NSLog(@"%s",__PRETTY_FUNCTION__);
    [self setNeedsDisplay];
}
@end
