//
//  HeaderView.h
//  YYSportsProject
//
//  Created by k on 15/11/18.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderModel.h"
@interface HeaderView : UIView
@property (nonatomic, strong) HeaderModel * model;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, copy) void (^touch)(NSInteger tag);

@end
