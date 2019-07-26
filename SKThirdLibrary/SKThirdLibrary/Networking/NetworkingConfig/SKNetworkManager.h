//
//  SKNetworkManager.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SKNetworkRequestModel.h"
#import "SKNetworkCacheManager.h"
NS_ASSUME_NONNULL_BEGIN
/* =============================
 *
 * SKNetworkManager
 *
 * SKNetworkManager is in charge of managing operations of network request
 *
 * =============================
 */
@interface SKNetworkManager : NSObject

/**
 *  SKNetworkManager Singleton
 *
 *  @return SKNetworkManager singleton instance
 */
+ (SKNetworkManager *_Nullable)sharedManager;



/**
 *  can not use new method
 */
+ (instancetype _Nullable)new NS_UNAVAILABLE;



/**
 *  This method is used to add custom header
 *
 *  @param header            custom header added by user
 *
 */
- (void)addCustomHeader:(NSDictionary *_Nonnull)header;



/**
 *  This method is used to return custom header
 *
 *  @return custom header
 */
- (NSDictionary *_Nullable)customHeaders;


#pragma mark- Request API using GET method

/**
 *  This method is used to send GET request,
 not consider whether to write cache & not consider whether to load cache
 *
 *  @param url                 request url
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;



/**
 *  This method is used to send GET request,
 not consider whether to write cache & not consider whether to load cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;




/**
 *  This method is used to send GET request,
 not consider whether to write cache & not consider whether to load cache
 *
 *  @param url                 request url
 *  @param ignoreBaseUrl       consider whether to ignore configured base url
 *  @param parameters          parameters
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
         ignoreBaseUrl:(BOOL)ignoreBaseUrl
            parameters:(id _Nullable)parameters
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;




/**
 *  This method is used to send GET request,
 consider whether to load cache but not consider whether to write cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;



/**
 *  This method is used to send GET request,
 consider whether to load cache but not consider whether to write cache
 *
 *  @param url                 request url
 *  @param ignoreBaseUrl       consider whether to ignore configured base url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
         ignoreBaseUrl:(BOOL)ignoreBaseUrl
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;


/**
 *  This method is used to send GET request,
 consider whether to write cache but not consider whether to load cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheDuration       consider whether to write cache unit/day (default 30)
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
         cacheDuration:(NSTimeInterval)cacheDuration
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;


/**
 *  This method is used to send GET request,
 consider whether to load cache and consider whether to write cache
 *
 *  @param url                 request url
 *  @param ignoreBaseUrl       consider whether to ignore configured base url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param cacheDuration       consider whether to write cache unit/day (default 30)
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendGetRequest:(NSString * _Nonnull)url
         ignoreBaseUrl:(BOOL)ignoreBaseUrl
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
         cacheDuration:(NSTimeInterval)cacheDuration
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;



#pragma mark- Request API using POST method

/**
 *  This method is used to send POST request,
 not consider whether to write cache & not consider whether to load cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
                success:(SKSuccessBlock _Nullable)successBlock
                failure:(SKFailureBlock _Nullable)failureBlock;



/**
 *  This method is used to send POST request,
 consider whether to load cache but not consider whether to write cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
              cacheType:(SKNetworkCacheType)cacheType
                success:(SKSuccessBlock _Nullable)successBlock
                failure:(SKFailureBlock _Nullable)failureBlock;



/**
 *  This method is used to send POST request,
 consider whether to write cache but not consider whether to load cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheDuration       consider whether to write cache
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
          cacheDuration:(NSTimeInterval)cacheDuration
                success:(SKSuccessBlock _Nullable)successBlock
                failure:(SKFailureBlock _Nullable)failureBlock;


/**
 *  This method is used to send POST request,
 consider whether to load cache and consider whether to write cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param cacheDuration       consider whether to write cache unit/day (default 30)
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
              cacheType:(SKNetworkCacheType)cacheType
          cacheDuration:(NSTimeInterval)cacheDuration
                success:(SKSuccessBlock _Nullable)successBlock
                failure:(SKFailureBlock _Nullable)failureBlock;



#pragma mark- Request API using PUT method


/**
 *  This method is used to send PUT request,
 not consider whether to write cache & not consider whether to load cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendPutRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;


/**
 *  This method is used to send POST request,
 consider whether to load cache but not consider whether to write cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendPutRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;



/**
 *  This method is used to send POST request,
 consider whether to write cache but not consider whether to load cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheDuration       consider whether to write cache unit/day (default 30)
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendPutRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
         cacheDuration:(NSTimeInterval)cacheDuration
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;


/**
 *  This method is used to send POST request,
 consider whether to load cache and consider whether to write cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param cacheDuration       consider whether to write cache unit/day (default 30)
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendPutRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
         cacheDuration:(NSTimeInterval)cacheDuration
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock;



#pragma mark- Request API using DELETE method

/**
 *  This method is used to send DELETE request,
 not consider whether to write cache & not consider whether to load cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendDeleteRequest:(NSString * _Nonnull)url
               parameters:(id _Nullable)parameters
                  success:(SKSuccessBlock _Nullable)successBlock
                  failure:(SKFailureBlock _Nullable)failureBlock;



/**
 *  This method is used to send POST request,
 consider whether to load cache but not consider whether to write cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendDeleteRequest:(NSString * _Nonnull)url
               parameters:(id _Nullable)parameters
                cacheType:(SKNetworkCacheType)cacheType
                  success:(SKSuccessBlock _Nullable)successBlock
                  failure:(SKFailureBlock _Nullable)failureBlock;



/**
 *  This method is used to send POST request,
 consider whether to write cache but not consider whether to load cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheDuration       consider whether to write cache unit/day (default 30)
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendDeleteRequest:(NSString * _Nonnull)url
               parameters:(id _Nullable)parameters
            cacheDuration:(NSTimeInterval)cacheDuration
                  success:(SKSuccessBlock _Nullable)successBlock
                  failure:(SKFailureBlock _Nullable)failureBlock;


/**
 *  This method is used to send POST request,
 consider whether to load cache and consider whether to write cache
 *
 *  @param url                 request url
 *  @param parameters          parameters
 *  @param cacheType           first load cache,then load networt data or only load load networt
 *  @param cacheDuration       consider whether to write cache unit/day (default 30)
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendDeleteRequest:(NSString * _Nonnull)url
               parameters:(id _Nullable)parameters
                cacheType:(SKNetworkCacheType)cacheType
            cacheDuration:(NSTimeInterval)cacheDuration
                  success:(SKSuccessBlock _Nullable)successBlock
                  failure:(SKFailureBlock _Nullable)failureBlock;



#pragma mark- Request API using specific parameters

/**
 *  These methods are used to send request with specific parameters:
 
 1. if the parameters object is nil,then send GET request
 2. if the parameters object is not nil,then send POST request
 */


