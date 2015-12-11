//
//  HomeVC.m
//  YYSportsProject
//
//  Created by 江 on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "HomeVC.h"
#import "HeaderView.h"
#import "HomeCell1.h"
#import "HomeCell2.h"
#import "HomeCell3.h"
#import "ButtonCell.h"
#import "CarouselTextCell.h"


@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    
    HeaderModel * _headerModel;
    
    UIView * _headerView;

}
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configUI];
    [self loadData];
}
#pragma mark - 布局
- (void)configNav {
    self.navigationItem.title = @"主页";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:kRGB(206, 0, 0)];
}
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[HomeCell1 class] forCellReuseIdentifier:@"homeCell1"];
    [_tableView registerClass:[HomeCell2 class] forCellReuseIdentifier:@"homeCell2"];
    [_tableView registerClass:[HomeCell3 class] forCellReuseIdentifier:@"homeCell3"];
    [_tableView registerClass:[ButtonCell class] forCellReuseIdentifier:@"buttonCell"];
    [_tableView registerClass:[CarouselTextCell class] forCellReuseIdentifier:@"carouselTextCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
}
#pragma  mark - 加载数据
- (void)loadData {
    _dataArr = [NSMutableArray array];
    _headerModel = [[HeaderModel alloc] init];
    
    HomeCellModel * model1 = [[HomeCellModel alloc] init];
    HomeCellModel * model2 = [[HomeCellModel alloc] init];
    HomeCellModel * model3 = [[HomeCellModel alloc] init];
    
    NSDictionary * dict = @{@"rootTitle":@"我是标题",
                            @"rootAdData":@{@"toType":@"1",
                                            @"url":@"www.baidu.com",
                                            @"txt":@"我是标题",
                                            @"icon":@"http://img1.ooopic.com/upfile/default/2306.jpg"},
                            @"subAdList":@[@{@"toType":@"1",
                                             @"url":@"www.baidu.com",
                                             @"txt":@"我是标题",
                                             @"icon":@"http://img2.ooopic.com/14/10/36/62bOOOPIC09_202.jpg"},
                                           @{@"toType":@"1",
                                             @"url":@"www.baidu.com",
                                             @"txt":@"我是标题",
                                             @"icon":@"http://img1.ooopic.com/upfile/default/2306.jpg"},
                                           @{@"toType":@"1",
                                             @"url":@"www.baidu.com",
                                             @"txt":@"我是标题",
                                             @"icon":@"http://img1.ooopic.com/upfile/default/2306.jpg"},
                                           @{@"toType":@"1",
                                             @"url":@"www.baidu.com",
                                             @"txt":@"我是标题",
                                             @"icon":@"http://img1.ooopic.com/upfile/default/2306.jpg"},
                                           @{@"toType":@"1",
                                             @"url":@"www.baidu.com",
                                             @"txt":@"我是标题",
                                             @"icon":@"http://img1.ooopic.com/upfile/default/2306.jpg"},
                                           @{@"toType":@"1",
                                             @"url":@"www.baidu.com",
                                             @"txt":@"我是标题",
                                             @"icon":@"http://img1.ooopic.com/upfile/default/2306.jpg"}]};

    [model1 setKeyValues:dict];
    [model2 setKeyValues:dict];
    [model3 setKeyValues:dict];
    
    
    
    
    
    _headerModel = [[HeaderModel alloc] init];
    
    ToPageModel * pageModel = [[ToPageModel alloc] init];
    pageModel.icon = @"http://pic0.v4.cc/ps/img01.sogoucdn.com/app/a/100520090/oIWsFt9W5pjgRtgs421POiuaXkAc";
    
    ToPageModel * pageModel2 = [[ToPageModel alloc] init];
    pageModel2.icon = @"http://img1.ooopic.com/upfile/default/2306.jpg";
    
    NSDictionary * dict2 = @{@"icon":@"http://pic0.v4.cc/ps/img01.sogoucdn.com/app/a/100520090/oIWsFt1UYog2xsss_V4h0zg_oAr4",@"txt":@"我是按键"};
    
    NSMutableArray * listArr =[NSMutableArray array];
    for (int i=0; i<8; i++) {
        ToPageModel * model = [[ToPageModel alloc] init];
        [model setValuesForKeysWithDictionary:dict2];
        [listArr addObject:model];
        
    }
    
    
    _headerModel.topAdList = @[pageModel,pageModel2];
    _headerModel.buttonList = listArr;
    
    ToPageModel * model31 = [[ToPageModel alloc] init];
    ToPageModel * model32 = [[ToPageModel alloc] init];
    model31.icon = @"http://pic.8liuxing.com/forum/201308/05/234408zm38j61jkqqlaz8c.jpg";
    model31.txt = @"我是文字文字文字文字";
    model32.icon = @"http://p2.123.sogoucdn.com/imgu/2014/08/20140820172423_671.png";
    model32.txt = @"我也是蚊子";
    
    _headerModel.carouselTextList = @[model32,model31];
    
    CarouselTextCellModel * cmodel = [[CarouselTextCellModel alloc] init];
    cmodel.carouselTextList =@[model32,model31];
    
    ButtonCellModel * bmodel = [[ButtonCellModel alloc] init];
    bmodel.buttonList = listArr;
    
    _dataArr = @[bmodel,cmodel,model1,model2,model3];
    [_tableView reloadData];
}
#pragma mark - 数据源代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            return 180;
        }
            break;
        case 1:
        {
            return 35;
        }
            break;
        case 2:
        {
            return kScreenW * 1.27 + 28;
        }
            break;
        case 3:
        {
            return kScreenW * 0.85 +16;
        }
            break;
        case 4:
        {
            return 1.11 * kScreenW;
        }
            break;
        default:
            break;
    }
    
    
    
    
    return 1.11 * kScreenW;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell" forIndexPath:indexPath];
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"carouselTextCell" forIndexPath:indexPath];
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell1" forIndexPath:indexPath];
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell2" forIndexPath:indexPath];
        }
            break;
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell3" forIndexPath:indexPath];
        }
            break;
        default:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell3" forIndexPath:indexPath];
        }
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    [cell setValue:^(NSInteger tag){
        NSLog(@"%ld",tag);
        [weakSelf touchWithTag:tag];
    }forKey:@"click"];
    [cell setValue:_dataArr[indexPath.row] forKey:@"model"];
    
    return cell;
}
#pragma mark - 其余代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_headerView) {
        return _headerView;
    }
    HeaderView * headerView = [[HeaderView alloc] initWithFrame:(CGRectMake(0, 0, kScreenW, kScreenW))];
    headerView.model = _headerModel;
    
    _headerView = headerView;
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenW *347/750.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
#pragma mark - cell点击事件
- (void)touchWithTag:(NSInteger)tag {
    if (tag == 507) {
        ItemClassificationVC * classificationVC = [[ItemClassificationVC alloc] init];
        classificationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:classificationVC animated:YES];
    }
}
@end
