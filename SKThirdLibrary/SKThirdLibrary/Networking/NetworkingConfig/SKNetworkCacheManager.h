//
//  SKNetworkCacheManager.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SKNetworkRequestModel;
@class SKNetworkDownloadResumeDataInfo;


// Callback when the cache is cleared
typedef void(^SKClearCacheCompletionBlock)(BOOL isSuccess);

// Callback when the cache is loaded
typedef void(^SKLoadCacheCompletionBlock)(id _Nullable cacheObject);

// Callback when cache array is loaded
typedef void(^SKLoadCacheArrCompletionBlock)(NSArray * _Nullable cacheArr);

// Callback when the size of cache is calculated
typedef void(^SKCalculateSizeCompletionBlock)(NSUInteger fileCount, NSUInteger totalSize, NSString * _Nonnull totalSizeString);



/* =============================
 *
 * SKNetworkCacheManager
 *
 * SKNetworkCacheManager is in charge of managing operations of oridinary request cache(and cache info) and resume data (and resume data info)of a certain download request
 *
 * =============================
 */
NS_ASSUME_NONNULL_BEGIN

@interface SKNetworkCacheManager : NSObject

/**
 *  SKNetworkCacheManager Singleton
 *
 *  @return SKNetworkCacheManager singleton instance
 */
+ (SKNetworkCacheManager *_Nonnull)sharedManager;





//============================ Write Cache ============================//

/**
 *  This method is used to write cache(cache data and cache info),
 can only be called by SKNetworkManager instance
 *
 *  @param requestModel        the model holds the configuration of a specific request
 *  @param asynchronously      if write cache asynchronously
 *
 */
- (void)writeCacheWithReqeustModel:(SKNetworkRequestModel * _Nonnull)requestModel asynchronously:(BOOL)asynchronously;




//============================= Load cache =============================//


/**
 *  This method is used to load cache which is related to a specific url,
 no matter what request method is or parameters are
 *
 *
 *  @param url                  the url of related network requests
 *  @param completionBlock      callback
 *
 */
- (void)loadCacheWithUrl:(NSString * _Nonnull)url completionBlock:(SKLoadCacheArrCompletionBlock _Nullable)completionBlock;




- (void)loadCacheWithUrl:(NSString * _Nonnull)url
                  method:(NSString * _Nonnull)method
         completionBlock:(SKLoadCacheArrCompletionBlock _Nullable)completionBlock;



/**
 *  This method is used to load cache which is related to a specific url,method and parameters
 *
 *  @param url                  the url of the network request
 *  @param method               the method of the network request
 *  @param parameters           the parameters of the network request
 *  @param completionBlock      callback
 *
 */
- (void)loadCacheWithUrl:(NSString * _Nonnull)url
                  method:(NSString * _Nonnull)method
              parameters:(id _Nullable)parameters
         completionBlock:(SKLoadCacheCompletionBlock _Nullable)completionBlock;





/**
 *  This method is used to load cache which is related to a identier which is the unique to a network request,
 can only be called by SKNetworkManager instance
 *
 *  @param requestIdentifer     the unique identier of a specific  network request
 *  @param completionBlock      callback
 *
 */
- (void)loadCacheWithRequestIdentifer:(NSString * _Nonnull)requestIdentifer completionBlock:(SKLoadCacheCompletionBlock _Nullable)completionBlock;





//============================ calculate cache ============================//

/**
 *  This method is used to calculate the size of the cache folder (include ordinary request cache and download resume data file and resume data info file)
 *
 *  @param completionBlock      finish callback
 *
 */
- (void)calculateAllCacheSizecompletionBlock:(SKCalculateSizeCompletionBlock _Nullable)completionBlock;





//============================== clear cache ==============================//

/**
 *  This method is used to clear all cache which is in the cache folder
 *
 *  @param completionBlock      callback
 *
 */
- (void)clearAllCacheCompletionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock;




/**
 *  This method is used to clear the cache which is related the specific url,
 no matter what request method is or parameters are
 *
 *  @param url                   the url of network request
 *  @param completionBlock       callback
 *
 */
- (void)clearCacheWithUrl:(NSString * _Nonnull)url completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock;




- (void)clearCacheWithUrl:(NSString * _Nonnull)url
                   method:(NSString * _Nonnull)method
          completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock;


/**
 *  This method is used to clear cache which is related to a specific url,method and parameters
 *
 *  @param url                  the url of the network request
 *  @param method               the method of the network request
 *  @param parameters           the parameters of the network request
 *  @param completionBlock      callback
 *
 */
- (void)clearCacheWithUrl:(NSString * _Nonnull)url
                   method:(NSString * _Nonnull)method
               parameters:(id _Nullable)parameters
          completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock;



//============================== Update resume data or resume data info ==============================//

/**
 *  This method is used to update resume data info after suspending a download request
 *
 *  @param requestModel      request model of a network requst
 *
 */
- (void)updateResumeDataInfoAfterSuspendWithRequestModel:(SKNetworkRequestModel *_Nonnull)requestModel;




/**
 *  This method is used to remove resume data and resume data info files
 *
 *  @param requestModel      request model of a network requst
 *
 */
- (void)removeResumeDataAndResumeDataInfoFileWithRequestModel:(SKNetworkRequestModel *_Nonnull)requestModel;





/**
 *  This method is used to remove download data to target download file path and clear the resume data info file
 *
 *  @param requestModel      request model of a network requst
 *
 */
- (void)removeCompleteDownloadDataAndClearResumeDataInfoFileWithRequestModel:(SKNetworkRequestModel *_Nonnull)requestModel;




//============================== Load resume data info ==============================//

/**
 *  This method is used to load resume data info in a given file path
 *
 *  @param filePath          file path
 *
 */
- (SKNetworkDownloadResumeDataInfo *_Nullable)loadResumeDataInfo:(NSString *_Nonnull)filePath;


@end

NS_ASSUME_NONNULL_END
