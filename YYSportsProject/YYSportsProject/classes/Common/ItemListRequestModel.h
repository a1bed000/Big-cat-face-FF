//
//  ItemListRequestModel.h
//  YYSportsProject
//
//  Created by k on 15/11/20.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger currentPage;
@end


@interface ItemListRequestModel : NSObject
@property (nonatomic, copy) NSString * keyword;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * ruleType;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSMutableArray * brands;

@property (nonatomic, copy) NSString * classifyId;

@property (nonatomic, strong) Page * page;

@end
