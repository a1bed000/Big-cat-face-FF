//
//  CarouselTextCell.h
//  YYSportsProject
//
//  Created by k on 15/11/23.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselTextCellModel.h"
@interface CarouselTextCell : UITableViewCell
@property (nonatomic, strong) CarouselTextCellModel * model;
@property (nonatomic, copy) void(^click)(NSInteger tag);
@end
