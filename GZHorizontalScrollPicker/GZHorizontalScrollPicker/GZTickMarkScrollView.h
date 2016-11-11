//
//  GZTickMarkScrollView.h
//  GZHorizontalScrollPicker
//
//  Created by armada on 2016/11/10.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GZTickMarkScrollView : UIScrollView

@property(nonatomic,strong) NSMutableArray *pointArray;

- (instancetype)initWithFrame:(CGRect)frame withContentSize:(CGSize) contentSize;


@end
