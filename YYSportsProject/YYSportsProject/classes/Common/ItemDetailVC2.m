//
//  ItemDetailVC2.m
//  YYSportsProject
//
//  Created by k on 15/11/19.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemDetailVC2.h"
#import "ItemIntroCell.h"
#import "ItemDetailCell2.h"
#import "ItemParamsCell.h"
#import "ItemSelectCell.h"
#import "AddCell.h"

@interface ItemDetailVC2 ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,SDCycleScrollViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    
    UIWebView * _webView;
    
    UIButton * _btn1;
    UIButton * _btn2;
    UIButton * _btn3;
    UIButton * _btn4;  //最下面4个btn
    
    UIView * _bottomView;
    
    NSInteger _itemGroupId;
    NSString * _preferentialPriceInfo;
    NSArray * _imgList;
    
    NSString * _detailUrl;
    NSInteger _currentItemId;
    NSInteger _currentItemNum;
    NSInteger _currentItemStock;
    
    NSInteger _status;      //商品状态   0未上架 1正常  2 下架
    BOOL _isCollected;      //是否已收藏
    
    
    UITableView * _itemParamsTableView;
    NSMutableArray * _paramsDataArr;
    UIView * _curtainView;
    
    UITableView * _itemSelectTableView;
    
    //选择属性相关
    NSArray * _itemList;
    NSMutableArray * _itemPropArr;
    
    NSMutableArray * _currentValue;
}
@end

