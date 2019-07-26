//
//  SKNetworkCacheInfo.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>
/* =============================
 *
 * SKNetworkCacheInfo
 *
 * SKNetworkCacheInfo is in charge of recording the infomation of cache which is related to a specific network request
 *
 * =============================
 */

@interface SKNetworkCacheInfo : NSObject<NSSecureCoding>

// Record the creation date of the cache
@property (nonatomic, readwrite, strong) NSDate *creationDate;

// Record the length of the period of validity (unit is second)
@property (nonatomic, readwrite, strong) NSNumber *cacheDuration;

// Record the app version when the cache is created
@property (nonatomic, readwrite, copy)   NSString *appVersionStr;

// Record the request identifier of the cache
@property (nonatomic, readwrite, copy)   NSString *reqeustIdentifer;
@end