/**
 *  This method is used to send request with specific parameters,
 not consider whether to write cache & not consider whether to load cache
 *
 *  @param url                request url
 *  @param parameters         parameters
 *  @param successBlock       success callback
 *  @param failureBlock       failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
         parameters:(id _Nullable)parameters
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;



/**
 *  This method is used to send request with specific parameters,
 not consider whether to write cache but consider whether to load cache
 
 *
 *  @param url                request url
 *  @param parameters         parameters
 *  @param cacheType          first load cache,then load networt data or only load load networt
 *  @param successBlock       success callback
 *  @param failureBlock       failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;


/**
 * This method is used to send request with specific parameters,
 not consider whether to load cache but consider whether to write cache
 
 *
 *  @param url                request url
 *  @param parameters         parameters
 *  @param cacheDuration      consider whether to write cache
 *  @param successBlock       success callback
 *  @param failureBlock       failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
         parameters:(id _Nullable)parameters
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;


/**
 *  This method is used to send request with specific parameters,
 consider whether to load cache and consider whether to write cache
 
 *
 *  @param url                request url
 *  @param parameters         parameters
 *  @param cacheType          first load cache,then load networt data or only load load networt
 *  @param cacheDuration      consider whether to write cache unit/day (default 30)
 *  @param successBlock       success callback
 *  @param failureBlock       failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;




//================== Request API using specific request method ==================//


/**
 *  This method is used to send request with specific method(GET,POST,PUT,DELETE),
 *  not consider whether to write cache & not consider whether to load cache
 *
 *  @param url                 request url
 *  @param method              request method
 *  @param parameters          parameters
 *  @param successBlock        success callback
 *  @param failureBlock        failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;




/**
 *  This method is used to send request with specific method(GET,POST,PUT,DELETE),
 *  not consider whether to write cache but consider whether to load cache
 *
 *  @param url                request url
 *  @param method             request method
 *  @param parameters         parameters
 *  @param cacheType          first load cache,then load networt data or only load load networt
 *  @param successBlock       success callback
 *  @param failureBlock       failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;






/**
 *  This method is used to send request with specific method(GET,POST,PUT,DELETE),
 *  not consider whether to load cache but consider whether to write cache
 *
 *  @param url                request url
 *  @param method             request method
 *  @param parameters         parameters
 *  @param cacheDuration      consider whether to write cache unit/day (default 30)
 *  @param successBlock       success callback
 *  @param failureBlock       failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;




/**
 *  This method is used to send request with specific method(GET,POST,PUT,DELETE),
 *  consider whether to load cache but consider whether to write cache
 *
 *  @param url                request url
 *  @param method             request method
 *  @param parameters         parameters
 *  @param cacheType          first load cache,then load networt data or only load load networt
 *  @param cacheDuration      consider whether to write cache unit/day (default 30)
 *  @param successBlock       success callback
 *  @param failureBlock       failure callback
 *
 */
