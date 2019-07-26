//
//  SKNetworkRequestEngine.m
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKNetworkRequestEngine.h"
#import "SKNetworkCacheManager.h"
#import "SKNetworkRequestPool.h"
#import "SKNetworkConfig.h"
#import "SKNetworkUtils.h"
#import "SKNetworkProtocol.h"

@interface SKNetworkRequestEngine () <SKNetworkProtocol>

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) SKNetworkCacheManager *cacheManager;

@end


@implementation SKNetworkRequestEngine
{
    NSFileManager *_fileManager;
    BOOL _isDebugMode;
}


#pragma mark- ============== Life Cycle Methods ==============


- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        //file  manager
        _fileManager = [NSFileManager defaultManager];
        
        //cachec manager
        _cacheManager = [SKNetworkCacheManager sharedManager];
        
        //debug mode or not
        _isDebugMode = [SKNetworkConfig sharedConfig].debugMode;
        
        //AFSessionManager config
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _sessionManager.requestSerializer.allowsCellularAccess = YES;
        
        _sessionManager.requestSerializer.timeoutInterval = [SKNetworkConfig sharedConfig].timeoutSeconds;
        
        //securityPolicy
        _sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        [_sessionManager.securityPolicy setAllowInvalidCertificates:YES];
        _sessionManager.securityPolicy.validatesDomainName = NO;
        
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"image/*", nil];
        
        //Queue
        _sessionManager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
        
    }
    return self;
}


#pragma mark- ============== Public Methods ==============


- (void)sendRequest:(NSString *)url
      ignoreBaseUrl:(BOOL)ignoreBaseUrl
             method:(SKRequestMethod)method
         parameters:(id)parameters
          cacheType:(SKNetworkCacheType)cacheType
      cacheDuration:(NSTimeInterval)cacheDuration
            success:(SKSuccessBlock)successBlock
            failure:(SKFailureBlock)failureBlock
{
    
    //request method
    NSString *methodStr = [self p_methodStringFromRequestMethod:method];
    
    //generate full request url
    NSString *completeUrlStr = nil;
    
    //generate a unique identifer of a spectific request
    NSString *requestIdentifer = nil;
    
    
    if (ignoreBaseUrl) {
        NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        completeUrlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
        requestIdentifer = [SKNetworkUtils generateRequestIdentiferWithBaseUrlStr:nil
                                                                    requestUrlStr:url
                                                                        methodStr:methodStr
                                                                       parameters:parameters];
        
    } else
    {
        NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *encodingUrlString = [url stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
        NSString *baseUrl = [SKNetworkConfig sharedConfig].baseUrl;
        completeUrlStr = [SKNetworkUtils generateCompleteRequestUrlStrWithBaseUrlStr:baseUrl
                                                                       requestUrlStr:encodingUrlString];
        
        
        requestIdentifer = [SKNetworkUtils generateRequestIdentiferWithBaseUrlStr:baseUrl
                                                                    requestUrlStr:encodingUrlString
                                                                        methodStr:methodStr
                                                                       parameters:parameters];
    }
    
    
    if (cacheType == SKNetworkCacheTypeNetworkOnly){
        
        [self p_sendRequestWithCompleteUrlStr:completeUrlStr
                                       method:methodStr
                                   parameters:parameters
                                    cacheType:cacheType
                                cacheDuration:cacheDuration
                             requestIdentifer:requestIdentifer
                                      success:successBlock
                                      failure:failureBlock];
        
        
    } else if (cacheType == SKNetworkCacheTypeNetworkOnlyOneOfCache){
        
        //if client wants to load cache
        [_cacheManager loadCacheWithRequestIdentifer:requestIdentifer completionBlock:^(id  _Nullable cacheObject) {
            
            if (cacheObject) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if(_isDebugMode){
                        SKNetworkLog(@"=========== Request succeed by loading Cache! \n =========== Request url:%@\n =========== Response object:%@", completeUrlStr,cacheObject);
                    }
                    
                    if(successBlock){
                        
                        //if existence cache, only load cache
                        NSString *response = [[NSString alloc] initWithData:cacheObject encoding:NSUTF8StringEncoding];
                        id jsonObject = [NSJSONSerialization JSONObjectWithData:cacheObject
                                                                        options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers
                                                                          error:nil];
                        if (jsonObject != nil) {
                            
                            if ([jsonObject isKindOfClass:[NSDictionary class]]){
                                successBlock(jsonObject, YES);
                            }
                            
                        }else{
                            
                            successBlock(response, YES);
                        }
                    }
                    
                });
                
                
            }else{
                
                //failed to load cache, start to sending network request...
                [self p_sendRequestWithCompleteUrlStr:completeUrlStr
                                               method:methodStr
                                           parameters:parameters
                                            cacheType:cacheType
                                        cacheDuration:cacheDuration
                                     requestIdentifer:requestIdentifer
                                              success:successBlock
                                              failure:failureBlock];
                
            }
            
        }];
        
        
    } else if (cacheType == SKNetworkCacheTypeCacheNetwork){
        
        //first, sending network request, if generate error, then load cache
        [self p_sendRequestWithCompleteUrlStr:completeUrlStr
                                       method:methodStr
                                   parameters:parameters
                                    cacheType:cacheType
                                cacheDuration:cacheDuration
                             requestIdentifer:requestIdentifer
                                      success:successBlock
                                      failure:failureBlock];
        
        
        
    }else{
        
        //      SKNetworkLog(@"=========== Do not need to load cache, start sending network request...");
        [self p_sendRequestWithCompleteUrlStr:completeUrlStr
                                       method:methodStr
                                   parameters:parameters
                                    cacheType:cacheType
                                cacheDuration:cacheDuration
                             requestIdentifer:requestIdentifer
                                      success:successBlock
                                      failure:failureBlock];
        
    }
}





