//
//  SKNetworkManager.m
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKNetworkManager.h"
#import "SKNetworkConfig.h"
#import "SKNetworkRequestPool.h"

#import "SKNetworkRequestEngine.h"
#import "SKNetworkUploadEngine.h"
#import "SKNetworkDownloadEngine.h"

@interface SKNetworkManager()

@property (nonatomic, strong) SKNetworkRequestEngine *requestEngine;
@property (nonatomic, strong) SKNetworkUploadEngine *uploadEngine;
@property (nonatomic, strong) SKNetworkDownloadEngine *downloadEngine;

@property (nonatomic, strong) SKNetworkRequestPool *requestPool;
@property (nonatomic, strong) SKNetworkCacheManager *cacheManager;

@end
@implementation SKNetworkManager
#pragma mark- ============== Life Cycle ===========

+ (SKNetworkManager *_Nullable)sharedManager {
    
    static SKNetworkManager *sharedManager = NULL;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[SKNetworkManager alloc] init];
    });
    return sharedManager;
}


- (void)dealloc{
    
    [self cancelAllCurrentRequests];
}

#pragma mark- ============== Public Methods ==============


- (void)addCustomHeader:(NSDictionary *_Nonnull)header{
    
    [[SKNetworkConfig sharedConfig] addCustomHeader:header];
}




- (NSDictionary *_Nullable)customHeaders{
    
    return [SKNetworkConfig sharedConfig].customHeaders;
}




#pragma mark- ============== Request API using GET method ==============


- (void)sendGetRequest:(NSString * _Nonnull)url
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodGET
                         parameters:nil
                          cacheType:SKNetworkCacheTypeCacheNetwork
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
    
}





- (void)sendGetRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodGET
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeCacheNetwork
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
}


- (void)sendGetRequest:(NSString * _Nonnull)url
         ignoreBaseUrl:(BOOL)ignoreBaseUrl
            parameters:(id _Nullable)parameters
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:ignoreBaseUrl
                             method:SKRequestMethodGET
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeCacheNetwork
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
}


- (void)sendGetRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodGET
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
}


- (void)sendGetRequest:(NSString * _Nonnull)url
         ignoreBaseUrl:(BOOL)ignoreBaseUrl
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:ignoreBaseUrl
                             method:SKRequestMethodGET
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
}


- (void)sendGetRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
         cacheDuration:(NSTimeInterval)cacheDuration
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodGET
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeCacheNetwork
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}


- (void)sendGetRequest:(NSString * _Nonnull)url
         ignoreBaseUrl:(BOOL)ignoreBaseUrl
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
         cacheDuration:(NSTimeInterval)cacheDuration
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:ignoreBaseUrl
                             method:SKRequestMethodGET
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}




#pragma mark- ============== Request API using POST method ==============

- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
                success:(SKSuccessBlock _Nullable)successBlock
                failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodPOST
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeNetworkOnly
                      cacheDuration:0
                            success:successBlock
                            failure:failureBlock];
}




- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
              cacheType:(SKNetworkCacheType)cacheType
                success:(SKSuccessBlock _Nullable)successBlock
                failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodPOST
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
}



- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
          cacheDuration:(NSTimeInterval)cacheDuration
                success:(SKSuccessBlock _Nullable)successBlock
                failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodPOST
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeCacheNetwork
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}




- (void)sendPostRequest:(NSString * _Nonnull)url
             parameters:(id _Nullable)parameters
              cacheType:(SKNetworkCacheType)cacheType
          cacheDuration:(NSTimeInterval)cacheDuration
                success:(SKSuccessBlock _Nullable)successBlock
                failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodPOST
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}





#pragma mark- ============== Request API using PUT method ==============

- (void)sendPutRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodPUT
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeNetworkOnly
                      cacheDuration:0
                            success:successBlock
                            failure:failureBlock];
}




- (void)sendPutRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodPUT
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
}




- (void)sendPutRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
         cacheDuration:(NSTimeInterval)cacheDuration
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodPUT
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeCacheNetwork
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}




- (void)sendPutRequest:(NSString * _Nonnull)url
            parameters:(id _Nullable)parameters
             cacheType:(SKNetworkCacheType)cacheType
         cacheDuration:(NSTimeInterval)cacheDuration
               success:(SKSuccessBlock _Nullable)successBlock
               failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodPUT
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
    
}



#pragma mark- ============== Request API using DELETE method ==============

