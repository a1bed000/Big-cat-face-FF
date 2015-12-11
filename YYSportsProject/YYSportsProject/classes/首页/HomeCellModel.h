//
//  HomeCellModel.h
//  YYSportsProject
//
//  Created by k on 15/11/20.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCellModel : NSObject
@property (nonatomic, copy) NSString * rootTitle;
@property (nonatomic, strong) ToPageModel * rootAdData;
@property (nonatomic, strong) NSMutableArray * subAdList;
@end
