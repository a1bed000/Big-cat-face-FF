//
//  EditAddrVC.m
//  YYSportsProject
//
//  Created by Tomi on 15/11/25.
//  Copyright © 2015年 k. All rights reserved.
//

#import "EditAddrVC.h"
#import "AddrItemTVCell.h"
#import "DefaultAddrTVCell.h"
@interface EditAddrVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tableView;
    NSArray* _titleArr;
    UIButton* _saveBtn;
    NSArray* _placeholderArr;
    NSArray* _dataArr;
}
@end

@implementation EditAddrVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    self.view.backgroundColor = kWhite(1);
    // Do any additional setup after loading the view.
    [self loadData];
    [self configUI];
    [self configNav];
    
    
}
-(void)configUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.scrollEnabled = NO;
    
    _tableView.sectionFooterHeight = 0;
    [self.view addSubview:_tableView];
    
    _saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 400, kScreenW, 45)];
    [_saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    _saveBtn.backgroundColor = [UIColor redColor];
    [_saveBtn setTitleColor:kWhite(1) forState:(UIControlStateNormal)];
    [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_tableView addSubview:_saveBtn];
}
-(void)configNav{
    self.navigationItem.title = @"编辑地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:(UIBarButtonItemStylePlain) target:self action:@selector(deleteCell)];
    
}
-(void)loadData{

//    _dataArr = @[_model.contact,_model.phone,_model.district,_model.detailAddr,_model.zipCode];
    
    AddrInfoModel * model0 = [[AddrInfoModel alloc] init];
    model0.subject = @"联系人";
    model0.placeholder = @"请输入联系人姓名";
    model0.content = _model.contact;
    
    AddrInfoModel * model1 = [[AddrInfoModel alloc] init];
    model1.subject = @"联系号码";
    model1.placeholder = @"请输入联系人电话";
    model1.content = _model.mobile;
    
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
    [_tableView reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr[section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell =  nil;
    
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
-(void)saveAction{
    [YYTool postDataWithUrl:@"http://10.30.3.18:8888/appWeb/user/address/edit.json" Body:@{@"userId":@0564,@"token":@"0",
                                                                                           @"addr":[_model keyValues]
//                                                                                           @"addr":@{
//@"addrId":[NSNumber numberWithInteger:_model.addrId],
//@"contact":_model.contact,
//@"proviceId":_model.proviceId,
//@"provice":_model.provice,
//@"cityId":_model.cityId,
//@"city":_model.city,
//@"districtId":_model.districtId,
//@"district":_model.district,
//@"detailAddr":_model.detailAddr,
//@"mobile":_model.mobile,
//@"zipCode":_model.zipCode,
//@"email":_model.email,
//@"phone":_model.phone,
//@"isDefault":[NSNumber numberWithInteger:_model.isDefault]
//    }
}
success:^(NSDictionary *jsonDict) {
if (![jsonDict[@"head"][@"code"] integerValue]) {
//ok
_model.contact = [_dataArr[0][0] content];
//    NSLog(@"%@",[_dataArr[0][0] content]);
    
_model.mobile = [_dataArr[0][0]content];

_model.detailAddr = [_dataArr[0][0]content];
    
_model.zipCode = [_dataArr[0][0]content];

UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
[alert show];
}
else {
 //重新请求
UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
                            [alert show];
  }
                        
    } failure:^(NSError *error) {
                        
 }];

}
//-(BOOL) textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    return YES;
//}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}
-(void)deleteCell{
    
}

@end
