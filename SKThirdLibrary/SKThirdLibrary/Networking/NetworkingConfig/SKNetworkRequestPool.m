//
//  SKNetworkRequestPool.m
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKNetworkRequestPool.h"
#import "SKNetworkUtils.h"
#import "SKNetworkConfig.h"
#import "SKNetworkRequestModel.h"
#import "SKNetworkProtocol.h"

#import "objc/runtime.h"
#import <CommonCrypto/CommonDigest.h>
#import <pthread/pthread.h>


#define Lock() pthread_mutex_lock(&_lock)
#define Unlock() pthread_mutex_unlock(&_lock)

static char currentRequestModelsKey;

@interface SKNetworkRequestModel()<SKNetworkProtocol>

@end

@implementation SKNetworkRequestPool
{
    pthread_mutex_t _lock;
    BOOL _isDebugMode;
}


#pragma mark- ============== Life Cycle ==============

+ (SKNetworkRequestPool *)sharedPool {
    
    static SKNetworkRequestPool *sharedPool = NULL;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedPool = [[SKNetworkRequestPool alloc] init];
    });
    return sharedPool;
}



- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        //lock
        pthread_mutex_init(&_lock, NULL);
        
        //debug mode or not
        _isDebugMode = [SKNetworkConfig sharedConfig].debugMode;
        
    }
    return self;
}

#pragma mark- ============== Public Methods ==============

- (SKCurrentRequestModels *)currentRequestModels {
    
    SKCurrentRequestModels *currentTasks = objc_getAssociatedObject(self, &currentRequestModelsKey);
    if (currentTasks) {
        return currentTasks;
    }
    currentTasks = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &currentRequestModelsKey, currentTasks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return currentTasks;
}



- (void)addRequestModel:(SKNetworkRequestModel *)requestModel{
    
    Lock();
    [self.currentRequestModels setObject:requestModel forKey:[NSString stringWithFormat:@"%ld",(unsigned long)requestModel.task.taskIdentifier]];
    Unlock();
}



- (void)removeRequestModel:(SKNetworkRequestModel *)requestModel{
    
    Lock();
    [self.currentRequestModels removeObjectForKey:[NSString stringWithFormat:@"%ld",(unsigned long)requestModel.task.taskIdentifier]];
    Unlock();
    
}



- (void)changeRequestModel:(SKNetworkRequestModel *_Nonnull)requestModel forKey:(NSString *_Nonnull)key{
    
    Lock();
    [self.currentRequestModels removeObjectForKey:key];
    [self.currentRequestModels setObject:requestModel forKey:[NSString stringWithFormat:@"%ld",(unsigned long)requestModel.task.taskIdentifier]];
    Unlock();
    
}



- (BOOL)remainingCurrentRequests{
    
    NSArray *keys = [self.currentRequestModels  allKeys];
    if ([keys count]>0) {
        SKNetworkLog(@"=========== There is remaining current request");
        return YES;
    }
    SKNetworkLog(@"=========== There is no remaining current request");
    return NO;
}




- (NSInteger)currentRequestCount{
    
    if(![self remainingCurrentRequests]){
        return 0;
    }
    
    NSArray *keys = [self.currentRequestModels allKeys];
    SKNetworkLog(@"=========== There is %ld current requests",(unsigned long)keys.count);
    return [keys count];
    
}





- (void)logAllCurrentRequests{
    
    if ([self remainingCurrentRequests]) {
        
        [self.currentRequestModels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SKNetworkRequestModel * _Nonnull requestModel, BOOL * _Nonnull stop) {
            SKNetworkLog(@"=========== Log current request:\n %@",requestModel);
        }];
        
    }
}





- (void)cancelAllCurrentRequests{
    
    if ([self remainingCurrentRequests]) {
        
        for (SKNetworkRequestModel *requestModel in [self.currentRequestModels allValues]) {
            
            
            if (requestModel.requestType == SKRequestTypeDownload) {
                
                if (requestModel.backgroundDownloadSupport) {
                    
                    NSURLSessionDownloadTask *downloadTask = (NSURLSessionDownloadTask*)requestModel.task;
                    [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                    }];
                    
                }else{
                    
                    [requestModel.task cancel];
                }
                
            }else{
                
                [requestModel.task cancel];
                [self removeRequestModel:requestModel];
            }
        }
        SKNetworkLog(@"=========== Canceled call current requests");
    }
    
    
}





- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url{
    
    if(![self remainingCurrentRequests]){
        return;
    }
    
    NSMutableArray *cancelRequestModelsArr = [NSMutableArray arrayWithCapacity:2];
    NSString *requestIdentiferOfUrl =  [SKNetworkUtils generateMD5StringFromString: [NSString stringWithFormat:@"Url:%@",url]];
    
    [self.currentRequestModels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SKNetworkRequestModel * _Nonnull requestModel, BOOL * _Nonnull stop) {
        
        if ([requestModel.requestIdentifer containsString:requestIdentiferOfUrl]) {
            [cancelRequestModelsArr addObject:requestModel];
        }
    }];
    
    if ([cancelRequestModelsArr count] == 0) {
        
        SKNetworkLog(@"=========== There is no request to be canceled");
        
    }else {
        
        if (_isDebugMode) {
            SKNetworkLog(@"=========== Requests to be canceled:");
            [cancelRequestModelsArr enumerateObjectsUsingBlock:^(SKNetworkRequestModel *requestModel, NSUInteger idx, BOOL * _Nonnull stop) {
                SKNetworkLog(@"=========== cancel request with url[%ld]:%@",(unsigned long)idx,requestModel.requestUrl);
            }];
        }
        
        [cancelRequestModelsArr enumerateObjectsUsingBlock:^(SKNetworkRequestModel *requestModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            if (requestModel.requestType == SKRequestTypeDownload) {
                
                if (requestModel.backgroundDownloadSupport) {
                    NSURLSessionDownloadTask *downloadTask = (NSURLSessionDownloadTask*)requestModel.task;
                    
                    if (requestModel.task.state == NSURLSessionTaskStateCompleted) {
                        
                        SKNetworkLog(@"=========== Canceled background support download request:%@",requestModel);
                        NSError *error = [NSError errorWithDomain:@"Request has been canceled" code:0 userInfo:nil];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (requestModel.downloadFailureBlock) {
                                requestModel.downloadFailureBlock(requestModel.task, error,requestModel.resumeDataFilePath);
                            }
                            [self handleRequesFinished:requestModel];
                        });
                        
                    }else{
                        
                        [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                            
                        }];
                        SKNetworkLog(@"=========== Background support download request %@ has been canceled",requestModel);
                    }
                    
                }else{
                    
                    [requestModel.task cancel];
                    SKNetworkLog(@"=========== Request %@ has been canceled",requestModel);
                }
                
            }else{
                
                [requestModel.task cancel];
                SKNetworkLog(@"=========== Request %@ has been canceled",requestModel);
                if (requestModel.requestType != SKRequestTypeDownload) {
                    [self removeRequestModel:requestModel];
                }
            }
        }];
        
        SKNetworkLog(@"=========== All requests with request url : '%@' are canceled",url);
    }
    
    
}




- (void)cancelCurrentRequestWithUrls:(NSArray * _Nonnull)urls{
    
    if ([urls count] == 0) {
        SKNetworkLog(@"=========== There is no input urls!");
        return;
    }
    
    if(![self remainingCurrentRequests]){
        return;
    }
    
    [urls enumerateObjectsUsingBlock:^(NSString *url, NSUInteger idx, BOOL * _Nonnull stop) {
        [self cancelCurrentRequestWithUrl:url];
    }];
}






- (void)cancelCurrentRequestWithUrl:(NSString * _Nonnull)url
                             method:(NSString * _Nonnull)method
                         parameters:(id _Nullable)parameter{
    
    if(![self remainingCurrentRequests]){
        return;
    }
    
    NSString *encodingUrlString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    NSString *requestIdentifier = [SKNetworkUtils generateRequestIdentiferWithBaseUrlStr:[SKNetworkConfig sharedConfig].baseUrl
                                                                           requestUrlStr:encodingUrlString
                                                                               methodStr:method
                                                                              parameters:parameter];
    
    [self p_cancelRequestWithRequestIdentifier:requestIdentifier];
}



#pragma mark- ============== Private Methods ==============

- (void)p_cancelRequestWithRequestIdentifier:(NSString *)requestIdentifier{
    
    [self.currentRequestModels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, SKNetworkRequestModel * _Nonnull requestModel, BOOL * _Nonnull stop) {
        
        if ([requestModel.requestIdentifer isEqualToString:requestIdentifier]) {
            
            if (requestModel.task) {
                
                [requestModel.task cancel];
                SKNetworkLog(@"=========== Canceled request:%@",requestModel);
                if (requestModel.requestType != SKRequestTypeDownload) {
                    [self removeRequestModel:requestModel];
                }
                
            }else {
                SKNetworkLog(@"=========== There is no task of this request");
            }
        }
    }];
}




#pragma mark- ============== SKNetworkProtocol ==============

- (void)handleRequesFinished:(SKNetworkRequestModel *)requestModel{
    
    //clear all blocks
    [requestModel clearAllBlocks];
    
    //remove this requst model from request queue
    [[SKNetworkRequestPool sharedPool] removeRequestModel:requestModel];
    
}


@end
