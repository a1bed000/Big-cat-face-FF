//
//  ItemClassificationVC.m
//  YYSportsProject
//
//  Created by k on 15/11/26.
//  Copyright (c) 2015年 k. All rights reserved.
//  tableView + collectionView

#import "ItemClassificationVC.h"
#import "ClassificationSubjectCell.h"
#import "SubClassifyCell.h"
@interface ItemClassificationVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
{
    UITableView * _tableView;
    NSMutableArray * _tableviewArr;
    
    UICollectionView * _collectionView;
    NSMutableArray * _collectionViewArr;
}
@end

@implementation ItemClassificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configUI];
    [self loadData];
}
#pragma mark - 布局
- (void)configNav {
    self.navigationItem.title = @"商品分类";
}
- (void)configUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, 72, kScreenH - 64)) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 60;
    _tableView.backgroundColor = kRGB(202, 202, 202);
    [_tableView registerClass:[ClassificationSubjectCell class] forCellReuseIdentifier:@"tableViewCell"];
    
    
    CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 3;
    layout.minimumColumnSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(22, 12, 22, 12);
    _collectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(72, 64, kScreenW - 72, kScreenH-64)) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[SubClassifyCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    _collectionView.layer.shadowColor = kRGB(53, 53, 53).CGColor;
    _collectionView.layer.shadowOpacity = 0.7;
    _collectionView.layer.shadowOffset = CGSizeMake(-10, 0);
}
#pragma mark - 加载数据
- (void)loadData {
    _tableviewArr = [NSMutableArray array];
    [YYTool postDataWithUrl:kItemClassificationUrl Body:nil success:^(NSDictionary *jsonDict) {
        NSLog(@"%@",jsonDict);
        for (int i=0; i<[jsonDict[@"body"][@"classifyData"] count]; i++) {
            ClassificationSubjectModel * model = [[ClassificationSubjectModel alloc] init];
            [model setKeyValues:jsonDict[@"body"][@"classifyData"][i]];
            
            SubClassifyModel * subModel = [[SubClassifyModel alloc] init];
            subModel.subIcon = model.rootIcon;
            subModel.subClassifyId = model.rootClassifyId;
            subModel.subClassifyName = @"全部";
            [[model subClassifyList] insertObject:subModel atIndex:0];
            if (i==0) {
                model.selected = 1;
            }
            [_tableviewArr addObject:model];
        }
        _collectionViewArr = [_tableviewArr[0] subClassifyList];
        [_tableView reloadData];
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableviewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    [cell setValue:_tableviewArr[indexPath.row] forKey:@"model"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (ClassificationSubjectModel * model in _tableviewArr) {
        model.selected = NO;
    }
    [_tableviewArr[indexPath.row] setValue:@1 forKey:@"selected"];
    [_tableView reloadData];
    _collectionViewArr = [_tableviewArr[indexPath.row] subClassifyList];
    [_collectionView reloadData];
}
#pragma mark  - collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _collectionViewArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    [cell setValue:_collectionViewArr[indexPath.item] forKey:@"model"];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(10, 13);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //
    ItemListVC * itemListVC = [[ItemListVC alloc] init];
    itemListVC.itemSearch.classifyId = [NSString stringWithFormat:@"%ld",[_collectionViewArr[indexPath.item] subClassifyId]];
    itemListVC.itemSearch.page.currentPage = 1;
    itemListVC.itemSearch.page.pageSize = 10;
    itemListVC.itemSearch.type = @"0";
    
    itemListVC.userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] integerValue];
    itemListVC.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [self.navigationController pushViewController:itemListVC animated:YES];
}
@end
