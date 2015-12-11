//
//  UserInformationViewController.m
//  YYSports
//
//  Created by Tomi on 15/11/16.
//  Copyright © 2015年 k. All rights reserved.
//

#import "UserInformationViewController.h"
#import "EditUserNameViewController.h"
#import "EditRealNameVC.h"
#import "EditEmailVC.h"
#import "AddrVC.h"
@interface UserInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView* _tableView;
    NSArray* _userInfoArr;
    UIImageView * _iconImageView;
    
    UIPickerView * _sexPickerView;
    NSArray * _sexDataArr;
    UIPickerView* _birthdayPickerView;
    NSInteger _selectedSexIndex;
    
    UIView* _otherView;
    
    
    NSMutableArray* _year;
    NSMutableArray* _month;
    NSMutableArray* _day;
    NSString* _selectYear;
    NSString* _selectMonth;
    NSString* _selectDay;
    
    
    
}
@end

@implementation UserInformationViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的资料";
    // Do any additional setup after loading the view.
    [self configNav];
    [self configUI];
    [self loadData];
}
-(void)loadData{
//    NSArray* arr1 = @[@"头像",@"昵称",@"性别",@"真实姓名",@"生日",@"会员卡"];
//    NSArray* arr2 = @[@"",@"我是名字",@"女",@"名字",@"2000-10-11",@"2000"];
//    _userInfoArr = @[@[@{@"title":arr1,@"desc":arr2}],
//                     @[@{@"title":@"手机号",@"desc":@"13633443344"},
//                       @{@"title":@"email",@"desc":@"email@163.con"},
//                       @{@"title":@"联系地址",@"desc":@"上海市普陀区新村路333号"}]];
    
    _userInfoArr = @[@[@{@"title":@"头像",@"desc":@""},
                       @{@"title":@"昵称",@"desc":@"我是名字"},
                       @{@"title":@"性别",@"desc":@"女"},
                       @{@"title":@"真实姓名",@"desc":@"名字"},
                       @{@"title":@"生日",@"desc":@"2000-10-11"},
                       @{@"title":@"会员卡",@"desc":@"2000"}],
                     @[@{@"title":@"手机号",@"desc":@"13633443344"},
                       @{@"title":@"email",@"desc":@"email@163.con"},
                       @{@"title":@"联系地址",@"desc":@"上海市普陀区新村路333号"}]];
    _sexDataArr = @[@"男",@"女"];

 
    _year = [NSMutableArray new];
    _month = [NSMutableArray new];
    _day = [NSMutableArray new];
        for (int i = 1900; i<=2200; i++) {
        NSString* str = [NSString stringWithFormat:@"%d",i];
       [ _year addObject:str];
            
    }
   
    for (int i = 1; i <= 12; i++) {
        NSString* str = [NSString stringWithFormat:@"%d",i];
        [_month addObject:str];
    }
    for (int i = 1; i<= 31; i++) {
        NSString* str = [NSString stringWithFormat:@"%d",i];
        [_day addObject:str];
    }
}
-(void)configNav{
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}
-(void)configUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    ///loadData  over
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:@"http://n.sinaimg.cn/top/20151119/EQnf-fxkwuwv3428745.jpg"]];
//    });
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_userInfoArr[section]count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _userInfoArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    
    cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell1"];
    
    
    
    
    if ((indexPath.section == 0 && indexPath.row == 5)||(indexPath.section == 1 && indexPath.row == 0) ){
         cell.accessoryType = UITableViewCellAccessoryNone;
}
    else
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (!indexPath.row && !indexPath.section) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.backgroundColor = kWhite(0.6);
        _iconImageView.layer.cornerRadius = 25;
        _iconImageView.layer.masksToBounds = YES;
        [cell.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView);
            make.centerY.equalTo(cell.contentView);
            make.height.width.mas_equalTo(50);
        }];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.iconUrl]];

            }
            break;
        case 1:
                cell.detailTextLabel.text = _model.userName;
                break;
        case 2:
            {
                NSString* str;
                if ([_model.sex isEqualToString:@"1"]) {
                    
                    str = _sexDataArr[0];
                }
                else if([_model.sex isEqualToString:@"2"])
                    str = _sexDataArr[1];
                cell.detailTextLabel.text = str;
            }
                break;
        case 3:
                cell.detailTextLabel.text = _model.realName;
                break;
        case 4:
                cell.detailTextLabel.text = _model.birthday;
                break;
        case 5:
                cell.detailTextLabel.text = _model.cardNo;
                break;
        default:
            break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = _model.mobile;
                break;
            case 1:
                cell.detailTextLabel.text = _model.email;
                break;
            case 2:
                cell.detailTextLabel.text = _model.addr;
            default:
                break;
        }
    }
        cell.textLabel.text = _userInfoArr[indexPath.section][indexPath.row][@"title"];
    