#pragma mark- ============== Private Methods ==============


- (void)p_sendRequestWithCompleteUrlStr:(NSString *)completeUrlStr
                                 method:(NSString *)methodStr
                             parameters:(id)parameters
                              cacheType:(SKNetworkCacheType)cacheType
                          cacheDuration:(NSTimeInterval)cacheDuration
                       requestIdentifer:(NSString *)requestIdentifer
                                success:(SKSuccessBlock)successBlock
                                failure:(SKFailureBlock)failureBlock{
    
    //add customed headers
    [self addCustomHeaders];
    
    //add default parameters
    NSDictionary *params = [self addDefaultParameters:parameters];
    
    //create corresponding request model
    SKNetworkRequestModel *requestModel = [[SKNetworkRequestModel alloc] init];
    requestModel.requestUrl = completeUrlStr;
    requestModel.method = methodStr;
    requestModel.parameters = [params mutableCopy];
    
    //    if (_isDebugMode) {
    NSLog(@"parameters: %@\n\ncompleteUrlStr: %@\n\n", requestModel.parameters, completeUrlStr);
    //    }
    
    
    requestModel.requestIdentifer = requestIdentifer;
    requestModel.successBlock = successBlock;
    requestModel.failureBlock = failureBlock;
    requestModel.cacheType  = cacheType;
    
    
    switch (cacheType) {
        case SKNetworkCacheTypeCacheNetwork: {
            NSInteger duration = cacheDuration <= 0 ? 0 : cacheDuration;
            requestModel.cacheDuration = duration * 86400;
            requestModel.loadCache = YES;
        } break;
            
        case SKNetworkCacheTypeNetworkOnly: {
            NSInteger duration = cacheDuration <= 0 ? 0 : cacheDuration;
            requestModel.cacheDuration = duration * 86400;
            requestModel.loadCache = YES;
        } break;
            
        default: {
            requestModel.cacheDuration = 0;
            requestModel.loadCache = NO;
        } break;
    }
    
    
    
    //create a session task corresponding to a request model
    NSError * __autoreleasing requestSerializationError = nil;
    NSURLSessionDataTask *dataTask = [self p_dataTaskWithRequestModel:requestModel
                                                    requestSerializer:_sessionManager.requestSerializer
                                                                error:&requestSerializationError];
    
    
    //save task info request model
    requestModel.task = dataTask;
    
    //save this request model into request set
    [[SKNetworkRequestPool sharedPool] addRequestModel:requestModel];
    
    if (_isDebugMode) {
        SKNetworkLog(@"=========== Start requesting...\n =========== url:%@\n =========== method:%@\n =========== parameters:%@",completeUrlStr,methodStr,parameters);
    }
    
    
    //start request
    [dataTask resume];
    
}



