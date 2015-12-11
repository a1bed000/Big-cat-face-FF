//
//  CartVC.m
//  YYSportsProject
//
//  Created by 江 on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "CartVC.h"

@interface CartVC ()

@end

@implementation CartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configUI];
    [self loadData];
}
#pragma mark - 布局
- (void)configNav {
    self.navigationItem.title = @"购物车";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:kRGB(206, 0, 0)];
}
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma  mark - 加载数据
- (void)loadData {
    
}

@end
