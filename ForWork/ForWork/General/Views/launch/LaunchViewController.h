//
//  LaunchViewController.h
//  ForWork
//
//  Created by 盛愉 on 15/12/24.
//  Copyright © 2015年 盛愉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "syLabel.h"

@interface LaunchViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic)UIScrollView *scrollView;
@property(nonatomic)syLabel *label_page1_1,*label_page1_2,*label_page1_3;
@property (nonatomic) IBOutlet UIButton *tiaozhuan;

@end