- (void)sendRequest:(NSString * _Nonnull)url
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock;



#pragma mark- Request API upload images


/**
 *  This method is used to upload image
 *
 *  @param url                   request url
 *  @param parameters            parameters
 *  @param image                 UIImage object
 *  @param name                  file name
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    uploadSuccess allback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                    parameters:(id _Nullable)parameters
                         image:(UIImage * _Nonnull)image
                          name:(NSString * _Nonnull)name
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *  This method is used to upload image
 *
 *  @param url                   request url
 *  @param parameters            parameters
 *  @param compressType          image compress type
 *  @param image                 UIImage object
 *  @param name                  file name
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    uploadSuccess allback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                    parameters:(id _Nullable)parameters
                  compressType:(SKUploadCompressType)compressType
                         image:(UIImage * _Nonnull)image
                          name:(NSString * _Nonnull)name
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *  This method is used to upload image
 *
 *  @param url                   request url
 *  @param ignoreBaseUrl         consider whether to ignore configured base url
 *  @param parameters            parameters
 *  @param image                 UIImage object
 *  @param name                  file name
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                 ignoreBaseUrl:(BOOL)ignoreBaseUrl
                    parameters:(id _Nullable)parameters
                         image:(UIImage * _Nonnull)image
                          name:(NSString * _Nonnull)name
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *  This method is used to upload image
 *
 *  @param url                   request url
 *  @param ignoreBaseUrl         consider whether to ignore configured base url
 *  @param parameters            parameters
 *  @param compressType          image compress type
 *  @param image                 UIImage object
 *  @param name                  file name
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                 ignoreBaseUrl:(BOOL)ignoreBaseUrl
                    parameters:(id _Nullable)parameters
                  compressType:(SKUploadCompressType)compressType
                         image:(UIImage * _Nonnull)image
                          name:(NSString * _Nonnull)name
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *  This method is used to upload image
 *
 *  @param url                   request url
 *  @param parameters            parameters
 *  @param compressType          image compress type
 *  @param image                 UIImage object
 *  @param compressSize          compress size of images
 *  @param name                  file name
 *  @param mimeType              file type(jpg or png or jpeg  / default png)
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                    parameters:(id _Nullable)parameters
                  compressType:(SKUploadCompressType)compressType
                         image:(UIImage * _Nonnull)image
                  compressSize:(float)compressSize
                          name:(NSString * _Nonnull)name
                      mimeType:(NSString * _Nullable)mimeType
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *  This method is used to upload image
 *
 *  @param url                   request url
 *  @param ignoreBaseUrl         consider whether to ignore configured base url
 *  @param parameters            parameters
 *  @param compressType          image compress type
 *  @param image                 UIImage object
 *  @param compressSize          compress size of images
 *  @param name                  file name
 *  @param mimeType              file type(jpg or png or jpeg  / default png)
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                 ignoreBaseUrl:(BOOL)ignoreBaseUrl
                    parameters:(id _Nullable)parameters
                  compressType:(SKUploadCompressType)compressType
                         image:(UIImage * _Nonnull)image
                  compressSize:(float)compressSize
                          name:(NSString * _Nonnull)name
                      mimeType:(NSString * _Nullable)mimeType
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *  This method is used to upload images(or only one image)
 *
 *  @param url                   request url
 *  @param parameters            parameters
 *  @param images                UIImage object array
 *  @param name                  file name
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImagesRequest:(NSString * _Nonnull)url
                     parameters:(id _Nullable)parameters
                         images:(NSArray<UIImage *> * _Nonnull)images
                           name:(NSString * _Nonnull)name
                       progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                        success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *  This method is used to upload images(or only one image)
 *
 *  @param url                   request url
 *  @param ignoreBaseUrl         consider whether to ignore configured base url
 *  @param parameters            parameters
 *  @param images                UIImage object array
 *  @param name                  file name
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImagesRequest:(NSString * _Nonnull)url
                  ignoreBaseUrl:(BOOL)ignoreBaseUrl
                     parameters:(id _Nullable)parameters
                         images:(NSArray<UIImage *> * _Nonnull)images
                           name:(NSString * _Nonnull)name
                       progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                        success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *  This method is used to upload images(or only one image)
 *
 *  @param url                   request url
 *  @param parameters            parameters
 *  @param compressType          image compress type
 *  @param images                UIImage object array
 *  @param compressSize          compress size of images
 *  @param name                  file name
 *  @param mimeType              file type(jpg or png or jpeg  / default png)
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImagesRequest:(NSString * _Nonnull)url
                     parameters:(id _Nullable)parameters
                   compressType:(SKUploadCompressType)compressType
                         images:(NSArray<UIImage *> * _Nonnull)images
                   compressSize:(float)compressSize
                           name:(NSString * _Nonnull)name
                       mimeType:(NSString * _Nullable)mimeType
                       progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                        success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;



/**
 *
 *  @param url                   request url
 *  @param ignoreBaseUrl         consider whether to ignore configured base url
 *  @param parameters            parameters
 *  @param compressType          image compress type
 *  @param images                UIImage object array
 *  @param compressSize          compress size of images
 *  @param name                  file name
 *  @param mimeType              file type(jpg or png or jpeg  / default png)
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
- (void)sendUploadImagesRequest:(NSString * _Nonnull)url
                  ignoreBaseUrl:(BOOL)ignoreBaseUrl
                     parameters:(id _Nullable)parameters
                   compressType:(SKUploadCompressType)compressType
                         images:(NSArray<UIImage *> * _Nonnull)images
                   compressSize:(float)compressSize
                           name:(NSString * _Nonnull)name
                       mimeType:(NSString * _Nullable)mimeType
                       progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                        success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;






#pragma mark- Request API download files

/**
 *  These methods are used to download file
 *
 *  @param url                      request url
 *  @param downloadFilePath         target path of download file
 *  @param downloadProgressBlock    download progress callback
 *  @param downloadSuccessBlock     download success callback
 *  @param downloadFailureBlock     download failure callback
 *
 */
