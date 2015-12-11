//
//  ButtonCell.h
//  YYSportsProject
//
//  Created by k on 15/11/23.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonCellModel.h"
@interface ButtonCell : UITableViewCell
@property (nonatomic, strong) ButtonCellModel * model;
@property (nonatomic, copy) void(^click)(NSInteger tag);
@property (nonatomic, assign) CGFloat cellHeight;
@end