- (NSURLSessionDataTask *)p_dataTaskWithRequestModel:(SKNetworkRequestModel *)requestModel
                                   requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                               error:(NSError * _Nullable __autoreleasing *)error{
    
    //create request
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:requestModel.method
                                                              URLString:requestModel.requestUrl
                                                             parameters:requestModel.parameters
                                                                  error:error];
    
    
    
    //create data task
    __weak __typeof(self) weakSelf = self;
    NSURLSessionDataTask * dataTask = [_sessionManager dataTaskWithRequest:request
                                                            uploadProgress:nil
                                                          downloadProgress:nil
                                                         completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
                                       {
                                           //if generate error, load cache
                                           //                                           if (error) {
                                           //
                                           //                                               __weak __typeof(self) weakSelf = self;
                                           //                                               if (requestModel.cacheType == SKNetworkCacheTypeCacheNetwork) {
                                           //
                                           //                                                   [_cacheManager loadCacheWithRequestIdentifer:requestModel.requestIdentifer completionBlock:^(id  _Nullable cacheObject) {
                                           //
                                           //                                                       if (cacheObject)
                                           //                                                       {
                                           //                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                           //
                                           //                                                               if (_isDebugMode) {
                                           //                                                                   SKNetworkLog(@"=========== Request succeed! \n =========== Request url:%@\n =========== Response object:%@", requestModel.requestUrl,cacheObject);
                                           //                                                               }
                                           //
                                           //                                                               if (requestModel.successBlock) {
                                           //                                                                   requestModel.successBlock(cacheObject, YES);
                                           //                                                               }
                                           //                                                           });
                                           //
                                           //                                                       }else
                                           //                                                       {
                                           //                                                           //request failed
                                           //                                                           [weakSelf requestDidFailedWithRequestModel:requestModel error:error];
                                           //                                                       }
                                           //
                                           //                                                   }];
                                           //
                                           //                                               }else
                                           //                                               {
                                           //                                                   //request failed
                                           //                                                   [self requestDidFailedWithRequestModel:requestModel error:error];
                                           //                                               }
                                           //
                                           //
                                           //                                           }else{
                                           
                                           
                                           if (requestModel.serializer == SKJSONHTTPRequestSerializer) {
                                               
                                               
                                               if ([responseObject isKindOfClass:[NSString class]]) {
                                                   
                                                   NSString  *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                   [weakSelf p_handleRequestModel:requestModel responseObject:response error:error];
                                                   
                                               }else if ([responseObject isKindOfClass:[NSData class]]) {
                                                   
                                                   NSString  *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                   id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                                   options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers
                                                                                                     error:nil];
                                                   if (jsonObject != nil && error == nil){
                                                       
                                                       if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                                                           [weakSelf p_handleRequestModel:requestModel responseObject:jsonObject error:error];
                                                       }
                                                       
                                                   }else{
                                                       
                                                       [weakSelf p_handleRequestModel:requestModel responseObject:response error:error];
                                                       
                                                   }
                                                   
                                               }else{
                                                   
                                                   [weakSelf p_handleRequestModel:requestModel responseObject:responseObject error:error];
                                               }
                                               
                                               
                                           } else
                                           {
                                               [weakSelf p_handleRequestModel:requestModel responseObject:responseObject error:error];
                                           }
                                           
                                           
                                           //                                           }
                                           
                                       }];
    
    return dataTask;
    
}




