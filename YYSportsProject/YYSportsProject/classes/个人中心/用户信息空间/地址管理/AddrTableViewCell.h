//
//  AddrTableViewCell.h
//  YYSportsProject
//
//  Created by Tomi on 15/11/24.
//  Copyright © 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddrModel.h"
@interface AddrTableViewCell : UITableViewCell
@property(nonatomic,strong)AddrModel* model;
@property(nonatomic,copy)void(^click)(NSInteger tag,NSInteger row);
@property (nonatomic, strong) NSIndexPath * indexPath;
@end
