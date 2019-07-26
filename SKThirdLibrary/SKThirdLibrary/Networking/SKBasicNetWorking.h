//
//  SKBasicNetWorking.h
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/24.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 请求成功的回调block */
typedef void(^requestSucces)(id responseObject);

/** 请求失败的回调block */
typedef void(^requestFailure)(NSURLSessionTask *task, NSError *error, NSInteger statusCode);

/** 请求状态码 */
typedef NS_ENUM(NSUInteger, SKRequestCodeStatus)  {
    SKRequestSuccess                 =  200,     //  请求成功
    SKRequestFailure            =  202,   //  失败
    SKRequestNotLogin                =  401,   //  失败-未授权/未登录
    SKRequestParamError              =  500,   //  失败-接口内部错误
};
NS_ASSUME_NONNULL_BEGIN

@interface SKBasicNetWorking : NSObject
    
#pragma mark - ============== Public Config ==============
    
    /** 默认配置 */
+ (void)baseConfig;
    
    /** 添加请求头键值对 */
+ (void)addCustomHeader:(NSDictionary *)header;
    
    /** 添加默认请求参数 */
+ (void)addDefaultParameters:(NSDictionary *)paramsters;
    
    
    /** 清除缓存 */
+ (void)clearNetworkingCache;
    
    /** 计算网络数据缓存 */
+ (void)calculateAllCacheSize:(void (^)(double cacheSize))cache;
    
    @end

NS_ASSUME_NONNULL_END
