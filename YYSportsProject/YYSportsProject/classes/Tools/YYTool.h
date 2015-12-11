//
//  YYTool.h
//  YYSports
//
//  Created by k on 15/11/13.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(NSDictionary * jsonDict);
typedef void(^Failure)(NSError *error);
typedef void(^Finish)(void);
@interface YYTool : NSObject

+ (void)getDataWithUrl:(NSString *)url Body:(NSDictionary *)body success:(Success)success failure:(Failure)failure;

+ (void)postDataWithUrl:(NSString *)url Body:(NSDictionary *)body success:(Success)success failure:(Failure)failure;

+ (NSInteger)loginWithUser:(NSString *)user psw:(NSString *)psw finish:(Finish)finish;

@end
