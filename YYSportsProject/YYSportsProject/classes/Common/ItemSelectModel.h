//
//  ItemSelectModel.h
//  YYSportsProject
//
//  Created by k on 15/11/24.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropValue : NSObject
@property (nonatomic, copy) NSString * propValue;           //不变
@property (nonatomic, assign) NSInteger status;             //随时可变
@property (nonatomic, strong) NSMutableArray * ItemIdList;  //不变
@end

@interface ItemSelectModel : NSObject
@property (nonatomic, copy) NSString * propName;            
@property (nonatomic, strong) NSMutableArray * propList;
@end
