//
//  ClassificationSubjectModel.m
//  YYSportsProject
//
//  Created by k on 15/11/26.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "ClassificationSubjectModel.h"

@implementation ClassificationSubjectModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+ (NSDictionary *)objectClassInArray {
    return @{@"subClassifyList":@"SubClassifyModel"};
}
@end
