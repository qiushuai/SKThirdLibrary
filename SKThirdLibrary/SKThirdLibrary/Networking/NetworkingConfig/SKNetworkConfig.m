//
//  SKNetworkConfig.m
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKNetworkConfig.h"

@interface SKNetworkConfig()

@property (nonatomic, readwrite, strong) NSDictionary *customHeaders;
@property (nonatomic, readwrite, strong) NSDictionary *defaultParametersdefaultParameters;

@end

@implementation SKNetworkConfig

+ (SKNetworkConfig *)sharedConfig {
    
    static SKNetworkConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.timeoutSeconds = 30;
    });
    return sharedInstance;
}


- (void)addCustomHeader:(NSDictionary *)header{
    
    if (![header isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if ([[header allKeys] count] == 0) {
        return;
    }
    
    if (!_customHeaders) {
        _customHeaders = header;
        return;
    }
    
    //add custom header
    NSMutableDictionary *headers_m = [_customHeaders mutableCopy];
    [header enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
        [headers_m setObject:value forKey:key];
    }];
    
    
    NSLog(@"headers_m 0 %@", headers_m);
    
    
    _customHeaders = [headers_m copy];
    
}


- (void)addDefaultParameters:(NSDictionary *)paramters {
    
    if (![paramters isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if ([[paramters allKeys] count] == 0) {
        return;
    }
    
    if (!_defaultParameters) {
        _defaultParameters = paramters;
        return;
    }
    
    //add default parameters
    NSMutableDictionary *paramters_m = [_defaultParameters mutableCopy];
    [paramters enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
        [paramters_m setObject:value forKey:key];
    }];
    
    _defaultParameters = [paramters_m copy];
}

@end