- (void)sendDeleteRequest:(NSString * _Nonnull)url
               parameters:(id _Nullable)parameters
                  success:(SKSuccessBlock _Nullable)successBlock
                  failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodDELETE
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeNetworkOnly
                      cacheDuration:0
                            success:successBlock
                            failure:failureBlock];
}



- (void)sendDeleteRequest:(NSString * _Nonnull)url
               parameters:(id _Nullable)parameters
                cacheType:(SKNetworkCacheType)cacheType
                  success:(SKSuccessBlock _Nullable)successBlock
                  failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodDELETE
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
    
}




- (void)sendDeleteRequest:(NSString * _Nonnull)url
               parameters:(id _Nullable)parameters
            cacheDuration:(NSTimeInterval)cacheDuration
                  success:(SKSuccessBlock _Nullable)successBlock
                  failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodDELETE
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeCacheNetwork
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}




- (void)sendDeleteRequest:(NSString * _Nonnull)url
               parameters:(id _Nullable)parameters
                cacheType:(SKNetworkCacheType)cacheType
            cacheDuration:(NSTimeInterval)cacheDuration
                  success:(SKSuccessBlock _Nullable)successBlock
                  failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:SKRequestMethodDELETE
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}





#pragma mark- ============== Request API using specific parameters ==============


- (void)sendRequest:(NSString * _Nonnull)url
         parameters:(id _Nullable)parameters
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    if (parameters) {
        
        [self.requestEngine sendRequest:url
                          ignoreBaseUrl:NO
                                 method:SKRequestMethodPOST
                             parameters:parameters
                              cacheType:SKNetworkCacheTypeNetworkOnly
                          cacheDuration:0
                                success:successBlock
                                failure:failureBlock];
        
    }else{
        
        [self.requestEngine sendRequest:url
                          ignoreBaseUrl:NO
                                 method:SKRequestMethodGET
                             parameters:nil
                              cacheType:SKNetworkCacheTypeCacheNetwork
                          cacheDuration:30
                                success:successBlock
                                failure:failureBlock];
    }
}



- (void)sendRequest:(NSString * _Nonnull)url
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    if (parameters) {
        
        [self.requestEngine sendRequest:url
                          ignoreBaseUrl:NO
                                 method:SKRequestMethodPOST
                             parameters:parameters
                              cacheType:cacheType
                          cacheDuration:30
                                success:successBlock
                                failure:failureBlock];
        
    }else{
        
        [self.requestEngine sendRequest:url
                          ignoreBaseUrl:NO
                                 method:SKRequestMethodGET
                             parameters:nil
                              cacheType:cacheType
                          cacheDuration:30
                                success:successBlock
                                failure:failureBlock];
    }
}



- (void)sendRequest:(NSString * _Nonnull)url
         parameters:(id _Nullable)parameters
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    if (parameters) {
        
        [self.requestEngine sendRequest:url
                          ignoreBaseUrl:NO
                                 method:SKRequestMethodPOST
                             parameters:parameters
                              cacheType:SKNetworkCacheTypeNetworkOnly
                          cacheDuration:cacheDuration
                                success:successBlock
                                failure:failureBlock];
        
    }else{
        
        
        [self.requestEngine sendRequest:url
                          ignoreBaseUrl:NO
                                 method:SKRequestMethodGET
                             parameters:nil
                              cacheType:SKNetworkCacheTypeCacheNetwork
                          cacheDuration:cacheDuration
                                success:successBlock
                                failure:failureBlock];
    }
}



- (void)sendRequest:(NSString * _Nonnull)url
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    if (parameters) {
        
        [self.requestEngine sendRequest:url
                          ignoreBaseUrl:NO
                                 method:SKRequestMethodPOST
                             parameters:parameters
                              cacheType:cacheType
                          cacheDuration:cacheDuration
                                success:successBlock
                                failure:failureBlock];
    }else{
        
        
        [self.requestEngine sendRequest:url
                          ignoreBaseUrl:NO
                                 method:SKRequestMethodGET
                             parameters:nil
                              cacheType:cacheType
                          cacheDuration:cacheDuration
                                success:successBlock
                                failure:failureBlock];
    }
}



#pragma mark- ============== Request API using specific request method ==============

- (void)sendRequest:(NSString * _Nonnull)url
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:method
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeNetworkOnly
                      cacheDuration:0
                            success:successBlock
                            failure:failureBlock];
}



- (void)sendRequest:(NSString * _Nonnull)url
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:method
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:30
                            success:successBlock
                            failure:failureBlock];
}



