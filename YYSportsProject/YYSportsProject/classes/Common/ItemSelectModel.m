//
//  ItemSelectModel.m
//  YYSportsProject
//
//  Created by k on 15/11/24.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ItemSelectModel.h"
@implementation PropValue
- (instancetype)init {
    if (self = [super init]) {
        _ItemIdList = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end

@implementation ItemSelectModel
- (instancetype)init {
    if (self = [super init]) {
        _propList = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
MJExtensionLogAllProperties
@end
