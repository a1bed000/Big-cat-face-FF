//
//  AddrVC.m
//  YYSportsProject
//
//  Created by Tomi on 15/11/24.
//  Copyright © 2015年 k. All rights reserved.
//

#import "AddrVC.h"
#import "AddrTableViewCell.h"
#import "AddAddrVC.h"
#import "EditAddrVC.h"
@interface AddrVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tableView;
    
    NSMutableArray* _dataArr;
    UIButton* _addAddrBtn;
}
@end

@implementation AddrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收货地址";
    self.view.backgroundColor = kWhite(1);
    // Do any additional setup after loading the view.
   
    [self loadData];
    [self configUI];
}
-(void)loadData{
    AddrModel* model = [[AddrModel alloc]init];
    model.contact = @"王大毛";
    model.mobile = @"13355566411";
    model.detailAddr = @"上海市虹口区逸仙路167号2311室上海市虹口区逸仙路167号上海市虹口区逸仙路167号2311室";
    AddrModel* model2 = [[AddrModel alloc]init];
    model2.contact = @"王小毛";
    model2.mobile = @"332424242233";
    model2.detailAddr = @"上海市普陀区大渡河路999弄28号102室";
    _dataArr = [NSMutableArray new];
    [_dataArr addObject:model];
    [_dataArr addObject:model2];
    
//    _dataArr = @[model,model2];
   

    //地址管理网络数据请求
    
//    [YYTool postDataWithUrl:@"http://10.30.3.18:8888/appWeb/user/address/list.json" Body:@{@"userId":@0564,@"token":@"0"} success:^(NSDictionary *jsonDict) {
//        _dataArr = [NSMutableArray new];
////                NSLog(@"-----%@",jsonDict);
////               NSDictionary * dic = jsonDict[@"body"][@"addrList"];
//        
//        for (int i=0; i<[jsonDict[@"body"][@"addrList"] count]; i++) {
//            NSDictionary * dict = jsonDict[@"body"][@"addrList"][i];
//            AddrModel* model = [[AddrModel alloc]init];
//            [model setValuesForKeysWithDictionary:dict];
//            [_dataArr addObject:model];
//        }
//        
//        [_tableView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];

}
-(void)configUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -1, kScreenW, kScreenH) style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _tableView.sectionHeaderHeight = 1;
    _tableView.sectionFooterHeight = 17;
//    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
  
    
//    UIView* view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 500, 0, 45)];
//    view2.backgroundColor = [UIColor redColor];
////    _tableView.tableFooterView = view;
//    [self.view addSubview:view2];
    _addAddrBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenH-50, kScreenW, 50)];
    _addAddrBtn.backgroundColor = [UIColor redColor];
    [_addAddrBtn setTitle:@"添加新地址" forState:(UIControlStateNormal)];
  
    _addAddrBtn.titleLabel.textAlignment = UITextAlignmentCenter;
    [_addAddrBtn addTarget:self action:@selector(addAddrAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_addAddrBtn];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    AddrTableViewCell* cell = nil;
    //
    //    cell = [[AddrTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    
    AddrTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[AddrTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];

    }
    cell.indexPath = indexPath;
    cell.model = _dataArr[indexPath.section];
    //设置点击cell没动画
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    
    [cell setValue:^(NSInteger tag,NSInteger section){
        EditAddrVC* editAddrVC = [[EditAddrVC alloc]init];
        editAddrVC.model = _dataArr[indexPath.section];
       
        switch (tag) {
            case 100:
                [_dataArr removeObjectAtIndex:indexPath.section];
                [_tableView reloadData];
                break;
            case 101:
                [self.navigationController pushViewController:editAddrVC animated:YES];
                
                break;
            default:
                break;
        }
        NSLog(@"%ld",tag);
        
        
    }forKey:@"click"];
    
    return cell;
}
#pragma mark - TableView代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    //其他代码
}

#pragma mark-点击事件
-(void)addAddrAction{
    AddAddrVC* addAddrVC = [AddAddrVC new];
    [self.navigationController pushViewController:addAddrVC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
