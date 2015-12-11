//
//  AddCellModel.h
//  YYSportsProject
//
//  Created by k on 15/11/25.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddCellModel : NSObject
@property (nonatomic, assign) NSInteger itemNum;
@property (nonatomic, assign) NSInteger itemStock;
@property (nonatomic, assign) BOOL canAdd;
@property (nonatomic, assign) BOOL canReduce;
@end