@implementation ItemDetailVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configNav];
    [self configUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
#pragma mark - 布局
- (void)configNav {
    self.navigationItem.title = @"商品详情";
}
- (void)configUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ItemIntroCell class] forCellReuseIdentifier:@"introCell"];
    [_tableView registerClass:[ItemDetailCell2 class] forCellReuseIdentifier:@"detailCell2"];

    __weak typeof(self) weakSelf = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-49);
    }];
    
    _webView = [[UIWebView alloc] initWithFrame:(CGRectMake(0, 0, kScreenW, kScreenW))];
    _webView.scrollView.delegate = self;
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(kScreenH + 64);
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(kScreenH-49);
    }];
    
    UILabel * webLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, 30, kScreenW, 20))];
    webLabel.text = @"下拉返回商品详情";
    webLabel.textColor = kRGB(153, 153, 153);
    webLabel.textAlignment = NSTextAlignmentCenter;
    [_webView insertSubview:webLabel atIndex:0];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:(CGRectMake(0, kScreenH-49, kScreenW, 49))];
    _bottomView = bottomView;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    _btn1 = [UDBtn buttonWithType:(UIButtonTypeCustom)];
    [_btn1 setImage:[UIImage imageNamed:@"itemDetail_collected"] forState:(UIControlStateNormal)];
    [_btn1 setTitle:@"收藏" forState:(UIControlStateNormal)];
    _btn1.frame = CGRectMake(0, 0, kScreenW/6, 49);
    _btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_btn1 setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
    _btn1.tag = 101;
    [bottomView addSubview:_btn1];
    _btn2 = [UDBtn buttonWithType:(UIButtonTypeCustom)];
    [_btn2 setImage:[UIImage imageNamed:@"itemDetail_collected"] forState:(UIControlStateNormal)];
    [_btn2 setTitle:@"客服" forState:(UIControlStateNormal)];
    _btn2.frame = CGRectMake(kScreenW/6, 0, kScreenW/6, 49);
    _btn2.tag = 102;
    [bottomView addSubview:_btn2];
    _btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [_btn2 setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
    
    _btn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn3 setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    _btn3.backgroundColor = kRGB(38, 38, 38);
    _btn3.frame = CGRectMake(kScreenW/3, 0, kScreenW/3, 49);
    _btn3.tag = 103;
    [bottomView addSubview:_btn3];
    
    _btn4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn4 setTitle:@"立即购买" forState:(UIControlStateNormal)];
    _btn4.backgroundColor = kRGB(203, 0, 0);
    _btn4.frame = CGRectMake(kScreenW/3*2, 0, kScreenW/3, 49);
    _btn4.tag = 104;
    [bottomView addSubview:_btn4];

    [_btn1 addTarget:self action:@selector(btnTouch:) forControlEvents:(UIControlEventTouchUpInside)];
    [_btn2 addTarget:self action:@selector(btnTouch:) forControlEvents:(UIControlEventTouchUpInside)];
    [_btn3 addTarget:self action:@selector(btnTouch:) forControlEvents:(UIControlEventTouchUpInside)];
    [_btn4 addTarget:self action:@selector(btnTouch:) forControlEvents:(UIControlEventTouchUpInside)];
}
#pragma mark - 加载数据
- (void)loadData {
    _dataArr = [NSMutableArray array];


    [YYTool postDataWithUrl:kItemDetailUrl Body:@{@"itemId":[NSNumber numberWithInteger:_itemId]} success:^(NSDictionary *jsonDict) {
        NSLog(@"dict:%@",jsonDict);
        
        ItemIntroModel * model1 = [[ItemIntroModel alloc] init];
        [model1 setValuesForKeysWithDictionary:jsonDict[@"body"]];
        [_dataArr addObject:@[model1]];
        
        ItemDetailModel2 * model2 = [[ItemDetailModel2 alloc] init];
        model2.subject = @"产品参数";
        model2.imgName = @"itemlist_change";
        [_dataArr addObject:@[model2]];
        
        ItemDetailModel2 * model3 = [[ItemDetailModel2 alloc] init];
        model3.subject = @"商品评论";
        model3.num = [jsonDict[@"body"][@"num"] integerValue];
        model3.imgName = @"itemlist_change";
        [_dataArr addObject:@[model3]];
        
        _imgList = jsonDict[@"body"][@"imgList"];
        _detailUrl = jsonDict[@"body"][@"detailPage"];
        _preferentialPriceInfo = jsonDict[@"body"][@"preferentInfo"];
        _itemGroupId = [jsonDict[@"body"][@"itemGroupId"] integerValue];
        _itemId = [jsonDict[@"body"][@"itemId"] integerValue];
        
        _status = [jsonDict[@"body"][@"status"] integerValue];
        _isCollected = [jsonDict[@"body"][@"isCollected"] integerValue];
        
        _btn1.selected = _isCollected;
        _btn4.enabled = _status%2;
        if (_status == 0) {
            [_btn4 setTitle:@"暂未上架" forState:(UIControlStateDisabled)];
        }
        else if (_status == 2) {
            [_btn4 setTitle:@"已下架" forState:(UIControlStateDisabled)];
        }
        else {
            
        }
        
        _currentItemId = _itemId;
        _currentItemNum = 1;
        _itemList = jsonDict[@"body"][@"itemList"];
        [_tableView reloadData];
        
        _paramsDataArr = [NSMutableArray array];
        for (NSDictionary * itemParamsDict in jsonDict[@"body"][@"itemParams"]) {
            ItemParamsModel * model = [[ItemParamsModel alloc] init];
            [model setValuesForKeysWithDictionary:itemParamsDict];
            [_paramsDataArr addObject:model];
        }
        //处理商品数据
        _itemPropArr = [NSMutableArray array];
        for (NSDictionary * itemDict in _itemList) {
            for (NSDictionary * propDict in itemDict[@"propData"]) {
                NSInteger flag1 = 0;
                for (ItemSelectModel * model in _itemPropArr) {
                    if (model && [model.propName isEqualToString:propDict[@"propName"]]) {
                        //已存在大属性对象  再遍历里面的分属性  不存在则添加  存在则加入到itemIdList中
                        flag1 = 1;
                        NSInteger flag2 = 0;
                        for (PropValue * propValue in model.propList) {
                            if ([propValue.propValue isEqualToString:propDict[@"propValue"]]) {
                                //存在  添加到对应的list里面
                                [propValue.ItemIdList addObject:itemDict[@"itemId"]];
                                flag2 = 1;
                                break;
                            }
                        }
                        if (!flag2) {
                            PropValue * propValue = [[PropValue alloc] init];
                            propValue.propValue = propDict[@"propValue"];
                            [propValue.ItemIdList addObject:itemDict[@"itemId"]];
                            [model.propList addObject:propValue];
                        }
                        
                    }
                    else {
                        
                    }
                }
                if (!flag1) {
                    ItemSelectModel * model = [[ItemSelectModel alloc] init];
                    model.propName = propDict[@"propName"];
                    
                    PropValue * propValue = [[PropValue alloc] init];
                    propValue.propValue = propDict[@"propValue"];
                    [propValue.ItemIdList addObject:itemDict[@"itemId"]];
                    [model.propList addObject:propValue];
                    
                    [_itemPropArr addObject:model];
                    
                }
            }
        }
//        NSLog(@"%@",_itemPropArr);
        for (NSDictionary * lDict in _itemList) {
            if ([lDict[@"itemId"] integerValue] == _currentItemId) {
                _currentItemStock = [lDict[@"itemStock"] integerValue];
                break;
            }
        }
        AddCellModel * model = [[AddCellModel alloc] init];
        model.canReduce = NO;
        model.canAdd = _currentItemStock>1;
        model.itemNum = 1;
        model.itemStock = _currentItemStock;
        
        [_itemPropArr addObject:model];
        
        //拿到当前id的属性
        _currentValue = [NSMutableArray array];
        for (NSDictionary * itemDict  in _itemList) {
            if ([itemDict[@"itemId"] integerValue] == _currentItemId) {
                for (NSDictionary * valueDict in itemDict[@"propData"]) {
                    [_currentValue addObject:valueDict[@"propValue"]];
                }
            }
        }

    } failure:^(NSError *error) {
        
    }];

}
#pragma mark - 数据源代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _itemSelectTableView) {
        if (indexPath.row == 2) {
            return 85;
        }
        ItemSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"selectCell"];
        [cell setValue:_itemPropArr[indexPath.row] forKey:@"model"];
        
        return cell.cellHeight;
    }
    return [@[@85,@44,@44][indexPath.section] floatValue];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        return [_dataArr[section] count];
    }
    else if (tableView == _itemParamsTableView) {
        return _paramsDataArr.count;
    }
    else if (tableView == _itemSelectTableView) {
        return _itemPropArr.count;
    }
    else {
        return 1;
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tableView) {
        return _dataArr.count;
    }
    else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    if (tableView == _tableView) {
        if (indexPath.section == 0)
            cell = [tableView dequeueReusableCellWithIdentifier:@"introCell" forIndexPath:indexPath];
        else
            cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell2" forIndexPath:indexPath];
        
        [cell setValue:_dataArr[indexPath.section][indexPath.row] forKey:@"model"];
    }
    else if (tableView == _itemParamsTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"paramsCell" forIndexPath:indexPath];
        [cell setValue:_paramsDataArr[indexPath.row] forKey:@"model"];
    }
    else if (tableView == _itemSelectTableView) {
        if (indexPath.row == 2) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"addCell" forIndexPath:indexPath];
            [cell setValue:_itemPropArr[indexPath.row] forKey:@"model"];
            __weak typeof(self) weakSelf = self;
            [cell setValue:^(NSInteger tag){
                [weakSelf addNumWithTag:tag];
            } forKey:@"addNum"];
            
            return cell;
        }
        
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"selectCell" forIndexPath:indexPath];
        [cell setValue:indexPath forKey:@"cellIndex"];
        __weak typeof(self) weakSelf = self;
        [cell setValue:^(NSInteger tag){
            [weakSelf propTouch:tag];
        } forKey:@"btnTouch"];
        [cell setValue:_itemPropArr[indexPath.row] forKey:@"model"];
    }
    else {
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView != _tableView) {
        return nil;
    }
    
    UIView * view = [[UIView alloc] init];
    switch (section) {
        case 0:
        {
            SDCycleScrollView * cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:(CGRectMake(0, 0, kScreenW, kScreenW))];
            cycleScrollView.imageURLStringsGroup = _imgList;
            cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
            cycleScrollView.delegate = self;
            view = cycleScrollView;
            
        }
            break;
        default:
            break;
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView != _tableView) {
        return 1;
    }
    
    switch (section) {
        case 0:
            return kScreenW;
            break;
        case 1:
            return 20;
            break;

        default:
            break;
    }
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView != _tableView) {
        return nil;
    }
    
    UIView * view = [[UIView alloc] init];
    switch (section) {
        case 0:
        {
            if (_preferentialPriceInfo) {
                UILabel * label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, kScreenW, 44))];
                
                label.text = [NSString stringWithFormat:@"   %@",_preferentialPriceInfo];
                label.textColor = kRGB(153, 153, 153);
                label.font = [UIFont systemFontOfSize:14];
                label.backgroundColor = kRGB(230, 230, 230);
                view = label;
            }
        }
            break;
        case 2:
        {
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setTitle:@"继续拖动,查看详情" forState:(UIControlStateNormal)];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [btn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, 0))];
            btn.frame = CGRectMake(0, 0, kScreenW, 30);
            view = btn;
        }
            break;
            
        default:
            break;
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView != _tableView) {
        return 1;
    }
    switch (section) {
        case 0:
        {
            if (_preferentialPriceInfo) {
                return 43;
            }else {
                return 1;
            }
        }
            break;
        case 2:
        {
            return 40;
        }
            break;
        default:
            break;
    }
    return 18;
}
#pragma mark - 其余代理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == _tableView) {
        if (scrollView.contentOffset.y - (scrollView.contentSize.height - scrollView.frame.size.height) >= 90) {
            //scrollview上移kscreenH
            //webView上移kscreenH
            //webviewloadData
            [_webView loadHTMLString:_detailUrl baseURL:nil];
            if (kIOS8) {
                [UIView animateWithDuration:0.3 animations:^{
                    scrollView.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.size.height);
                    _webView.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.size.height);
                }];
            }
            else {
#warning 此处原因???
                [UIView animateWithDuration:0.3 animations:^{
                    scrollView.transform = CGAffineTransformMakeTranslation(0, -kScreenH*2);
                    _webView.transform = CGAffineTransformMakeTranslation(0, -kScreenH*2);
                }];
            }
        }
    }
    else if (scrollView == _webView.scrollView) {
        if (scrollView.contentOffset.y <= - 90) {
            [UIView animateWithDuration:0.3 animations:^{
                _tableView.transform = CGAffineTransformIdentity;
                _webView.transform = CGAffineTransformIdentity;
            }];

        };
    }
    else {
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView != _tableView) {
        return;
    }
    switch (indexPath.section) {
        case 1:
        {
            _curtainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH*3/2)];
            _curtainView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
            [[[UIApplication sharedApplication].delegate window] addSubview:_curtainView];
            [_curtainView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)]];
            
            _itemParamsTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, kScreenH,  kScreenW, kScreenH/2)) style:(UITableViewStylePlain)];
            _itemParamsTableView.delegate = self;
            _itemParamsTableView.dataSource = self;
            [_curtainView addSubview:_itemParamsTableView];
            _itemParamsTableView.showsVerticalScrollIndicator = NO;
            _itemParamsTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
            [_itemParamsTableView registerClass:[ItemParamsCell class] forCellReuseIdentifier:@"paramsCell"];
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.frame = CGRectMake(0, kScreenH*3/2 - 49, kScreenW, 49);
            btn.backgroundColor = kRGB(202, 0, 0);
            [btn setTitle:@"关闭" forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
            [_curtainView addSubview:btn];
            
            
            [UIView animateWithDuration:0.2 animations:^{
                _curtainView.transform = CGAffineTransformMakeTranslation(0, -kScreenH/2);
            }];

        }
            break;
        case 2:
        {
            ItemCommentVC * itemCommentVC = [[ItemCommentVC alloc] init];
            itemCommentVC.itemGroupId = _itemGroupId;
            
            [self.navigationController pushViewController:itemCommentVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}
#pragma mark -  点击事件
- (void)dismiss:(UITapGestureRecognizer *)tap {
    if ([tap locationInView:tap.view].y <= kScreenH) {
        [UIView animateWithDuration:0.2 animations:^{
            _curtainView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [_curtainView removeFromSuperview];
        }];
    }
}
- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        _curtainView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [_curtainView removeFromSuperview];
    }];
}
#pragma mark - touch事件
- (void)btnTouch:(UIButton *)btn {
    switch (btn.tag) {
        case 101:
        {
            
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
        {
            NSLog(@"加入购物车");
        }
            break;
        case 104:
        {

            [self changeStatus];
      
            _curtainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH*3/2+50)];
            _curtainView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
            [[[UIApplication sharedApplication].delegate window] addSubview:_curtainView];
            [_curtainView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)]];
            
            _itemSelectTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, kScreenH,  kScreenW, kScreenH/2+30)) style:(UITableViewStylePlain)];
            _itemSelectTableView.delegate = self;
            _itemSelectTableView.dataSource = self;
            [_curtainView addSubview:_itemSelectTableView];
            _itemSelectTableView.showsVerticalScrollIndicator = NO;
            _itemSelectTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
            [_itemSelectTableView registerClass:[ItemSelectCell class] forCellReuseIdentifier:@"selectCell"];
            [_itemSelectTableView registerClass:[AddCell class] forCellReuseIdentifier:@"addCell"];
            _itemSelectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.frame = CGRectMake(0, kScreenH*3/2 -19, kScreenW, 49);
            btn.backgroundColor = kRGB(202, 0, 0);
            [btn setTitle:@"确定" forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(buyNow) forControlEvents:(UIControlEventTouchUpInside)];
            [_curtainView addSubview:btn];
            
            UIButton * removeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            removeBtn.frame = CGRectMake(kScreenW - 30, kScreenH - 15, 30, 30);
            [removeBtn setBackgroundImage:[UIImage imageNamed:@"58X58"] forState:(UIControlStateNormal)];
            [_curtainView addSubview:removeBtn];
            [removeBtn addTarget:self action:@selector(dismiss) forControlEvents:(UIControlEventTouchUpInside)];
            
            [UIView animateWithDuration:0.2 animations:^{
                _curtainView.transform = CGAffineTransformMakeTranslation(0, -kScreenH/2-30);
            }];

        }
            break;
        default:
            break;
    }
}
- (void)buyNow {
    NSLog(@"itemId:%ld",_currentItemId);
    NSLog(@"itemNum:%ld",_currentItemNum);
    NSLog(@"itemStock:%ld",_currentItemStock);
}
#pragma mark - 点击选择的事件
- (void)propTouch:(NSInteger)tag {
    NSLog(@"%ld",tag);
    if (tag/100 == 0) {
        //第一组 重置一切选择条件
        ItemSelectModel * model = _itemPropArr[0];
        for (int i=0; i<model.propList.count; i++) {
            PropValue * value = model.propList[i];
            if (i == tag%100) {
                value.status = 1;
                _currentItemId = [value.ItemIdList[0] integerValue];
            }
            else {
                value.status = 2;
            }
        }
        
    }
    else {
        //其余组 遵守第一组的条件 筛选其余条件
        //第 tag/100 组
        ItemSelectModel * model = _itemPropArr[tag/100];
        //取到上一级的模型去遍历  获取到与本数组相同的itemId   改变状态
        for (PropValue * value in [_itemPropArr[tag/100-1] propList]) {
            if (value.status == 1) {
                //获取到itemList  遍历相同的  确定
                for (NSNumber * itemId in value.ItemIdList) {
                    for (NSNumber * itemId2 in [model.propList[tag%100] ItemIdList]) {
                        if ([itemId integerValue] == [itemId2 integerValue]) {
                            _currentItemId = [itemId integerValue];
                            break;
                        }
                    }
                }
            }
        }
    }
    _currentValue = [NSMutableArray array];
    for (NSDictionary * itemDict  in _itemList) {
        if ([itemDict[@"itemId"] integerValue] == _currentItemId) {
            for (NSDictionary * valueDict in itemDict[@"propData"]) {
                [_currentValue addObject:valueDict[@"propValue"]];
            }
        }
    }
    [self changeStatus];
    
    
}
#pragma mark - 处理选择属性的事件
- (void)changeStatus {
    //所有全部改为0
//    for (int i=0; i<_itemPropArr.count - 1; i++) {
//        ItemSelectModel * model = _itemPropArr[i];
//        for (PropValue * value in model.propList) {
//            value.status = 0;
//        }
//    }
    for (int i=0; i<_itemPropArr.count-1; i++) {
        ItemSelectModel * model = _itemPropArr[i];
        if (i ==0) {
            //状态为选中和可选
            for (PropValue * propValue in model.propList) {
                NSInteger flag1 = 0;
                for (NSNumber * itemIdNum in propValue.ItemIdList) {
                    if ([itemIdNum integerValue] == _currentItemId) {
                        flag1 = 1;
                        break;
                    }
                }
                propValue.status = flag1?1:2;
            }
        }
        else {
            //状态为选中  可选  不可选
            for (PropValue * propValue in model.propList) {
                NSLog(@"%@",propValue.propValue);
                NSInteger flag1 = 0;
                for (NSNumber * itemIdNum in propValue.ItemIdList) {
                    
                    if ([itemIdNum integerValue] == _currentItemId) {
                        flag1 = 1;
                        propValue.status = 1;
                        break;
                    }
                }
                if (flag1 == 0) {
                    //取出prop中itemIdList的所有商品id
                    NSInteger flag2 = 0;
                    for (NSNumber * itemIdNum in propValue.ItemIdList) {
                        //取出商品id的所有属性
                        for (NSDictionary * itemDict in _itemList) {
                            if ([itemIdNum integerValue] == [itemDict[@"itemId"] integerValue]) {
                                for (NSDictionary * valueDict in itemDict[@"propValue"]) {
                                    for (NSString * str in _currentValue) {
//                                        if ([valueDict[@"propValue"] isEqualToString:str])
                                        {
                                            propValue.status = 2;
                                            flag2 = 1;
                                        }
                                    }
                                }
                            }
                        }
                    }
#warning !!!
                    if (!flag2) {
//                        propValue.status = 0;
                    }
                }
            }
        }
    }
    for (NSDictionary * lDict in _itemList) {
        if ([lDict[@"itemId"] integerValue] == _currentItemId) {
            _currentItemStock = [lDict[@"itemStock"] integerValue];
            
            AddCellModel * model = [_itemPropArr lastObject];
            model.canReduce = NO;
            model.canAdd = _currentItemStock>1;
            model.itemNum = 1;
            model.itemStock = _currentItemStock;
            _currentItemNum = model.itemNum;
            break;
        }
    }
    [_itemSelectTableView reloadData];
}
- (void)addNumWithTag:(NSInteger)tag {
    AddCellModel * model = [_itemPropArr lastObject];
    switch (tag) {
        case 100:
        {
            //减
            model.itemNum -= 1;
            model.canAdd = YES;
            if (model.itemNum <= 1) {
                model.itemNum = 1;
                model.canReduce = NO;
            }
            _currentItemNum = model.itemNum;
        }
            break;
        case 101:
        {
            //加
            model.itemNum += 1 ;
            model.canReduce = YES;
            if (model.itemNum >= model.itemStock) {
                model.itemNum = model.itemStock;
                model.canAdd = NO;
            }
            _currentItemNum = model.itemNum;
        }
            break;
        default:
            break;
    }
    
    [_itemSelectTableView reloadData];
}
@end
