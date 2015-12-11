//
//  AddCell.h
//  YYSportsProject
//
//  Created by k on 15/11/25.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCellModel.h"
@interface AddCell : UITableViewCell
@property (nonatomic, strong) AddCellModel * model;
@property (nonatomic, copy) void(^addNum)(NSInteger tag);
@end
