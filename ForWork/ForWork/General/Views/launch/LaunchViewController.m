//
//  LaunchViewController.m
//  ForWork
//
//  Created by 盛愉 on 15/12/24.
//  Copyright © 2015年 盛愉. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController
-(void)initLaunchPage
{
    CGSize screenSize=[UIScreen mainScreen].bounds.size;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    _scrollView.contentSize=CGSizeMake(screenSize.width, screenSize.height*4);
    _scrollView.alwaysBounceVertical=YES;
    _scrollView.delegate=self;
    _scrollView.showsVerticalScrollIndicator=NO;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    UIWindow* window=[[UIWindow alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    window.backgroundColor=[UIColor clearColor];
    window.hidden=NO;
    [window addSubview:self.view];
    
//    self.view.backgroundColor=[UIColor purpleColor];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    
    [self initLaunchPage];
    
    self.label_page1_1=[syLabel syLabelWithText:@"QAQ" font:[UIFont systemFontOfSize:20.0f] color:[UIColor redColor] origin:CGPointMake(140, 200)];
    [self.scrollView addSubview:self.label_page1_1];
    
    self.label_page1_2=[syLabel syLabelWithText:@"可怜的大脸猫" font:[UIFont systemFontOfSize:16] color:[UIColor blueColor] origin:CGPointMake(140, 240)];
    [self.scrollView addSubview:self.label_page1_2];
    
    self.label_page1_3=[syLabel syLabelWithText:@"霏霏你就欺负我好咧" font:[UIFont systemFontOfSize:20.0f] color:[UIColor whiteColor] origin:CGPointMake(140, 280)];
    [self.scrollView addSubview:self.label_page1_3];

    
    [self.view addSubview:self.scrollView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"wuwuwu");
    // Do any additional setup after loading the view.
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
