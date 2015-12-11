//
//  AddAddrVC.m
//  YYSportsProject
//
//  Created by Tomi on 15/11/25.
//  Copyright © 2015年 k. All rights reserved.
//

#import "AddAddrVC.h"
#import "AddrItemTVCell.h"
#import "DefaultAddrTVCell.h"
@interface AddAddrVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableView;
    NSArray* _dataArr;
    NSArray* _placeholderArr;
}
@end

@implementation AddAddrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    self.navigationItem.title = @"添加地址";
    self.view.backgroundColor = kWhite(1);
    // Do any additional setup after loading the view.
    [self configUI];
    [self loadData];
    [self configNav];
}
-(void)configUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.scrollEnabled = NO;
    _tableView.sectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
}
-(void)configNav{
    self.navigationItem.title = @"添加地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction)];
}
-(void)loadData{
    
  
    
    AddrInfoModel * model0 = [[AddrInfoModel alloc] init];
    model0.subject = @"联系人";
    model0.placeholder = @"请输入联系人姓名";
    model0.content = _model.contact;
    
    AddrInfoModel * model1 = [[AddrInfoModel alloc] init];
    model1.subject = @"联系号码";
    model1.placeholder = @"请输入联系人电话";
    model1.content = _model.phone;
    
    AddrInfoModel * model2 = [[AddrInfoModel alloc] init];
    model2.subject = @"地区选择";
    model2.placeholder = @"请选择地区";
    
    AddrInfoModel * model3 = [[AddrInfoModel alloc] init];
    model3.subject = @"详细地址";
    model3.placeholder = @"请输入地址";
    model3.content = _model.detailAddr;
    
    AddrInfoModel * model4 = [[AddrInfoModel alloc] init];
    model4.subject = @"邮政编码";
    model4.placeholder = @"请输入邮政编码";
    model4.content = _model.zipCode;
    
    _dataArr = @[@[model0],@[model1],@[model2],@[model3],@[model4]];
//    [_tableView reloadData];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr[section]count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell;
//    switch (indexPath.section) {
//        case 0:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        }
//            break;
//        case 1:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        }
//            break;
//        case 2:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        }
//            break;
//        case 3:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        }
//            break;
//        case 4:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        }
//            break;
//        case 5:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
//        }
//            break;
//
//        default:
//            break;
//    
//    }
    
//    [cell setValue:_arr[indexPath.section] forKey:@"titel"];
//    [cell setValue:_arr[indexPath.section] forKey:@"content"];
  
    UITableViewCell* cell = nil;
    
    if (indexPath.section <= 4) {
        
        cell = [[AddrItemTVCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell1"];
        [cell setValue:_dataArr[indexPath.section][indexPath.row] forKey:@"model"];
        
           }
    else if(indexPath.section == 5){
        cell = [[DefaultAddrTVCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell2"];
        
    }
    
    [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 17;
}
#pragma mark-点击事件
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}
-(void)saveAction{
    
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
