//
//  SKNetworkConfig.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKImageScaleTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKNetworkConfig : NSObject

// Base url of requests, default is nil
@property (nonatomic, strong) NSString *_Nullable baseUrl;

// Default parameters, default is nil
@property (nonatomic, readonly, strong) NSDictionary * _Nullable defaultParameters;

// Custom headers, default is nil
@property (nonatomic, readonly, strong) NSDictionary * _Nullable customHeaders;

// Request timeout seconds, default is 30 (unit is second)
@property (nonatomic, assign) NSTimeInterval timeoutSeconds;

// If debugMode is set to be YES, then print all detail log
@property (nonatomic, assign) BOOL debugMode;



/**
 *  SKNetworkConfig Singleton
 *
 *  @return sharedConfig singleton instance
 */
+ (SKNetworkConfig *_Nullable)sharedConfig;



/**
 *  This method is used to add request headers (key-value pair(or pairs))
 *
 *  @param header               custom header to be added into request
 *
 */
- (void)addCustomHeader:(NSDictionary *_Nonnull)header;


/**
 *  This method is used to add request default paramters (key-value pair(or pairs))
 *
 *  @param paramters               default paramters to be added into request
 *
 */
- (void)addDefaultParameters:(NSDictionary *_Nonnull)paramters;

@end

NS_ASSUME_NONNULL_END
