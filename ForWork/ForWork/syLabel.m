//
//  syLabel.m
//  ForWork
//
//  Created by 盛愉 on 15/12/23.
//  Copyright © 2015年 盛愉. All rights reserved.
//

#import "syLabel.h"

@implementation syLabel

+(instancetype)syLabelWithText:(NSString*)text font:(UIFont*)font color:(UIColor*)color origin:(CGPoint)origin
{
    syLabel* label=[[syLabel alloc]initWithFrame:CGRectMake(origin.x, origin.y, 1000, 20)];
    label.text=text;
    label.font=font;
    label.textColor=color;
    [label sizeToFit];
    return label;
}

@end