- (void)sendDownloadRequest:(NSString * _Nonnull)url
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock;





/**
 *  These methods are used to download file
 *
 *  @param url                      request url
 *  @param ignoreBaseUrl            consider whether to ignore configured base url
 *  @param downloadFilePath         target path of download file
 *  @param downloadProgressBlock    download progress callback
 *  @param downloadSuccessBlock     download success callback
 *  @param downloadFailureBlock     download failure callback
 *
 */
- (void)sendDownloadRequest:(NSString * _Nonnull)url
              ignoreBaseUrl:(BOOL)ignoreBaseUrl
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock;






/**
 *  These methods are used to download file
 *
 *  @param url                      request url
 *  @param downloadFilePath         target path of download file
 *  @param resumable                consider whether to save or load resumble data
 *  @param downloadProgressBlock    download progress callback
 *  @param downloadSuccessBlock     download success callback
 *  @param downloadFailureBlock     download failure callback
 *
 */
- (void)sendDownloadRequest:(NSString * _Nonnull)url
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                  resumable:(BOOL)resumable
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock;



/**
 *  These methods are used to download file
 *
 *  @param url                      request url
 *  @param ignoreBaseUrl            consider whether to ignore configured base url
 *  @param downloadFilePath         target path of download file
 *  @param resumable                consider whether to save or load resumble data
 *  @param downloadProgressBlock    download progress callback
 *  @param downloadSuccessBlock     download success callback
 *  @param downloadFailureBlock     download failure callback
 *
 */
