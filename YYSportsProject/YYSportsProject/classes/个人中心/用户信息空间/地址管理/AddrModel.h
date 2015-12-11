//
//  AddrModel.h
//  YYSports
//
//  Created by Tomi on 15/11/17.
//  Copyright © 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddrModel : NSObject
@property(nonatomic,assign)NSInteger addrId;
@property(nonatomic,copy)NSString* contact;
@property(nonatomic,copy)NSString* proviceId;
@property(nonatomic,copy)NSString* provice;
@property(nonatomic,copy)NSString* cityId;
@property(nonatomic,copy)NSString* city;
@property(nonatomic,copy)NSString* districtId;
@property(nonatomic,copy)NSString* district;
@property(nonatomic,copy)NSString* detailAddr;
@property(nonatomic,copy)NSString* mobile;
@property(nonatomic,copy)NSString* zipCode;
@property(nonatomic,copy)NSString* email;
@property(nonatomic,copy)NSString* phone;
@property(nonatomic,assign)NSInteger isDefault;
@end
