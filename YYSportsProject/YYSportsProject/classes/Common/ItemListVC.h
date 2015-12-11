//
//  ItemListVC.h
//  YYSportsProject
//
//  Created by 江 on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemListRequestModel;
@interface ItemListVC : UIViewController

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, strong) ItemListRequestModel * itemSearch;

@end
