//
//  UserVC.m
//  YYSportsProject
//
//  Created by 江 on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "UserVC.h"
#import "UserView.h"
#import "UserIconView.h"
#import "UserInformationViewController.h"
#import "AddrVC.h"
#import "UDBtn.h"
@interface UserVC ()
{
    NSArray* _orderArr;
    NSArray* _userInfoArr;
    NSArray* _dataArr;
    NSArray* _iconArr;
    NSArray* _iconArr2;
    
    UIScrollView * _scrollView;
    UserView * _userView;
}
    
@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = kWhite(1);
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    
    _orderArr = @[@"待付款",@"待发货",@"待收货",@"退货款"];
    _userInfoArr = @[@"收藏夹",@"足迹",@"我的资产",@"我的评价",@"地址管理",@"YY会员",@"帮助中心",@"每日签到"];
    _iconArr = @[@"待付款48x48",@"待发货48x48",@"待收货48x48",@"退换款48x48"];
    _iconArr2 = @[@"收藏夹82x82",@"足迹82x82",@"我的资产82x82",@"我的评价82x82",@"地址管理82x82",@"设置82x82",@"帮助82x82",@"每日签到82x82"];
    [self configNav];
    [self configUI];
    [self config];//请求里有
    
}
#pragma mark - 布局
- (void)configNav {
    self.navigationItem.title = @"个人中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    //消息
    UIImageView* messageBtn = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 33, 33)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];
    messageBtn.userInteractionEnabled = YES;
    messageBtn.image = [UIImage imageNamed:@"nav_message"];
    UITapGestureRecognizer* messageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchMessage)];
    [messageBtn addGestureRecognizer:messageTap];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:messageBtn];

}
- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView* scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = kWhite(0.9);
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    //用户信息
    UserView* userView = [[UserView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 120)];
    _userView = userView;
    [scrollView addSubview:userView];
    UITapGestureRecognizer* userViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchUserView)];
    
    [userView addGestureRecognizer:userViewTap];
//    [self loadData];
}


#pragma  mark - 加载数据
- (void)loadData {
//    本地数据调试
//    NSData* data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"个人中心.txt" ofType:nil]];
//    NSString* str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//     NSLog(@"1%@",str);
//    
//     NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
//    
//  
//        NSLog(@"2%@",dict);
//
//        UserModel* model = [[UserModel alloc]init];
//        [model setValuesForKeysWithDictionary:dict];
//        _dataArr = @[model];


    //网络数据调试
    [YYTool postDataWithUrl:@"http://10.30.3.18:8888/appWeb/user/index.json" Body:@{@"userId":@0564,@"token":@"0"} success:^(NSDictionary *jsonDict) {
        
//        NSLog(@"-----%@",jsonDict);
        UserModel* model = [[UserModel alloc]init];
        NSDictionary * dic = jsonDict[@"body"][@"user"];
        
        [model setValuesForKeysWithDictionary:dic];
        
        
       _dataArr = @[model];
        [self config];
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)config{
    _userView.model = _dataArr[0];
    
    UIImageView* rightAccessory1 = [[UIImageView alloc]init];
    rightAccessory1.image = [UIImage imageNamed:@"accessory1"];
    [_userView addSubview:rightAccessory1];
    [rightAccessory1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_userView).offset(-20);
        make.centerY.equalTo(_userView);
        make.height.width.mas_equalTo(20);
    }];
    
    
    UIView* orderView = [[UIView alloc]init];
    orderView.backgroundColor = kWhite(1);
    [_scrollView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userView.mas_bottom).offset(17);
        make.left.right.equalTo(_userView);
        make.height.mas_equalTo(40);
    }];
    UITapGestureRecognizer* orderViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchOrder)];
    [orderView addGestureRecognizer:orderViewTap];
    
    UILabel* orderLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 80, 20)];
    orderLabel.text = @"我的订单";
    orderLabel.textColor = kRGB(34, 34, 34);
    orderLabel.font = [UIFont systemFontOfSize:16];
    [orderView addSubview:orderLabel];
    
    UILabel* orderSubtitleLabel = [[UILabel alloc]init];
    orderSubtitleLabel.text = @"查看全部订单";
    orderSubtitleLabel.font = [UIFont systemFontOfSize:14];
    orderSubtitleLabel.textColor = kRGB(215, 215, 215);
    [orderView addSubview:orderSubtitleLabel];
    [orderSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderLabel);
        make.right.equalTo(orderView.mas_right).offset(-60);
    }];
    
    UIImageView* rightAccessory2 = [[UIImageView alloc]init];
    rightAccessory2.image = [UIImage imageNamed:@"accessory1"];
    [orderView addSubview:rightAccessory2];
    [rightAccessory2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(orderView.mas_right).offset(-20);
        make.centerY.equalTo(orderView);
        make.height.width.mas_equalTo(15);
    }];
    //订单状态栏
    UIView * orderView2 = [[UIView alloc]init];
    orderView2.backgroundColor = kWhite(1);
    [_scrollView addSubview:orderView2];
    [orderView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderView.mas_bottom).offset(1);
        make.left.right.equalTo(orderView);
        make.height.mas_equalTo(75);
    }];
    
    
    CGFloat marginX = (kScreenW - 4 * 40)/(((4-1)*2)+2);
    CGFloat marginY = (180 - 2 * 65)/3;
    
    for (int k = 0; k < _orderArr.count; k++) {
        //        UserIconView* userIconView = [[UserIconView alloc]initWithFrame:CGRectMake(marginX+k*(2*marginX + 40), 17, 40, 30)];
        
        UDBtn* udBtn = [[UDBtn alloc]initWithFrame:CGRectMake(marginX+k*(2*marginX + 40), 17, 50, 30)];
        udBtn.type = 1;
        [udBtn setTitleColor:kRGB(153, 153, 153) forState:(UIControlStateNormal)];
        udBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [udBtn setTitle:_orderArr[k] forState:(UIControlStateNormal)];
        [udBtn setImage:[UIImage imageNamed:_iconArr[k]] forState:(UIControlStateNormal)];
        //        UserIconModel * model = [[UserIconModel alloc]init];
        //        model.name = _orderArr[k];
        //        model.image = _iconArr[k];
        //        userIconView.model = model;
        [orderView2 addSubview:udBtn];
        
        /*       udBtn.tag = 10 + k;
         __weak UIView* tempView = userIconView;
         userIconView.touch = ^(){
         NSLog(@"touch:%ld",tempView.tag);
         
         switch (tempView.tag) {
         case 10:
         
         break;
         case 11:
         
         break;
         case 12:
         
         break;
         case 13:
         
         break;
         default:
         break;
         }
         
         };
         */
    }
    
    //个人设置
    UIView* userInfoView = [[UIView alloc]init];
    userInfoView.backgroundColor = kWhite(1);
    [_scrollView addSubview:userInfoView];
    [userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderView2.mas_bottom).offset(17);
        make.left.right.equalTo(orderView2);
        make.height.mas_equalTo(180);
