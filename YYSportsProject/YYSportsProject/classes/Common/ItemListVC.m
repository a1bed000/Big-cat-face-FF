//
//  ItemListVC.m
//  YYSportsProject
//
//  Created by 江 on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemListVC.h"
#import "ItemListCell.h"
#import "ItemListCell2.h"

#define kMarginX 4.0

@interface ItemListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
{
    UICollectionView * _collectionView;
    NSMutableArray * _dataArr;
    
    NSInteger _column;
    NSArray * _btnArr;
    
    UIButton * _topBtn;
    UILabel * _topLable;
    
    BOOL _priceUp;
    BOOL _numUp;
    
    NSInteger _totalPage;
    NSInteger _totalSize;
}
@end

@implementation ItemListVC
- (instancetype)init {
    if (self = [super init]) {
        _itemSearch = [[ItemListRequestModel alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    _column = 2;
    _totalPage = MAXFLOAT;
    [self configNav];
    [self configUI];
    [self loadDataWithPage:_itemSearch.page.currentPage];
    [GiFHUD showWithOverlay];
}
#pragma mark - 加载数据
- (void)loadDataWithPage:(NSInteger)page {
    if (page > _totalPage) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有更多了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [_collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    NSMutableDictionary * dictM = [NSMutableDictionary dictionary];
    
    [dictM setObject:[NSNumber numberWithInteger:_userId] forKey:@"userId"];
    [dictM setObject:_token forKey:@"token"];
    
    
    NSMutableDictionary * temDict = _itemSearch.keyValues;  //处理string类型至num
    if (temDict[@"classifyId"]) {
        [temDict setObject:[NSNumber numberWithInteger:[temDict[@"classifyId"] integerValue]] forKey:@"classifyId"];
    }
    [dictM setObject:temDict forKey:@"itemSearch"];
    
    [YYTool postDataWithUrl:kItemListUrl Body:dictM success:^(NSDictionary *jsonDict) {
        
        NSLog(@"%@",jsonDict);
        //请求完成后
        if (_itemSearch.page.currentPage == 1) {
            [_collectionView setContentOffset:(CGPointMake(0, 0)) animated:YES];
            [_dataArr removeAllObjects];
        }
        _totalSize = [jsonDict[@"body"][@"page"][@"totalSize"] integerValue];
        _totalPage = [jsonDict[@"body"][@"page"][@"totalPage"] integerValue];
        for (NSDictionary * dict in jsonDict[@"body"][@"itemList"]) {
            ItemListModel * model = [[ItemListModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            [_dataArr addObject:model];
        }
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        [_collectionView reloadData];
        
        [GiFHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        [_collectionView.mj_header endRefreshing];
        [_collectionView.mj_footer endRefreshing];
        [GiFHUD dismiss];
    }];
    


}
#pragma mark - 布局
- (void)configNav {
    self.navigationItem.title = @"商品列表";
    UIButton * leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    leftBtn.frame = CGRectMake(0, 0, 28, 28);
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn setImage:[UIImage imageNamed:@"navigationBar_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton * titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [titleBtn setBackgroundImage:[UIImage imageNamed:@"navigationBar_textField"] forState:(UIControlStateNormal)];
    titleBtn.adjustsImageWhenHighlighted = NO;
    titleBtn.frame = CGRectMake(0, 0, kScreenW*0.6, 30);
    [titleBtn addTarget:self action:@selector(goSearch) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.titleView = titleBtn;
    
    UIButton * rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightBtn.frame = CGRectMake(0, 0, 28, 28);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationBar_more"] forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(goMore) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goSearch {
    
}
- (void)goMore {
    
}
- (void)configUI {
    __weak typeof(self) weakSelf = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = _column;
    layout.minimumColumnSpacing = kMarginX;
    layout.minimumInteritemSpacing = 4;
    layout.sectionInset = UIEdgeInsetsMake(5, kMarginX, 10, kMarginX);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, kScreenW, kScreenH-104) collectionViewLayout:layout];
    _collectionView.backgroundColor = kWhite(0.9);
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[ItemListCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerClass:[ItemListCell2 class] forCellWithReuseIdentifier:@"cell2"];
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _itemSearch.page.currentPage = 1;
        [weakSelf loadDataWithPage:_itemSearch.page.currentPage];
    }];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataWithPage:++_itemSearch.page.currentPage];
    }];
    
    UIView * headerView = [[UIView alloc] initWithFrame:(CGRectMake(0, 64, kScreenW, 40))];
    headerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headerView.layer.borderWidth = 1.0;
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    //5个按键
    UIButton * btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIButton * btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIButton * btn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIButton * btn4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    UIButton * btn5 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _btnArr = @[btn1,btn2,btn3,btn4,btn5];
    NSArray * titleArr = @[@"默认",@"销量",@"价格",@"新品",@""];
    for (int i=0; i<_btnArr.count; i++) {
        UIButton * btn = _btnArr[i];
//        btn.backgroundColor=  [UIColor orangeColor];
        btn.adjustsImageWhenHighlighted = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:titleArr[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:kRGB(206, 0, 0) forState:(UIControlStateSelected)];
        [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [btn setTag:100+i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headerView addSubview:btn];
        switch (i) {
            case 0:
            {
                btn.selected = YES;
            }
                break;
            case 1:
            {
                [btn setImage:[UIImage imageNamed:_numUp?@"itemList_up":@"itemList_down"] forState:(UIControlStateNormal)];
                [btn setTitleEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 10))];
                [btn setImageEdgeInsets:(UIEdgeInsetsMake(0, 38, 0, -38))];
            }
                break;
            case 2:
            {
                [btn setImage:[UIImage imageNamed:_priceUp?@"itemList_up":@"itemList_down"] forState:(UIControlStateNormal)];
                [btn setTitleEdgeInsets:(UIEdgeInsetsMake(0, -10, 0, 10))];
                [btn setImageEdgeInsets:(UIEdgeInsetsMake(0, 38, 0, -38))];
            }
                break;
            case 3:
            {

            }
                break;
            case 4:
            {
                [btn setImage:[UIImage imageNamed:@"itemlist_change"] forState:(UIControlStateNormal)];

            }
                break;
            default:
                break;
        }
    }
    UIView * lastView;
    __weak typeof(headerView) superView= headerView;
    for (UIView * view in _btnArr) {
        if (!lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(superView);
                make.left.equalTo(superView.mas_left).offset(10);
                make.width.mas_equalTo(50);
            }];
        }
        else {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(superView);
                make.left.greaterThanOrEqualTo(lastView.mas_right).offset((kScreenW - 50*5 - 10)/4);
                make.width.equalTo(lastView);
            }];
        }
        lastView = view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_right).offset(0);
    }];
    
    _topBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_topBtn setImage:[UIImage imageNamed:@"itemList_scrollToTop"] forState:(UIControlStateNormal)];
    _topBtn.alpha = 0;
    [_topBtn addTarget:self action:@selector(scrollToTop) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_topBtn];
    [_topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-20);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-20);
    }];
    _topLable = [[UILabel alloc] init];
    _topLable.numberOfLines = 2;
    [_topLable setTextAlignment:(NSTextAlignmentCenter)];
    [_topBtn addSubview:_topLable];
    [_topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_topBtn);
    }];
}
#pragma mark - 数据源代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_column == 1) {
        return CGSizeMake(kScreenW-10, 100);
    }
    return CGSizeMake((kScreenW - kMarginX*(_column+1))/_column, (kScreenW - kMarginX*(_column+1))/_column*179/185.0+5+17+5+17+5+20);

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell;
    if (_column == 2) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    }
    [cell setValue:_dataArr[indexPath.item] forKey:@"model"];
    return cell;
}
#pragma mark - 其余代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y >= 2.5*kScreenH) {
        [UIView animateWithDuration:0.3 animations:^{
            _topBtn.alpha = 0.5;
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            _topBtn.alpha = 0;
        }];
    }
    
    static int lastPosition;
    
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - lastPosition > 25) {
        lastPosition = currentPostion;
        
        CGPoint point = _collectionView.contentOffset;
        point.x = kScreenW - 20;
        NSInteger maxNum = [_collectionView indexPathForItemAtPoint:point].row;
        _topLable.hidden = NO;
        _topLable.text = [NSString stringWithFormat:@"看了%ld个\n总%ld个",maxNum+1,_totalSize];
     
    }
    else if (lastPosition - currentPostion > 25)
    {
        lastPosition = currentPostion;
        _topLable.hidden = YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _topLable.hidden = YES;
}
#pragma mark - 响应
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemDetailVC2 * itemDetailVC = [[ItemDetailVC2 alloc] init];
    itemDetailVC.itemId = [_dataArr[indexPath.item] itemId];
    
    [self.navigationController pushViewController:itemDetailVC animated:YES];
}
- (void)btnClick:(UIButton *)btn {
    if (btn.tag !=104) {
        btn.selected = YES;
        for (UIButton * btn1 in _btnArr) {
            if (btn.tag != btn1.tag) {
                btn1.selected = NO;
            }
        }
    }
    else {
        btn.selected = !btn.selected;
    }
    
    switch (btn.tag) {
        case 100:
        {
            //sort == 0?return:{sort=0;send...}
            
            if (_itemSearch.sort == 6 && [_itemSearch.ruleType isEqualToString:@"0"]) {
                return;
            }
            else {
                _itemSearch.sort = 6;
                _itemSearch.ruleType = @"0";
                _itemSearch.page.currentPage = 1;
                [self loadDataWithPage:1];
            }
        }
            break;
        case 101:
        {
            //销量
            if (_itemSearch.sort == 2 || _itemSearch.sort == 3 || _itemSearch.sort ==6 ) {
                _itemSearch.ruleType = @"0";
                _itemSearch.sort = _numUp?1:2;
                [btn setImage:[UIImage imageNamed:_numUp?@"itemList_up":@"itemList_down"] forState:(UIControlStateNormal)];
            }
            else if (_itemSearch.sort == 1) {
                _numUp = !_numUp;
                _itemSearch.sort = 2;
                [btn setImage:[UIImage imageNamed:_numUp?@"itemList_up":@"itemList_down"] forState:(UIControlStateNormal)];
            }
            else if (_itemSearch.sort == 2) {
                _numUp = !_numUp;
                _itemSearch.sort = 1;
                [btn setImage:[UIImage imageNamed:_numUp?@"itemList_up":@"itemList_down"] forState:(UIControlStateNormal)];
            }
            else {
                
            }
            _itemSearch.page.currentPage = 1;
            [self loadDataWithPage:_itemSearch.page.currentPage];
            
        }
            break;
        case 102:
        {
            //价格
            if (_itemSearch.sort == 0 || _itemSearch.sort == 1 || _itemSearch.sort ==6 ) {
                _itemSearch.sort = 0;
                _itemSearch.sort = _priceUp?2:3;
                [btn setImage:[UIImage imageNamed:_numUp?@"itemList_up":@"itemList_down"] forState:(UIControlStateNormal)];
            }
            else if (_itemSearch.sort == 2) {
                _priceUp = !_priceUp;
                _itemSearch.sort = 3;
                [btn setImage:[UIImage imageNamed:_priceUp?@"itemList_up":@"itemList_down"] forState:(UIControlStateNormal)];
            }
            else if (_itemSearch.sort == 3) {
                _priceUp = !_priceUp;
                _itemSearch.sort = 2;
                [btn setImage:[UIImage imageNamed:_priceUp?@"itemList_up":@"itemList_down"] forState:(UIControlStateNormal)];
            }
            else {
                
            }
            _itemSearch.page.currentPage = 1;
            [self loadDataWithPage:_itemSearch.page.currentPage];
        }
            break;
        case 103:
        {
            //新品
            if ([_itemSearch.ruleType  isEqual: @"1"]) {
                return;
            }
            else {
                _itemSearch.ruleType = @"1";
                _itemSearch.page.currentPage = 1;
                [self loadDataWithPage:_itemSearch.page.currentPage];
            }
        }
            break;
        case 104:
        {
            _column = _column>1?1:2;
            [_collectionView.collectionViewLayout setValue:_column==1?@1:@4 forKey:@"minimumInteritemSpacing"];
            
            [_collectionView.collectionViewLayout setValue:[NSNumber numberWithInteger:_column] forKey:@"columnCount"];
            [btn setImage:_column==1?[UIImage imageNamed:@"itemList_change2"]:[UIImage imageNamed:@"itemlist_change"] forState:(UIControlStateNormal)];
            
            
            for (ItemListModel * model in _dataArr) {
                model.column = _column;
            }
            [_collectionView reloadData];
            return;
        }
            break;
        default:
            break;
    }
    [GiFHUD showWithOverlay];
}
- (void)scrollToTop {
    [_collectionView setContentOffset:(CGPointZero) animated:YES];
}


@end
