//
//  UserIconView.h
//  YYSports
//
//  Created by Tomi on 15/11/13.
//  Copyright © 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserIconModel.h"
@interface UserIconView : UIView

@property(nonatomic,strong)UserIconModel* model;
@property(nonatomic,copy)void(^touch)(void);
@end
