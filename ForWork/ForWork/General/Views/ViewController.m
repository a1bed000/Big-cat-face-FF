//
//  ViewController.m
//  ForWork
//
//  Created by 盛愉 on 15/12/24.
//  Copyright © 2015年 盛愉. All rights reserved.
//

#import "ViewController.h"
#import "LaunchViewController.h"
@interface ViewController ()
@property(nonatomic)    LaunchViewController* launch;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        NSLog(@"diyici");
        self.launch=[[LaunchViewController alloc]init];
        [self presentViewController:self.launch animated:YES completion:nil];

        
    }else
    {
        NSLog(@"bushidiyici");
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)anxiaqu:(id)sender {
    self.launch=[[LaunchViewController alloc]init];
    [self presentViewController:self.launch animated:YES completion:nil];
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
