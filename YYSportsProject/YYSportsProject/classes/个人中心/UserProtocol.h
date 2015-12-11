//
//  UserProtocol.h
//  YYSportsProject
//
//  Created by Tomi on 15/11/22.
//  Copyright © 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserModel.h"
@protocol UserProtocol <NSObject>
-(UserModel*)requsetUserModel;
//-(void)settingOkWithUserModel:(UserModel*)userModel;
@end
