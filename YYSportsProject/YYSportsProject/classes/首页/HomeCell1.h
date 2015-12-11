//
//  HomeCell1.h
//  YYSportsProject
//
//  Created by k on 15/11/20.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCellModel.h"
@interface HomeCell1 : UITableViewCell
@property (nonatomic, strong) HomeCellModel * model;
@property (nonatomic, copy) void(^click)(NSInteger tag);
@end
