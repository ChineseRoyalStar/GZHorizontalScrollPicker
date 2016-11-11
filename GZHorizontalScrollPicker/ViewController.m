//
//  ViewController.m
//  GZHorizontalScrollPicker
//
//  Created by armada on 2016/11/10.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import "ViewController.h"

#import "GZHorizontalScrollPicker.h"

#import "GZTickMarkScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GZHorizontalScrollPicker *picker = [[GZHorizontalScrollPicker alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
    
    for(int i=1;i<13;i++) {
        
        NSNumber *number = [NSNumber numberWithInt:i];
        
        [picker.dataSource addObject:number.stringValue];
    }
                               
    [self.view addSubview:picker];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
