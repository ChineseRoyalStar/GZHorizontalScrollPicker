//
//  GZHorizontalScrollCell.m
//  GZHorizontalScrollPicker
//
//  Created by armada on 2016/11/10.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import "GZHorizontalScrollCell.h"

@implementation GZHorizontalScrollCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
     
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        [self.contentView addSubview:self.titleLabel];
    
    }
    return self;
}

- (UILabel *)titleLabel {
    
    if(!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:[UIFont systemFontOfSize:20]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:[UIColor blackColor]];
    }
    
    return _titleLabel;
}


@end
