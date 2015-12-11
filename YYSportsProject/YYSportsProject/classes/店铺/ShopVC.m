//
//  ShopVC.m
//  YYSportsProject
//
//  Created by 江 on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ShopVC.h"

@interface ShopVC ()

@end

@implementation ShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configUI];
    [self loadData];
}
#pragma mark - 布局
- (void)configNav {
    self.navigationItem.title = @"店铺";
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


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    ItemListVC * itemListVC = [[ItemListVC alloc] init];
    itemListVC.hidesBottomBarWhenPushed = YES;
    

    itemListVC.itemSearch.sort = 0;
    itemListVC.itemSearch.keyword = @"阿迪";
    itemListVC.itemSearch.page.pageSize = 10;
    itemListVC.itemSearch.page.currentPage = 1;
    itemListVC.itemSearch.classifyId = @"35";
    
    itemListVC.userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] integerValue];
    itemListVC.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [self.navigationController pushViewController:itemListVC animated:YES];
}

@end
