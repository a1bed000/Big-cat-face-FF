//
//  HeaderModel.m
//  YYSportsProject
//
//  Created by k on 15/11/18.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "HeaderModel.h"


@implementation HeaderModel
+ (NSDictionary *)objectClassInArray {
    return @{
             @"topAdList":@"ToPageModel",
             @"buttonList":@"ToPageModel",
             @"carouselTextList":@"ToPageModel"
             };
}
@end
