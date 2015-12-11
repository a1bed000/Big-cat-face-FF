//
//  ItemListModel.h
//  YYSportsProject
//
//  Created by 江 on 15/11/17.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemListModel : NSObject

@property (nonatomic, assign) NSInteger column;

@property (nonatomic, assign) NSInteger integral;
@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) float preferentialPrice;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) float yyPrice;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * thumbImg;
@property (nonatomic, copy) NSString * itemName;
@property (nonatomic, copy) NSString * ruleType;

@end
