//
//  ItemDetailVC.m
//  YYSportsProject
//
//  Created by k on 15/11/18.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemDetailVC.h"

@interface ItemDetailVC ()
{
    UIScrollView * _scrollView;
    
    SDCycleScrollView * _adScrollView;
    UILabel * _nameLabel;
    UILabel * _preferentialPriceLabel;
    UILabel * _yyPriceLabel;
    UILabel * _preferentInfoLabel;
    
    UILabel * _hasLoginLabel;
    
    UILabel * _itemParamsLabel;
    UILabel * _commentLabel;
    UILabel * _continueLabel;
}
@end

@implementation ItemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configNav];
    [self loadData];
}
#pragma mark - 布局
- (void)configNav {
    self.navigationItem.title = @"商品详情";
    UIButton * leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    leftBtn.frame = CGRectMake(0, 0, 28, 28);
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn setImage:[UIImage imageNamed:@"navigationBar_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)configUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = kWhite(0.9);
    [self.view addSubview:_scrollView];
    _adScrollView = [[SDCycleScrollView alloc] initWithFrame:(CGRectMake(0, 0, kScreenW, kScreenW))];
    [_scrollView addSubview:_adScrollView];
    UIView * infoView = [[UIView alloc] init];
    [self.view addSubview:infoView];
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 2;
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [infoView addSubview:_nameLabel];
    _preferentInfoLabel = [[UILabel alloc] init];
    [infoView addSubview:_preferentInfoLabel];
    _yyPriceLabel = [[UILabel alloc] init];
    [infoView addSubview:_yyPriceLabel];
    
    _preferentInfoLabel = [[UILabel alloc] init];
    [self.view addSubview:_preferentInfoLabel];
    
    _itemParamsLabel = [[UILabel alloc] init];
    [self.view addSubview:_itemParamsLabel];
    
    _commentLabel = [[UILabel alloc] init];
    [self.view addSubview:_commentLabel];
    
    _hasLoginLabel = [[UILabel alloc] init];
    [self.view addSubview:_hasLoginLabel];
    
    
    [_adScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_scrollView);
        make.height.mas_equalTo(_adScrollView.mas_width);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_adScrollView.mas_bottom).offset(1);
        make.left.right.equalTo(_adScrollView);
        make.height.mas_equalTo(38);
    }];
    [_preferentialPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(2);
        make.left.equalTo(_nameLabel);
    }];
    [_yyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_preferentialPriceLabel);
        make.left.equalTo(_preferentialPriceLabel.mas_right).offset(5);
    }];
    [_hasLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [_preferentInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [_itemParamsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    
}
#pragma mark - 加载数据
- (void)loadData {
    
}
#pragma mark - set
- (void)setModel:(ItemDetailModel *)model {
    _model = model;
}
@end
