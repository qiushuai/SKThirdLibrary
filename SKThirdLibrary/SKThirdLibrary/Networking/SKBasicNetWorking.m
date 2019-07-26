//
//  SKBasicNetWorking.m
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/24.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKBasicNetWorking.h"
#import "KSRequestURL.h"
@implementation SKBasicNetWorking
    
    + (void)baseConfig {
        [SKNetworkConfig sharedConfig].baseUrl = baseUrl;
        [SKNetworkConfig sharedConfig].timeoutSeconds = 30;
        //    [SKNetworkConfig sharedConfig].debugMode = YES;
    }
    
    + (void)addCustomHeader:(NSDictionary *)header {
        [[SKNetworkConfig sharedConfig] addCustomHeader:header];
    }
    
    + (void)addDefaultParameters:(NSDictionary *)paramsters {
        [[SKNetworkConfig sharedConfig] addDefaultParameters:paramsters];
    }
    
    + (void)clearNetworkingCache {
        [[SKNetworkCacheManager sharedManager] clearAllCacheCompletionBlock:^(BOOL isSuccess) {
            
        }];
    }
    
    + (void)calculateAllCacheSize:(void (^)(double cacheSize))cache {
        [[SKNetworkCacheManager sharedManager] calculateAllCacheSizecompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize, NSString * _Nonnull totalSizeString)
         {
             double cacheSize = totalSize * 1.0 / 1024;
             !cache ?: cache(cacheSize);
         }];
    }
    @end