- (void)sendRequest:(NSString * _Nonnull)url
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:method
                         parameters:parameters
                          cacheType:SKNetworkCacheTypeNetworkOnly
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}



- (void)sendRequest:(NSString * _Nonnull)url
             method:(SKRequestMethod)method
         parameters:(id _Nullable)parameters
          cacheType:(SKNetworkCacheType)cacheType
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock _Nullable)successBlock
            failure:(SKFailureBlock _Nullable)failureBlock{
    
    
    [self.requestEngine sendRequest:url
                      ignoreBaseUrl:NO
                             method:method
                         parameters:parameters
                          cacheType:cacheType
                      cacheDuration:cacheDuration
                            success:successBlock
                            failure:failureBlock];
}




#pragma mark- ============== Request API uploading ==============


- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                    parameters:(id _Nullable)parameters
                         image:(UIImage * _Nonnull)image
                          name:(NSString * _Nonnull)name
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:NO
                                    parameters:parameters
                                        images:@[image]
                                  compressSize:150
                                  compressType:SKUploadCompressWeiChat
                                          name:name
                                      mimeType:@"png"
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
}


- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                    parameters:(id _Nullable)parameters
                  compressType:(SKUploadCompressType)compressType
                         image:(UIImage * _Nonnull)image
                          name:(NSString * _Nonnull)name
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:NO
                                    parameters:parameters
                                        images:@[image]
                                  compressSize:150
                                  compressType:compressType
                                          name:name
                                      mimeType:@"png"
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
}



- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                 ignoreBaseUrl:(BOOL)ignoreBaseUrl
                    parameters:(id _Nullable)parameters
                         image:(UIImage * _Nonnull)image
                          name:(NSString * _Nonnull)name
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:ignoreBaseUrl
                                    parameters:parameters
                                        images:@[image]
                                  compressSize:150
                                  compressType:SKUploadCompressWeiChat
                                          name:name
                                      mimeType:@"png"
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
    
}



- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                 ignoreBaseUrl:(BOOL)ignoreBaseUrl
                    parameters:(id _Nullable)parameters
                  compressType:(SKUploadCompressType)compressType
                         image:(UIImage * _Nonnull)image
                          name:(NSString * _Nonnull)name
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:ignoreBaseUrl
                                    parameters:parameters
                                        images:@[image]
                                  compressSize:150
                                  compressType:compressType
                                          name:name
                                      mimeType:@"png"
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
    
}



- (void)sendUploadImageRequest:(NSString * _Nonnull)url
                    parameters:(id _Nullable)parameters
                  compressType:(SKUploadCompressType)compressType
                         image:(UIImage * _Nonnull)image
                  compressSize:(float)compressSize
                          name:(NSString * _Nonnull)name
                      mimeType:(NSString * _Nullable)mimeType
                      progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                       success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:NO
                                    parameters:parameters
                                        images:@[image]
                                  compressSize:compressSize
                                  compressType:compressType
                                          name:name
                                      mimeType:mimeType
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
    
    
}



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
                       failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:ignoreBaseUrl
                                    parameters:parameters
                                        images:@[image]
                                  compressSize:compressSize
                                  compressType:compressType
                                          name:name
                                      mimeType:mimeType
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
}




- (void)sendUploadImagesRequest:(NSString * _Nonnull)url
                     parameters:(id _Nullable)parameters
                         images:(NSArray<UIImage *> * _Nonnull)images
                           name:(NSString * _Nonnull)name
                       progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                        success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:NO
                                    parameters:parameters
                                        images:images
                                  compressSize:150
                                  compressType:SKUploadCompressWeiChat
                                          name:name
                                      mimeType:@"png"
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
    
}



- (void)sendUploadImagesRequest:(NSString * _Nonnull)url
                  ignoreBaseUrl:(BOOL)ignoreBaseUrl
                     parameters:(id _Nullable)parameters
                         images:(NSArray<UIImage *> * _Nonnull)images
                           name:(NSString * _Nonnull)name
                       progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                        success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:ignoreBaseUrl
                                    parameters:parameters
                                        images:images
                                  compressSize:150
                                  compressType:SKUploadCompressWeiChat
                                          name:name
                                      mimeType:@"png"
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
    
}




