//
//  GZHorizontalScrollPicker.m
//  GZHorizontalScrollPicker
//
//  Created by armada on 2016/11/10.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import "GZHorizontalScrollPicker.h"
#import "GZHorizontalScrollCell.h"
#import "GZTickMarkScrollView.h"

const CGFloat kPadding = 20;

#define kCellWidth [UIScreen mainScreen].bounds.size.width/9

@interface GZHorizontalScrollPicker ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

/**
 * @ 滚动选择栏
 */
@property(nonatomic,strong) UICollectionView *pickerView;

/**
 * @ 刻度栏
 */
@property(nonatomic,strong) GZTickMarkScrollView *scaleScroll;

/**
 * @ 当前被选中的选项
 */
@property(nonatomic,assign) NSInteger selectedItemIndex;

@property(nonatomic,strong) UIView *backgroundView;

@end

@implementation GZHorizontalScrollPicker

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        self.selectedItemIndex = 4;
        
        //Create flowlayout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kCellWidth,frame.size.height/3);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;

        //Create collectionview with flowlayout
        
        _pickerView =  [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/3) collectionViewLayout:layout];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_pickerView registerClass:[GZHorizontalScrollCell class]
        forCellWithReuseIdentifier:@"gzcell"];
        _pickerView.showsVerticalScrollIndicator = NO;
        _pickerView.showsHorizontalScrollIndicator = NO;
        _pickerView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_pickerView];
        
        //Create GZTickMarkScrollView
        CGRect rect = CGRectMake(0, self.pickerView.frame.size.height, frame.size.width,frame.size.height/3*2);

        _scaleScroll = [[GZTickMarkScrollView alloc]initWithFrame:rect withContentSize:CGSizeMake(rect.size.width, rect.size.height)];
        _scaleScroll.delegate = self;
        _scaleScroll.scrollEnabled = NO;
        [self addSubview:_scaleScroll];
        
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        _backgroundView.backgroundColor = [UIColor clearColor];
        CGPoint center = CGPointMake(self.center.x, 20);
        _backgroundView.center = center;
        [self addSubview:_backgroundView];
    }
    
    return self;
}

- (NSMutableArray *)dataSource {
    
    if(!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1000;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger currentIndexInArray = indexPath.row % self.dataSource.count;
    
    static NSString *reusedIdentifier = @"gzcell";
    
    GZHorizontalScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedIdentifier forIndexPath:indexPath];
    
    if(currentIndexInArray == self.selectedItemIndex) {
        
        [cell.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
    }else {
        
        [cell.titleLabel setFont:[UIFont systemFontOfSize:20]];
    }
    
    NSString *title = [self.dataSource objectAtIndex:currentIndexInArray];
    
    cell.titleLabel.text = title;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    self.selectedItemIndex = indexPath.row % self.dataSource.count;
    
   [self.pickerView reloadData];
    
}
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(scrollView == self.pickerView) {
        
        GZHorizontalScrollCell *perviousCenterCell = (GZHorizontalScrollCell *)[self.pickerView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedItemIndex inSection:0]];
        [perviousCenterCell.titleLabel setFont:[UIFont systemFontOfSize:20]];
        
        int centerIndex = (int)[NSNumber numberWithDouble:(scrollView.contentOffset.x+self.pickerView.center.x)].integerValue/[NSNumber numberWithDouble:kCellWidth].integerValue;
        
        GZHorizontalScrollCell *currentCenterCell = (GZHorizontalScrollCell *)[self.pickerView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:centerIndex inSection:0]];
        [currentCenterCell.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
        self.selectedItemIndex = centerIndex;
    }

}

//结束滑动回调
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if(scrollView == self.pickerView) {
        
        int x = round(self.pickerView.contentOffset.x)/round(kCellWidth);
        
        self.pickerView.contentOffset = CGPointMake(x*kCellWidth, 0);
    }
}

//结束拖拽回调
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if(scrollView == self.pickerView) {
        
        int x = round((float)round(self.pickerView.contentOffset.x)/round(kCellWidth));
        
        self.pickerView.contentOffset = CGPointMake(x*kCellWidth, 0);
    }
}

@end