//    cell.detailTextLabel.text = _userInfoArr[indexPath.section][indexPath.row][@"desc"];

    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"基本信息";
    }
    return @"联系方式";
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.section && !indexPath.row) {
        return 80;
    }
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 && indexPath.section == 0) {
        EditUserNameViewController* editUserNameVC = [[EditUserNameViewController alloc]init];
        editUserNameVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:editUserNameVC animated:YES];
        editUserNameVC.model = _model;
    }
    else if(indexPath.row == 2 && indexPath.section == 0 ){
//        EditSexVC* editSexVC = [[EditSexVC alloc]init];
//        editSexVC.hidesBottomBarWhenPushed = YES;
//        [self presentViewController:editSexVC animated:YES completion:nil ];
        _otherView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH, kScreenW, kScreenH)];
        [self.view addSubview:_otherView];
        [UIView animateWithDuration:0.5 animations:^{
            
            // 设置view弹出来的位置
            
            _otherView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
            
        }];
        
        _sexPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenH-200, kScreenW, 200)];
        _sexPickerView.delegate = self;
        _sexPickerView.dataSource = self;
        _sexPickerView.backgroundColor = kWhite(.9);
        [_otherView addSubview:_sexPickerView];
        _sexPickerView.tag = 300;
        
        UIButton* cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        cancelBtn.frame = CGRectMake(0,CGRectGetMinY(_sexPickerView.frame), 50, 30);
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_otherView addSubview:cancelBtn];
        
        UIButton* okBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        okBtn.frame = CGRectMake(kScreenW-60, CGRectGetMinY(_sexPickerView.frame), 60, 30);
        [okBtn setTitle:@"确认" forState:(UIControlStateNormal)];
        [okBtn addTarget:self action:@selector(sexOk) forControlEvents:(UIControlEventTouchUpInside)];
        [_otherView addSubview:okBtn];
        

            }
    else if(indexPath.row == 3 && indexPath.section == 0){
        EditRealNameVC* editRealNameVC = [[EditRealNameVC alloc]init];
        editRealNameVC.hidesBottomBarWhenPushed = YES;
        editRealNameVC.model = _model;
        [self.navigationController pushViewController:editRealNameVC animated:YES];
    }
    else if(indexPath.row == 4 && indexPath.section == 0){
        _otherView = [[UIView alloc]initWithFrame:CGRectMake(0,kScreenH, kScreenW, kScreenH)];
        [self.view addSubview:_otherView];
        [UIView animateWithDuration:0.5 animations:^{
            _otherView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        }];
        
        _birthdayPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenH-200, kScreenW, 200)];
        _birthdayPickerView.delegate = self;
        _birthdayPickerView.dataSource = self;
        _birthdayPickerView.backgroundColor = kWhite(.9);
        [_otherView addSubview:_birthdayPickerView];
        _birthdayPickerView.tag = 301;
        
        UIButton* cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        cancelBtn.frame = CGRectMake(0,CGRectGetMinY(_birthdayPickerView.frame), 50, 30);
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_otherView addSubview:cancelBtn];
        UIButton* okBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        okBtn.frame = CGRectMake(kScreenW-60, CGRectGetMinY(_birthdayPickerView.frame), 60, 30);
        [okBtn setTitle:@"确认" forState:(UIControlStateNormal)];
        [okBtn addTarget:self action:@selector(birthdayOk) forControlEvents:(UIControlEventTouchUpInside)];
        [_otherView addSubview:okBtn];

        
    }
    else if(indexPath.row == 1 && indexPath.section == 1){
        EditEmailVC* editEmailVC = [[EditEmailVC alloc]init];
        editEmailVC.hidesBottomBarWhenPushed = YES;
        editEmailVC.model = _model;
        [self.navigationController pushViewController:editEmailVC animated:YES];
    }
    else if(indexPath.row == 2 && indexPath.section == 1){
        AddrVC* addrVC = [[AddrVC alloc]init];
        addrVC.hidesBottomBarWhenPushed = YES;
    
        [self.navigationController pushViewController:addrVC animated:YES];
    }
    else {
        
    }
}