//        make.bottom.equalTo(_scrollView.mas_bottom);
    }];
    
    //画分割线
    UIView* rowView = [[UIView alloc]initWithFrame:CGRectMake(0,180/2, kScreenW, 1)];
    rowView.backgroundColor = kWhite(.9);
    [userInfoView addSubview:rowView];
    
    CGFloat line = kScreenW/4;
    
    for (int l = 0; l<4; l++) {
        UIView* lineView = [[UIView alloc]init];
        lineView.backgroundColor = kWhite(.9);
        lineView.frame = CGRectMake(line*l,0, 1, 180);
        [userInfoView addSubview:lineView];
    }
    int n = 0;
    for (int j = 0; j < 2; j++) {
        for (int k = 0; k < 4; k++) {
            UserIconView * userIconView = [[UserIconView alloc]initWithFrame:CGRectMake(marginX + k*(2*marginX + 40), j* (marginY + 75)+marginY, 40, 40)];
            
            UserIconModel* model = [[UserIconModel alloc]init];
            model.name = _userInfoArr[n];
            model.image = _iconArr2[n];
            n++;
            userIconView.model = model;
            
            [userInfoView addSubview:userIconView];
            
            userIconView.tag = 100 + j*4 + k;
            __weak UIView* tempView = userIconView;
            userIconView.touch = ^(){
                NSLog(@"touch: %ld",tempView.tag);
                
                switch (tempView.tag) {
                    case 100:{
                        
                    }
                        break;
                    case 101:
                        
                        break;
                    case 102:
                        
                        break;
                    case 103:
                        
                        break;
                    case 104:{
                        AddrVC* addrVC = [[AddrVC alloc]init];
                        addrVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:addrVC animated:YES];
                    }
                        
                        break;
                    case 105:
                        
                        break;
                    case 106:
                        
                        break;
                    case 107:
                        
                        break;
                    default:
                        break;
                }
            };
        }
    }

}
-(UserModel*)requsetUserModel{
    UserModel* model = [UserModel new];
    model = _dataArr[0];
    return model;
}
-(void)touchMessage{
    NSLog(@"test!!!");
}
-(void)touchUserView{
    UserInformationViewController* userInformationVC = [[UserInformationViewController alloc]init];
    userInformationVC.hidesBottomBarWhenPushed = YES;
    userInformationVC.model = _dataArr[0];
    
    [self.navigationController pushViewController:userInformationVC animated:YES];
}
-(void)touchOrder{
    NSLog(@"order!!");
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
