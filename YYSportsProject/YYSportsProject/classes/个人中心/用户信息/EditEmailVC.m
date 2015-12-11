//
//  EdtiEmailVC.m
//  YYSportsProject
//
//  Created by Tomi on 15/11/18.
//  Copyright © 2015年 k. All rights reserved.
//

#import "EditEmailVC.h"

@interface EditEmailVC ()
{
    UITextField* _textField;
    UILabel* _label;
}
@end

@implementation EditEmailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhite(.9);
    [self configNav];
    [self configUI];
    // Do any additional setup after loading the view.
}
-(void)configNav{
    self.navigationItem.title = @"修改邮箱";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:(UIBarButtonItemStylePlain) target:self action:@selector(settingOk)];
}
-(void)configUI{
    UIView* textView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 40)];
    textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textView];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(17, 0, kScreenW-17, 40)];
    _textField.autocorrectionType = UITextAutocorrectionTypeYes;
    _textField.backgroundColor = kWhite(1);
    _textField.text = _model.email;
    _textField.placeholder = @"输入Email";
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    [textView addSubview:_textField];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(_textField.frame),kScreenW,40)];
    _label.text = @"请正确填写邮件格式,例如:YYSports@163.com";
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor = kWhite(.5);
    [textView addSubview:_label];
}
-(void)settingOk{
    
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
    _model.email = _textField.text;
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
    
    [self.navigationController popViewControllerAnimated:YES];
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
