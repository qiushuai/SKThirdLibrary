//
//  SKNetWorking.m
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/24.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKNetWorking.h"
#import "KSRequestURL.h"
#import "NSObject+Parse.h"
#import "SKNetwork.h"
#import "SKOvedrueManager.h"
@implementation SKNetWorking

/** 账号登录 */
//+ (void)requestAccountLoginaccount:(NSString *) account
//                          password:(NSString *) password
//                            succes:(void(^)(SKAccountLoginDataModel *dataModel))succes
//                           failure:(requestFailure)failure{
//    NSDictionary *params = @{@"account" : account,
//                             @"password" : password,
//                             @"userType" : @(1)
//                             };
//    [[SKNetworkManager sharedManager] sendPostRequest:accountLogin
//                                           parameters:params
//                                              success:^(id responseObject, BOOL isCacheObject)
//     {
//[[SKOvedrueManager sharedOvedrueManager] showInObject:responseObject];//其他接口，加这一句判断是否登录过期
//         !succes ?: succes([SKAccountLoginDataModel parse:responseObject]);
//     } failure:^(NSURLSessionTask *task, NSError *error, NSInteger statusCode) {
//         !failure ?: failure(task, error, statusCode);
//     }];
//}

@end
