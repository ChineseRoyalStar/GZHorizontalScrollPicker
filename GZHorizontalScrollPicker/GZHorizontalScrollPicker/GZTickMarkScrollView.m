//
//  GZTickMarkScrollView.m
//  GZHorizontalScrollPicker
//
//  Created by armada on 2016/11/10.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import "GZTickMarkScrollView.h"


#define kScaleSpacing [UIScreen mainScreen].bounds.size.width/9

@implementation GZTickMarkScrollView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (instancetype)initWithFrame:(CGRect)frame withContentSize:(CGSize) contentSize{
    
    if(self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentSize = contentSize;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self createHorizontalAndScaleLine];
    }
    
    return self;
}

- (NSMutableArray *)pointArray {
    
    if(!_pointArray) {
        _pointArray = [NSMutableArray array];
        
    }
    return _pointArray;
}

- (UIView *)blackScaleView {
    
    if(!_blackScaleView) {
        
        _blackScaleView = [[UIView alloc]init];
        
        _blackScaleView.backgroundColor = [UIColor blackColor];
    }
    return _blackScaleView;
}

/**
 * @绘制刻度线和底线
 */

- (void)createHorizontalAndScaleLine {
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    
    shape.lineWidth = 3.0f;
    
    shape.strokeColor = [UIColor blackColor].CGColor;
    
    //绘制底部边线
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint leadingPoint = CGPointMake(0, self.frame.size.height);
    
    CGPoint trailingPoint = CGPointMake(self.contentSize.width, self.frame.size.height);
    
    [path moveToPoint:leadingPoint];
    
    [path addLineToPoint:trailingPoint];
    
    path.lineCapStyle = kCGLineCapRound;
    
    //循环绘制刻度线
    for(int i=1; i<10; i++){
        
        CGPoint startPoint = CGPointMake(kScaleSpacing*i-25, self.frame.size.height-5);
        CGPoint endPoint = CGPointMake(kScaleSpacing*i-25, self.frame.size.height-25);
        
        [self.pointArray addObject:[NSValue valueWithCGPoint:startPoint]];
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
    }
    
    shape.path = path.CGPath;
    [self.layer addSublayer:shape];
    
    CGPoint basePoint = [self.pointArray objectAtIndex:4].CGPointValue;
    CGFloat width = 6;
    CGFloat height = 30;
    CGFloat originX = basePoint.x - width/2;
    CGFloat originY = basePoint.y - height;
    self.blackScaleView.frame = CGRectMake(originX, originY, width, height);
    [self addSubview:self.blackScaleView];
}

- (void)drawRect:(CGRect)rect {
    
    
    
}


@end