- (void)sendDownloadRequest:(NSString * _Nonnull)url
              ignoreBaseUrl:(BOOL)ignoreBaseUrl
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                  resumable:(BOOL)resumable
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock;



/**
 *  These methods are used to download file
 *
 *  @param url                      request url
 *  @param downloadFilePath         target path of download file
 *  @param backgroundSupport        consider whether to support background downlaod
 *  @param downloadProgressBlock    download progress callback
 *  @param downloadSuccessBlock     download success callback
 *  @param downloadFailureBlock     download failure callback
 *
 */
- (void)sendDownloadRequest:(NSString * _Nonnull)url
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
          backgroundSupport:(BOOL)backgroundSupport
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock;




/**
 *  These methods are used to download file
 *
 *  @param url                      request url
 *  @param ignoreBaseUrl            consider whether to ignore configured base url
 *  @param downloadFilePath         target path of download file
 *  @param backgroundSupport        consider whether to support background downlaod
 *  @param downloadProgressBlock    download progress callback
 *  @param downloadSuccessBlock     download success callback
 *  @param downloadFailureBlock     download failure callback
 *
 */
- (void)sendDownloadRequest:(NSString * _Nonnull)url
              ignoreBaseUrl:(BOOL)ignoreBaseUrl
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
          backgroundSupport:(BOOL)backgroundSupport
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock;


/**
 *  These methods are used to download file
 *
 *  @param url                      request url
 *  @param downloadFilePath         target path of download file
 *  @param resumable                consider whether to save or load resumble data
 *  @param backgroundSupport        consider whether to support background downlaod
 *  @param downloadProgressBlock    download progress callback
 *  @param downloadSuccessBlock     download success callback
 *  @param downloadFailureBlock     download failure callback
 *
 */
- (void)sendDownloadRequest:(NSString * _Nonnull)url
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                  resumable:(BOOL)resumable
          backgroundSupport:(BOOL)backgroundSupport
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock;




