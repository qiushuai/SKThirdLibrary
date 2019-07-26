//
//  SKNetworkRequestEngine.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKNetworkBaseEngine.h"
NS_ASSUME_NONNULL_BEGIN
/* =============================
 *
 * SKNetworkRequestEngine
 *
 * SKNetworkRequestEngine is in charge of sending GET,POST,PUT or DELETE requests.
 *
 * =============================
 */

@interface SKNetworkRequestEngine : SKNetworkBaseEngine



/**
 *  This method offers the most number of parameters of a certain network request.
 *
 *
 *  @note:
 *
 *        1. SKRequestMethod:
 *
 *             a) If the method is set to be 'SKRequestMethodGET', then send GET request
 *             b) If the method is set to be 'SKRequestMethodPOST', then send POST request
 *             c) If the method is set to be 'SKRequestMethodPUT', then send PUT request
 *             d) If the method is set to be 'SKRequestMethodDELETE', then send DELETE request
 *
 *
 *        2. If 'loadCache' is set to be YES, then cache will be tried to
 *           load before sending network request no matter if the cache exists:
 *           If it exists, then load it and callback immediately.
 *           If it dose not exist,then send network request.
 *
 *           If 'loadCache' is set to be NO, then no matter if the cache
 *           exists, network request will be sent.
 *
 *
 *        3. If 'cacheDuration' is set to be large than 0,
 *           then the cache of this request will be written and
 *           the available duration of this cache will be equal to 'cacheDuration'.
 *
 *           So, if the past time is longer than the settled time duration,
 *           the network request will be sent.
 *
 *           If 'cacheDuration' is set to be less or equal to 0, then the cache
 *           of this request will not be written(The unit of cacheDuration is second).
 *
 *
 *  @param url                request url
 *  @param ignoreBaseUrl      consider whether to ignore configured base url
 *  @param method             request method
 *  @param parameters         parameters
 *  @param cacheType          first load cache,then load networt data or only load load networt
 *  @param cacheDuration      consider whether to write cache unit/day (default 30)
 *  @param successBlock       success callback
 *  @param failureBlock       failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
      ignoreBaseUrl:(BOOL)ignoreBaseUrl
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;


@end

NS_ASSUME_NONNULL_END
