//
//  ItemSelectCell.h
//  YYSportsProject
//
//  Created by k on 15/11/24.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemSelectModel.h"
@interface ItemSelectCell : UITableViewCell
@property (nonatomic, strong) ItemSelectModel * model;
@property (nonatomic, strong) NSIndexPath * cellIndex;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) void(^btnTouch)(NSInteger tag);
@end