- (void)sendUploadImagesRequest:(NSString * _Nonnull)url
                     parameters:(id _Nullable)parameters
                   compressType:(SKUploadCompressType)compressType
                         images:(NSArray<UIImage *> * _Nonnull)images
                   compressSize:(float)compressSize
                           name:(NSString * _Nonnull)name
                       mimeType:(NSString * _Nullable)mimeType
                       progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                        success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:NO
                                    parameters:parameters
                                        images:images
                                  compressSize:compressSize
                                  compressType:compressType
                                          name:name
                                      mimeType:mimeType
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
}



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
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    
    [self.uploadEngine sendUploadImagesRequest:url
                                 ignoreBaseUrl:ignoreBaseUrl
                                    parameters:parameters
                                        images:images
                                  compressSize:compressSize
                                  compressType:compressType
                                          name:name
                                      mimeType:mimeType
                                      progress:uploadProgressBlock
                                       success:uploadSuccessBlock
                                       failure:uploadFailureBlock];
}




#pragma mark- ============== Request API downloading ==============

- (void)sendDownloadRequest:(NSString * _Nonnull)url
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock{
    
    
    [self.downloadEngine sendDownloadRequest:url
                               ignoreBaseUrl:NO
                            downloadFilePath:downloadFilePath
                                   resumable:YES
                           backgroundSupport:NO
                                    progress:downloadProgressBlock
                                     success:downloadSuccessBlock
                                     failure:downloadFailureBlock];
}



- (void)sendDownloadRequest:(NSString * _Nonnull)url
              ignoreBaseUrl:(BOOL)ignoreBaseUrl
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock{
    
    
    [self.downloadEngine sendDownloadRequest:url
                               ignoreBaseUrl:ignoreBaseUrl
                            downloadFilePath:downloadFilePath
                                   resumable:YES
                           backgroundSupport:NO
                                    progress:downloadProgressBlock
                                     success:downloadSuccessBlock
                                     failure:downloadFailureBlock];
    
}




- (void)sendDownloadRequest:(NSString * _Nonnull)url
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                  resumable:(BOOL)resumable
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock{
    
    
    [self.downloadEngine sendDownloadRequest:url
                               ignoreBaseUrl:NO
                            downloadFilePath:downloadFilePath
                                   resumable:resumable
                           backgroundSupport:NO
                                    progress:downloadProgressBlock
                                     success:downloadSuccessBlock
                                     failure:downloadFailureBlock];
}




- (void)sendDownloadRequest:(NSString * _Nonnull)url
              ignoreBaseUrl:(BOOL)ignoreBaseUrl
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                  resumable:(BOOL)resumable
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock{
    
    
    [self.downloadEngine sendDownloadRequest:url
                               ignoreBaseUrl:ignoreBaseUrl
                            downloadFilePath:downloadFilePath
                                   resumable:resumable
                           backgroundSupport:NO
                                    progress:downloadProgressBlock
                                     success:downloadSuccessBlock
                                     failure:downloadFailureBlock];
}




- (void)sendDownloadRequest:(NSString * _Nonnull)url
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
          backgroundSupport:(BOOL)backgroundSupport
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock{
    
    
    [self.downloadEngine sendDownloadRequest:url
                               ignoreBaseUrl:NO
                            downloadFilePath:downloadFilePath
                                   resumable:YES
                           backgroundSupport:NO
                                    progress:downloadProgressBlock
                                     success:downloadSuccessBlock
                                     failure:downloadFailureBlock];
    
}




- (void)sendDownloadRequest:(NSString * _Nonnull)url
              ignoreBaseUrl:(BOOL)ignoreBaseUrl
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
          backgroundSupport:(BOOL)backgroundSupport
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock{
    
    
    [self.downloadEngine sendDownloadRequest:url
                               ignoreBaseUrl:ignoreBaseUrl
                            downloadFilePath:downloadFilePath
                                   resumable:YES
                           backgroundSupport:NO
                                    progress:downloadProgressBlock
                                     success:downloadSuccessBlock
                                     failure:downloadFailureBlock];
    
}




- (void)sendDownloadRequest:(NSString * _Nonnull)url
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                  resumable:(BOOL)resumable
          backgroundSupport:(BOOL)backgroundSupport
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock{
    
    
    [self.downloadEngine sendDownloadRequest:url
                               ignoreBaseUrl:NO
                            downloadFilePath:downloadFilePath
                                   resumable:resumable
                           backgroundSupport:backgroundSupport
                                    progress:downloadProgressBlock
                                     success:downloadSuccessBlock
                                     failure:downloadFailureBlock];
}