/**
 *  These methods are used to download file
 *
 *  @param url                      request url
 *  @param ignoreBaseUrl            consider whether to ignore configured base url
 *  @param downloadFilePath         target path of download file
 *  @param resumable                consider whether to save or load resumble data
 *  @param backgroundSupport        consider whether to support background downlaod
 *  @param downloadProgressBlock    download progress callback
 *  @param downloadSuccessBlock     download success callback
 *  @param downloadFailureBlock     download failure callback
 *
 */
- (void)sendDownloadRequest:(NSString * _Nonnull)url
              ignoreBaseUrl:(BOOL)ignoreBaseUrl
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                  resumable:(BOOL)resumable
          backgroundSupport:(BOOL)backgroundSupport
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock;


//=============================== Suspend download requests ==================================//


/**
 *  This method is used to suspend all current download requests
 */
- (void)suspendAllDownloadRequests;





/**
 *  This method is used to suspend a download request with given url
 *
 *  @param url                   download url
 *
 */
- (void)suspendDownloadRequest:(SKRequestSerializer)serializer
                           url:(NSString * _Nonnull)url;



/**
 *  This method is used to suspend a download request with given url which contains the baseUrl or not
 *
 *  @param url                   download url
 *  @param ignoreBaseUrl         ignore baseUrl or not
 *
 */
- (void)suspendDownloadRequest:(SKRequestSerializer)serializer
                           url:(NSString * _Nonnull)url ignoreBaseUrl:(BOOL)ignoreBaseUrl;



/**
 *  This method is used to suspend one nor more download requests with given urls array
 *
 *  @param urls                   download url array
 *
 */
- (void)suspendDownloadRequests:(NSArray *_Nonnull)urls;




/**
 *  This method is used to suspend one nor more download requests with given urls which contain the baseUrl or not
 *
 *  @param urls                   download url array
 *  @param ignoreBaseUrl          ignore baseUrl or not
 *
 */
- (void)suspendDownloadRequests:(NSArray *_Nonnull)urls ignoreBaseUrl:(BOOL)ignoreBaseUrl;



//=============================== Resume download requests ==================================//

/**
 *  This method is used to resume all suspended download requests
 */
- (void)resumeAllDownloadRequests;




/**
 *  This method is used to resume a suspended request with given url
 *
 *  @param url                   download url
 *
 */
- (void)resumeDownloadReqeust:(NSString *_Nonnull)url;




/**
 *  This method is used to resume a suspended request with given url which contains the baseUrl or not
 *
 *  @param url                   download url
 *  @param ignoreBaseUrl         ignore baseUrl or not
 *
 */
- (void)resumeDownloadReqeust:(NSString *_Nonnull)url ignoreBaseUrl:(BOOL)ignoreBaseUrl;



/**
 *  This method is used to resume one nor more suspended requests with given urls array
 *
 *  @param urls                   download url array
 *
 */
- (void)resumeDownloadReqeusts:(NSArray *_Nonnull)urls;



/**
 *  This method is used to suspend one nor more suspended requests with given urls which contain the baseUrl or not
 *
 *  @param urls                   download url array
 *  @param ignoreBaseUrl          ignore baseUrl or not
 *
 */
- (void)resumeDownloadReqeusts:(NSArray *_Nonnull)urls ignoreBaseUrl:(BOOL)ignoreBaseUrl;





//=============================== Cancel download requests ==================================//


/**
 *  This method is used to cancel all current download requests
 */
- (void)cancelAllDownloadRequests;



/**
 *  This method is used to cancel a current download request with given url
 *
 *  @param url                   download url
 *
 */
- (void)cancelDownloadRequest:(SKRequestSerializer)serializer
                          url:(NSString * _Nonnull)url;



/**
 *  This method is used to cancel a current download request with given url which contains the baseUrl or not
 *
 *  @param url                   download url
 *  @param ignoreBaseUrl         ignore baseUrl or not
 *
 */
- (void)cancelDownloadRequest:(SKRequestSerializer)serializer
                          url:(NSString * _Nonnull)url ignoreBaseUrl:(BOOL)ignoreBaseUrl;




