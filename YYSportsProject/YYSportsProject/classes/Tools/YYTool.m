//
//  YYTool.m
//  YYSports
//
//  Created by k on 15/11/13.
//  Copyright (c) 2015年 k. All rights reserved.
//

#import "YYTool.h"

@implementation YYTool

+ (NSDictionary *)createHead {
    //请求头
    NSMutableDictionary * dictHead = [NSMutableDictionary dictionary];
    [dictHead setObject:kAppCode forKey:@"appCode"];
    [dictHead setObject:kApiVersion forKey:@"version"];
    //发起请求的时间  格式yyyy-MM-dd HH:mm:ss
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * sendTime = [formatter stringFromDate:[NSDate date]];
    [dictHead setObject:sendTime forKey:@"sendTime"];
    //serialNo流水号 1970至今毫秒数+四位随机数
    UInt64 timeSince1970 = [[NSDate date] timeIntervalSince1970]*1000;
    NSString * serialNo = [NSString stringWithFormat:@"%llu%04d",timeSince1970,arc4random()%10000];
    [dictHead setObject:serialNo forKey:@"serialNo"];
    return dictHead;
}

+ (void)getDataWithUrl:(NSString *)url Body:(NSDictionary *)body success:(Success)success failure:(Failure)failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSUserDefaults * userdef = [NSUserDefaults standardUserDefaults];
    if ([userdef valueForKey:@"userId"]) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[userdef valueForKey:@"userId"]] forHTTPHeaderField:@"userId"];
    }
    if ([userdef valueForKey:@"token"]) {
        [manager.requestSerializer setValue:[userdef valueForKey:@"token"] forHTTPHeaderField:@"token"];
    }
    
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[YYTool createHead] forKey:@"head"];
    if (body) {//请求body应该不为nil
        [parameters setObject:body forKey:@"body"];
    }
    
    [manager GET:url parameters:@{@"params":parameters} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
        switch ([jsonDict[@"head"][@"code"] integerValue]) {
            case 0:
            {
                //请求的操作成功
                
            }
                break;
            case 1:
            {
                //请求的操作失败
                
            }
                break;
            case 2:
            {
                //需要重新登录
                
            }
                break;
            case 3:
            {
                //请求的参数有误
            }
                break;
            default:
                break;
        }
        
        success(jsonDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    
}
+ (void)postDataWithUrl:(NSString *)url Body:(NSDictionary *)body success:(Success)success failure:(Failure)failure {
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    
    NSUserDefaults * userdef = [NSUserDefaults standardUserDefaults];
    if ([userdef valueForKey:@"userId"]) {
        
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[userdef valueForKey:@"userId"]] forHTTPHeaderField:@"userId"];
    }
    if ([userdef valueForKey:@"token"]) {
        [manager.requestSerializer setValue:[userdef valueForKey:@"token"] forHTTPHeaderField:@"token"];
    }

    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[YYTool createHead] forKey:@"head"];
    if (body) {//请求body应该不为nil
        [parameters setObject:body forKey:@"body"];
    }
    
    NSString * str = [parameters JSONString];
    
    NSLog(@"请求字段:%@",str);
    
    
    
    [manager POST:url parameters:@{@"params":str} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
        
        success(jsonDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];
}
+ (NSInteger)loginWithUser:(NSString *)user psw:(NSString *)psw finish:(Finish)finish {
    
    return 1;
}
@end