#pragma mark - pickerView代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    if (_sexPickerView == pickerView) {
        return 1;
    }
    else if(_birthdayPickerView == pickerView){
       return 3;
    }
    return 0;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (_sexPickerView == pickerView) {
        return _sexDataArr.count;
    }
    else if(_birthdayPickerView == pickerView){
        if (component == 0) {
            return _year.count;
        }
        else if(component == 1){
            return _month.count;
        }
        else {
            return _day.count;
        }

    }
    return 0;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(_sexPickerView == pickerView){
        return _sexDataArr[row];
    }
    else if(_birthdayPickerView == pickerView){
        if (component == 0) {
            NSString* str = [NSString stringWithFormat:@"%@年",_year[row]];
            return str;
        }
        else if (component == 1){
            NSString* str = [NSString stringWithFormat:@"%@月",_month[row]];
            return str;
        }
        else {
            NSString* str = [NSString stringWithFormat:@"%@日",_day[row]];
            return str;
        }
    }
    return nil;
 
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (_birthdayPickerView == pickerView) {
        if(component == 0){
            return 100;
        }
        else if(component == 1){
            return 50;
        }
        else
            return 80;
    }
    return 100;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_sexPickerView == pickerView) {
        _selectedSexIndex = [_sexPickerView selectedRowInComponent:0];
 
//        NSLog(@"%@",selectSex);
    }
    else if(_birthdayPickerView == pickerView){
        NSInteger selectedYear = [_birthdayPickerView selectedRowInComponent:0];
        _selectYear = [_year objectAtIndex:selectedYear];
//        NSLog(@"%@",selectYear);
        
        NSInteger selectedMonth = [_birthdayPickerView selectedRowInComponent:1];
        _selectMonth = [_month objectAtIndex:selectedMonth];
//        NSLog(@"%@",selectMonth);
        
        NSInteger selectedDay = [_birthdayPickerView selectedRowInComponent:2];
        _selectDay = [_day objectAtIndex:selectedDay];
//        NSLog(@"%@",selectDay);
        
    }
   
    
}
#pragma mark - pickerView点击事件
-(void)sexOk{
    NSString* sex;
    if (_selectedSexIndex == 0) {
        sex = @"1";
    }
    else if(_selectedSexIndex == 1){
        sex = @"2";
    }
   
    
[YYTool postDataWithUrl:@"http://10.30.3.18:8888/appWeb/user/editInfor.json" Body:@{@"userId":@0564,@"token":@"0",@"user":@{
@"userId":[NSNumber numberWithInteger:_model.userId],
@"userName":_model.userName,
@"activeCredit":[NSNumber numberWithInteger:_model.activeCredit],
@"level":_model.level,
@"iconUrl":_model.iconUrl,
@"sex":_model.sex,
@"realName":_model.realName,
@"birthday":_model.birthday,
@"cardNo":_model.cardNo,
@"mobile":_model.mobile,
@"email":_model.email,
@"addr":_model.addr
}
 }
success:^(NSDictionary *jsonDict) {
if (![jsonDict[@"head"][@"code"] integerValue]) {
 //ok
 _model.sex = sex;
UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
                            [alert show];
                            
}else {
//重新请求
UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改失败" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
                            [alert show];
     }
                        
} failure:^(NSError *error) {
                        
}];
     
    [_otherView removeFromSuperview];

}
-(void)birthdayOk{
    [YYTool postDataWithUrl:@"http://10.30.3.18:8888/appWeb/user/editInfor.json" Body:@{@"userId":@0564,@"token":@"0",@"user":@{
@"userId":[NSNumber numberWithInteger:_model.userId],
@"userName":_model.userName,
@"activeCredit":[NSNumber numberWithInteger:_model.activeCredit],
@"level":_model.level,
@"iconUrl":_model.iconUrl,
@"sex":_model.sex,
@"realName":_model.realName,
@"birthday":_model.birthday,
@"cardNo":_model.cardNo,
@"mobile":_model.mobile,
@"email":_model.email,
@"addr":_model.addr
}
  }
success:^(NSDictionary *jsonDict) {
if (![jsonDict[@"head"][@"code"] integerValue]) {
//ok
    NSString* birthdayStr = [NSString stringWithFormat:@"%@-%@-%@",_selectYear,_selectMonth,_selectDay];
    NSLog(@"%@",birthdayStr);
_model.birthday = birthdayStr;
UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功"delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil];
 [alert show];
                            
}else {
//重新请求
 UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改失败"delegate:self cancelButtonTitle:@"关闭" otherButtonTitles: nil];
   [alert show];
}
                        
} failure:^(NSError *error) {
                        
}];
    
    [_otherView removeFromSuperview];
    

}
-(void)cancelAction{
    [_otherView removeFromSuperview];
}

@end