- (void)sendDownloadRequest:(NSString * _Nonnull)url
              ignoreBaseUrl:(BOOL)ignoreBaseUrl
           downloadFilePath:(NSString *_Nonnull)downloadFilePath
                  resumable:(BOOL)resumable
          backgroundSupport:(BOOL)backgroundSupport
                   progress:(SKDownloadProgressBlock _Nullable)downloadProgressBlock
                    success:(SKDownloadSuccessBlock _Nullable)downloadSuccessBlock
                    failure:(SKDownloadFailureBlock _Nullable)downloadFailureBlock{
    
    
    [self.downloadEngine sendDownloadRequest:url
                               ignoreBaseUrl:ignoreBaseUrl
                            downloadFilePath:downloadFilePath
                                   resumable:resumable
                           backgroundSupport:backgroundSupport
                                    progress:downloadProgressBlock
                                     success:downloadSuccessBlock
                                     failure:downloadFailureBlock];
}



#pragma mark- ============== Download suspend operation ==============

- (void)suspendAllDownloadRequests{
    
    [self.downloadEngine suspendAllDownloadRequests];
}




- (void)suspendDownloadRequest:(SKRequestSerializer)serializer
                           url:(NSString * _Nonnull)url{
    
    [self.downloadEngine suspendDownloadRequest:url];
}




- (void)suspendDownloadRequest:(SKRequestSerializer)serializer
                           url:(NSString * _Nonnull)url ignoreBaseUrl:(BOOL)ignoreBaseUrl{
    
    [self.downloadEngine suspendDownloadRequest:url ignoreBaseUrl:ignoreBaseUrl];
}




- (void)suspendDownloadRequests:(NSArray *_Nonnull)urls{
    
    [self.downloadEngine suspendDownloadRequests:urls];
}




- (void)suspendDownloadRequests:(NSArray *_Nonnull)urls ignoreBaseUrl:(BOOL)ignoreBaseUrl{
    
    [self.downloadEngine suspendDownloadRequests:urls ignoreBaseUrl:ignoreBaseUrl];
}



#pragma mark- ============== Download resume operation ==============

- (void)resumeAllDownloadRequests{
    
    [self.downloadEngine resumeAllDownloadRequests];
}



- (void)resumeDownloadReqeust:(NSString *_Nonnull)url{
    
    [self.downloadEngine resumeDownloadReqeust:url];
}




- (void)resumeDownloadReqeust:(NSString *_Nonnull)url ignoreBaseUrl:(BOOL)ignoreBaseUrl{
    
    [self.downloadEngine resumeDownloadReqeust:url ignoreBaseUrl:ignoreBaseUrl];
}




- (void)resumeDownloadReqeusts:(NSArray *_Nonnull)urls{
    
    [self.downloadEngine resumeDownloadReqeusts:urls];
}




- (void)resumeDownloadReqeusts:(NSArray *_Nonnull)urls ignoreBaseUrl:(BOOL)ignoreBaseUrl{
    
    [self.downloadEngine resumeDownloadReqeusts:urls ignoreBaseUrl:ignoreBaseUrl];
}



#pragma mark- ============== Download cancel operation ==============

- (void)cancelAllDownloadRequests{
    
    [self.downloadEngine cancelAllDownloadRequests];
}



- (void)cancelDownloadRequest:(SKRequestSerializer)serializer
                          url:(NSString * _Nonnull)url{
    
    [self.downloadEngine cancelDownloadRequest:url];
    
}



- (void)cancelDownloadRequest:(SKRequestSerializer)serializer
                          url:(NSString * _Nonnull)url ignoreBaseUrl:(BOOL)ignoreBaseUrl{
    
    [self.downloadEngine cancelDownloadRequest:url ignoreBaseUrl:ignoreBaseUrl];
}




- (void)cancelDownloadRequests:(NSArray *_Nonnull)urls{
    
    [self.downloadEngine cancelDownloadRequests:urls];
}




- (void)cancelDownloadRequests:(NSArray *_Nonnull)urls ignoreBaseUrl:(BOOL)ignoreBaseUrl{
    
    [self.downloadEngine cancelDownloadRequests:urls ignoreBaseUrl:ignoreBaseUrl];
}



#pragma mark- ============== Download resume data ratio ==============

- (CGFloat)resumeDataRatioOfRequest:(NSString *_Nonnull)url{
    
    return  [self.downloadEngine resumeDataRatioOfRequest:url];
}



