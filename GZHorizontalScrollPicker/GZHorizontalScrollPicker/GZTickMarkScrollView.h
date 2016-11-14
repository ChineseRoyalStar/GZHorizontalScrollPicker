//
//  GZTickMarkScrollView.h
//  GZHorizontalScrollPicker
//
//  Created by armada on 2016/11/10.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GZTickMarkScrollView : UIScrollView

@property(nonatomic,strong) NSMutableArray<NSValue *> *pointArray;

@property(nonatomic,strong) UIView *blackScaleView;

- (instancetype)initWithFrame:(CGRect)frame withContentSize:(CGSize) contentSize;


@end
