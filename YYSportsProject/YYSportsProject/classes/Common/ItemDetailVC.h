//
//  ItemDetailVC.h
//  YYSportsProject
//
//  Created by k on 15/11/18.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailModel.h"
@interface ItemDetailVC : UIViewController

@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) NSInteger barCode;


@property (nonatomic, strong) ItemDetailModel * model;
@end