/**
 *  This method is used to cancel one nor more current download requests with given urls array
 *
 *  @param urls                   download url array
 *
 */
- (void)cancelDownloadRequests:(NSArray *_Nonnull)urls;




/**
 *  This method is used to cancel one nor more current download requests with given urls which contain the baseUrl or not
 *
 *  @param urls                   download url array
 *  @param ignoreBaseUrl          ignore baseUrl or not
 *
 */
- (void)cancelDownloadRequests:(NSArray *_Nonnull)urls ignoreBaseUrl:(BOOL)ignoreBaseUrl;



/**
 *  This method is used to get incomplete download data ratio of a download request with a given download url
 *
 *  @param url                    download url
 *
 *  @return incomplete download data ratio
 */
- (CGFloat)resumeDataRatioOfRequest:(NSString *_Nonnull)url;





/**
 *  This method is used to get incomplete download data ratio of a download request with a given download url which contains the baseUrl or not
 *
 *  @param url                    download url
 *  @param ignoreBaseUrl          ignore baseUrl or not
 *
 *  @return incomplete download data ratio
 */
- (CGFloat)resumeDataRatioOfRequest:(NSString *_Nonnull)url ignoreBaseUrl:(BOOL)ignoreBaseUrl;



#pragma mark- Cancel requests



/**
 *  This method is used to cancel all current requests
 */
- (void)cancelAllCurrentRequests;




/**
 *  This method is used to cancel all current requests corresponding a reqeust url,
 no matter what the method is and parameters are
 *
 *  @param url              request url
 *
 */
- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url;






/**
 *  This method is used to cancel all current requests corresponding a specific reqeust url, method and parameters
 *
 *  @param url              request url
 *  @param method           request method
 *  @param parameters       parameters
 *
 */
- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url
                             method:(NSString * _Nonnull)method
                         parameters:(id _Nullable)parameters;




#pragma mark- Cache operations


//=============================== Load cache ==================================//

/**
 *  This method is used to load cache which is related to a specific url,
 no matter what request method is or parameters are
 *
 *
 *  @param url                  the url of related network requests
 *  @param completionBlock      callback
 *
 */
- (void)loadCacheWithUrl:(NSString * _Nonnull)url
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




//=============================== calculate cache ===========================//

/**
 *  This method is used to calculate the size of the cache folder
 *
 *  @param completionBlock      callback
 *
 */
- (void)calculateCacheSizeCompletionBlock:(SKCalculateSizeCompletionBlock _Nullable)completionBlock;





//================================= clear cache ==============================//

/**
 *  This method is used to clear all cache which is in the cache file
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
- (void)clearCacheWithUrl:(NSString * _Nonnull)url
          completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock;





- (void)clearCacheWithUrl:(NSString * _Nonnull)url
                   method:(NSString * _Nonnull)method
          completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock;




/**
 *  This method is used to clear the cache which is related the specific url and method,
 no matter what parameters are
 *
 *  @param url                   the url of network request
 *  @param method                request method
 *  @param completionBlock       callback
 *
 */
- (void)loadCacheWithUrl:(NSString * _Nonnull)url
                  method:(NSString * _Nonnull)method
         completionBlock:(SKLoadCacheArrCompletionBlock _Nullable)completionBlock;



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
               parameters:(id _Nonnull)parameters
          completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock;



#pragma mark- Request Info


/**
 *  This method is used to log all current requests' information
 */
- (void)logAllCurrentRequests;



/**
 *  This method is used to check if there is remaining curent request
 *
 *  @return if there is remaining requests
 */
- (BOOL)remainingCurrentRequests;



/**
 *  This method is used to calculate the count of current requests
 *
 *  @return the count of current requests
 */
- (NSInteger)currentRequestCount;


@end

NS_ASSUME_NONNULL_END
