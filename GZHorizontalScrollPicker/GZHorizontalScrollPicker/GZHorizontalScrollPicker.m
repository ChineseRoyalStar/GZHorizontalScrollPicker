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
        _scaleScroll = [[GZTickMarkScrollView alloc]initWithFrame:rect withContentSize:CGSizeMake(rect.size.width*1.5, rect.size.height)];
        _scaleScroll.delegate = self;
        _scaleScroll.scrollEnabled = NO;
        [self addSubview:_scaleScroll];
        
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
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reusedIdentifier = @"gzcell";
    
    GZHorizontalScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusedIdentifier forIndexPath:indexPath];
    
    if(indexPath.row == self.selectedItemIndex) {
        
        [cell.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
    }else {
        
        [cell.titleLabel setFont:[UIFont systemFontOfSize:20]];
    }
    
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = title;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //GZHorizontalScrollCell *previousSelectedItem = (GZHorizontalScrollCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedItemIndex inSection:0]];
    
    //if(previousSelectedItem) {
        
    //    [previousSelectedItem.titleLabel setFont:[UIFont systemFontOfSize:20]];
    //}
    
   // GZHorizontalScrollCell *selectedItem = (GZHorizontalScrollCell *)[collectionView cellForItemAtIndexPath:indexPath];
   // [selectedItem.titleLabel setFont:[UIFont boldSystemFontOfSize:25]];
    self.selectedItemIndex = indexPath.row;
    
   [self.pickerView reloadData];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(scrollView == self.pickerView) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.scaleScroll.contentOffset = self.pickerView.contentOffset;
        }];
    }else if(scrollView == self.scaleScroll) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.pickerView.contentOffset = self.scaleScroll.contentOffset;
        }];
    }
}


@end
