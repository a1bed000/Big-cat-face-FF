//
//  UserModel.h
//  YYSports
//
//  Created by Tomi on 15/11/12.
//  Copyright © 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property (nonatomic, assign) NSInteger userId;
@property(nonatomic,copy)NSString* userName;
@property(nonatomic,assign)NSInteger activeCredit;
@property(nonatomic,copy)NSString* level;
@property(nonatomic,copy)NSString* iconUrl;
@property(nonatomic,copy)NSString* sex;
@property(nonatomic,copy)NSString* realName;
@property(nonatomic,copy)NSString* birthday;
@property(nonatomic,copy)NSString* cardNo;
@property(nonatomic,copy)NSString* mobile;
@property(nonatomic,copy)NSString* email;
@property(nonatomic,copy)NSString* addr;
@property(nonatomic,copy)NSString* yyVipUrl;
@property(nonatomic,copy)NSString* helpUrl;
@property(nonatomic,copy)NSString* signUrl;

@end