- (CGFloat)resumeDataRatioOfRequest:(NSString *_Nonnull)url ignoreBaseUrl:(BOOL)ignoreBaseUrl{
    
    return  [self.downloadEngine resumeDataRatioOfRequest:url ignoreBaseUrl:ignoreBaseUrl];
}


#pragma mark- ============== Request Operation ==============

- (void)cancelAllCurrentRequests{
    
    [self.requestPool cancelAllCurrentRequests];
}




- (void)cancelCurrentRequestWithUrl:(NSString *)url{
    
    [self.requestPool cancelCurrentRequestWithUrl:url];
}





- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url
                             method:(NSString * _Nonnull)method
                         parameters:(id _Nullable)parameters{
    
    [self.requestPool cancelCurrentRequestWithUrl:url
                                           method:method
                                       parameters:parameters];
    
}



#pragma mark- ============== Request Info ==============

- (void)logAllCurrentRequests{
    
    [self.requestPool logAllCurrentRequests];
}




- (BOOL)remainingCurrentRequests{
    
    return [self.requestPool remainingCurrentRequests];
}




- (NSInteger)currentRequestCount{
    
    return [self.requestPool currentRequestCount];
}



#pragma mark- ============== Cache Operations ==============


#pragma mark Load cache


- (void)loadCacheWithUrl:(NSString * _Nonnull)url completionBlock:(SKLoadCacheArrCompletionBlock _Nullable)completionBlock{
    
    [self.cacheManager loadCacheWithUrl:url completionBlock:completionBlock];
}



- (void)loadCacheWithUrl:(NSString * _Nonnull)url
                  method:(NSString * _Nonnull)method
         completionBlock:(SKLoadCacheArrCompletionBlock _Nullable)completionBlock{
    
    [self.cacheManager loadCacheWithUrl:url
                                 method:method
                        completionBlock:completionBlock];
}



- (void)loadCacheWithUrl:(NSString * _Nonnull)url
                  method:(NSString * _Nonnull)method
              parameters:(id _Nullable)parameters
         completionBlock:(SKLoadCacheCompletionBlock _Nullable)completionBlock{
    
    [self.cacheManager loadCacheWithUrl:url
                                 method:method
                             parameters:parameters
                        completionBlock:completionBlock];
}



#pragma mark calculate cache

- (void)calculateCacheSizeCompletionBlock:(SKCalculateSizeCompletionBlock _Nullable)completionBlock{
    
    [self.cacheManager calculateAllCacheSizecompletionBlock:completionBlock];
}



#pragma mark clear cache

- (void)clearAllCacheCompletionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock{
    
    [self.cacheManager clearAllCacheCompletionBlock:completionBlock];
}




- (void)clearCacheWithUrl:(NSString * _Nonnull)url completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock{
    
    [self.cacheManager clearCacheWithUrl:url completionBlock:completionBlock];
}



- (void)clearCacheWithUrl:(NSString * _Nonnull)url
                   method:(NSString * _Nonnull)method
          completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock{
    
    
    [self.cacheManager clearCacheWithUrl:url
                                  method:method
                         completionBlock:completionBlock];
    
}



- (void)clearCacheWithUrl:(NSString * _Nonnull)url
                   method:(NSString * _Nonnull)method
               parameters:(id _Nonnull)parameters
          completionBlock:(SKClearCacheCompletionBlock _Nullable)completionBlock{
    
    [self.cacheManager clearCacheWithUrl:url
                                  method:method
                              parameters:parameters
                         completionBlock:completionBlock];
    
}

#pragma mark- Setter and Getter


- (SKNetworkRequestPool *)requestPool{
    
    if (!_requestPool) {
        _requestPool = [SKNetworkRequestPool sharedPool];
    }
    return _requestPool;
}



- (SKNetworkCacheManager *)cacheManager{
    
    if (!_cacheManager) {
        _cacheManager = [SKNetworkCacheManager sharedManager];
    }
    return _cacheManager;
}




- (SKNetworkRequestEngine *)requestEngine{
    
    if (!_requestEngine) {
        _requestEngine = [[SKNetworkRequestEngine alloc] init];
    }
    return _requestEngine;
}




- (SKNetworkUploadEngine *)uploadEngine{
    
    if (!_uploadEngine) {
        _uploadEngine = [[SKNetworkUploadEngine alloc] init];
    }
    return _uploadEngine;
}




- (SKNetworkDownloadEngine *)downloadEngine{
    
    if (!_downloadEngine) {
        _downloadEngine = [[SKNetworkDownloadEngine alloc] init];;
    }
    return _downloadEngine;
}
@end
