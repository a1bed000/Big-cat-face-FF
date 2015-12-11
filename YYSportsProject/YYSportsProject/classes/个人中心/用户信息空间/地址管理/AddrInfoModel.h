//
//  AddrInfoModel.h
//  YYSportsProject
//
//  Created by Tomi on 15/11/26.
//  Copyright © 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddrInfoModel : NSObject
@property (nonatomic, copy) NSString * subject;
@property (nonatomic, copy) NSString * placeholder;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) BOOL isDefault;

@end