- (void)p_handleRequestModel:(SKNetworkRequestModel *)requestModel
              responseObject:(id)responseObject
                       error:(NSError *)error{
    
    //    if (error) {
    
    //request failed
    //        [self requestDidFailedWithRequestModel:requestModel error:error];
    
    //    } else {
    
    //request succeed
    requestModel.responseObject = responseObject;
    [self requestDidSucceedWithRequestModel:requestModel];
    
    //    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self handleRequesFinished:requestModel];
        
    });
    
}




- (NSString *)p_methodStringFromRequestMethod:(SKRequestMethod)method{
    
    switch (method) {
            
        case SKRequestMethodGET:{
            return @"GET";
        }
            break;
            
        case SKRequestMethodPOST:{
            return  @"POST";
        }
            break;
            
        case SKRequestMethodPUT:{
            return  @"PUT";
        }
            break;
            
        case SKRequestMethodDELETE:{
            return  @"DELETE";
        }
            break;
    }
}


#pragma mark- ============== Override Methods ==============


- (void)requestDidSucceedWithRequestModel:(SKNetworkRequestModel *)requestModel{
    
    //write cache
    if (requestModel.cacheDuration > 0) {
        
        if ([requestModel.responseObject isKindOfClass:[NSString class]])
        {
            requestModel.responseData = [requestModel.responseObject dataUsingEncoding:NSUTF8StringEncoding];
            
        }else{
            
            if (requestModel.responseObject)
            {
                requestModel.responseData = [NSJSONSerialization dataWithJSONObject:requestModel.responseObject options:NSJSONWritingPrettyPrinted error:nil];
            }
        }
        
        if (requestModel.responseData) {
            
            [_cacheManager writeCacheWithReqeustModel:requestModel asynchronously:YES];
            
        }else{
            SKNetworkLog(@"=========== Failded to write cache, since something was wrong when transfering response data");
        }
        
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (_isDebugMode) {
            SKNetworkLog(@"=========== Request succeed! \n =========== Request url:%@\n =========== Response object:%@", requestModel.requestUrl,requestModel.responseObject);
        }
        
        if (requestModel.successBlock) {
            requestModel.successBlock(requestModel.responseObject, NO);
        }
    });
    
}




- (void)requestDidFailedWithRequestModel:(SKNetworkRequestModel *)requestModel error:(NSError *)error{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (_isDebugMode) {
            SKNetworkLog(@"=========== Request failded! \n =========== Request model:%@ \n =========== NSError object:%@ \n =========== Status code:%ld",requestModel,error,(long)error.code);
        }
        
        if (requestModel.failureBlock){
            requestModel.failureBlock(requestModel.task, error, error.code);
        }
        
    });
}


- (void)addCustomHeaders{
    
    //add custom header
    NSDictionary *customHeaders = [SKNetworkConfig sharedConfig].customHeaders;
    if ([customHeaders allKeys] > 0) {
        [customHeaders enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
            [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:key];
        }];
        if (_isDebugMode) {
            SKNetworkLog(@"=========== customHeaders:%@",customHeaders);
        }
    }
}


- (NSDictionary *)addDefaultParameters:(NSDictionary *)paramters {
    
    //add default parameters
    NSDictionary *defaultParameters = [SKNetworkConfig sharedConfig].defaultParameters;
    if ([defaultParameters allKeys] > 0) {
        NSMutableDictionary *paramters_m = !paramters ? [@{} mutableCopy] : [paramters mutableCopy];
        [defaultParameters enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
            [paramters_m setObject:value forKey:key];
        }];
        if (_isDebugMode) {
            SKNetworkLog(@"=========== default parameters:%@",paramters_m);
        }
        return paramters_m;
    } else
    {
        return paramters;
    }
}



#pragma mark- ============== SKNetworkProtocol ==============

- (void)handleRequesFinished:(SKNetworkRequestModel *)requestModel{
    
    //clear all blocks
    [requestModel clearAllBlocks];
    
    //remove this requst model from request queue
    [[SKNetworkRequestPool sharedPool] removeRequestModel:requestModel];
    
}



@end
