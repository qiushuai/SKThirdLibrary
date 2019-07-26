//
//  SKNetworkUploadEngine.m
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKNetworkUploadEngine.h"
#import "SKNetworkRequestPool.h"
#import "SKNetworkConfig.h"
#import "SKNetworkUtils.h"
#import "SKNetworkProtocol.h"
#import "SKImageScaleTool.h"

@interface SKNetworkUploadEngine()<SKNetworkProtocol>

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SKNetworkUploadEngine
{
    BOOL _isDebugMode;
}

#pragma mark- ============== Life Cycle ==============


- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        //debug mode or not
        _isDebugMode = [SKNetworkConfig sharedConfig].debugMode;
        
        //AFSessionManager config
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        //RequestSerializer
        _sessionManager.requestSerializer.allowsCellularAccess = YES;
        
        _sessionManager.requestSerializer.timeoutInterval = [SKNetworkConfig sharedConfig].timeoutSeconds;
        
        
        //securityPolicy
        _sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        [_sessionManager.securityPolicy setAllowInvalidCertificates:YES];
        _sessionManager.securityPolicy.validatesDomainName = NO;
        
        //ResponseSerializer
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"image/*", nil];
        
        //Queue
        _sessionManager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
        
        
    }
    return self;
}


#pragma mark- ============== Public Methods ==============

- (void)sendUploadImagesRequest:(NSString * _Nonnull)url
                  ignoreBaseUrl:(BOOL)ignoreBaseUrl
                     parameters:(id _Nullable)parameters
                         images:(NSArray<UIImage *> * _Nonnull)images
                   compressSize:(float)compressSize
                   compressType:(SKUploadCompressType)compressType
                           name:(NSString * _Nonnull)name
                       mimeType:(NSString * _Nullable)mimeType
                       progress:(SKUploadProgressBlock _Nullable)uploadProgressBlock
                        success:(SKUploadSuccessBlock _Nullable)uploadSuccessBlock
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock{
    
    //if images count equals 0, then return
    if ([images count] == 0) {
        SKNetworkLog(@"=========== Upload image failed:There is no image to upload!");
        return;
    }
    
    
    //default method is POST
    NSString *methodStr = @"POST";
    
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
    }else{
        NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *encodingUrlString = [url stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
        completeUrlStr   = [[SKNetworkConfig sharedConfig].baseUrl stringByAppendingPathComponent:encodingUrlString];
        requestIdentifer = [SKNetworkUtils generateRequestIdentiferWithBaseUrlStr:[SKNetworkConfig sharedConfig].baseUrl
                                                                    requestUrlStr:url
                                                                        methodStr:methodStr
                                                                       parameters:parameters];
    }
    
    //add custom headers
    [self addCustomHeaders];
    
    //add default parameters
    NSDictionary * completeParameters = [self addDefaultParametersWithCustomParameters:parameters];
    
    //create corresponding request model and send request with it
    SKNetworkRequestModel *requestModel = [[SKNetworkRequestModel alloc] init];
    requestModel.requestUrl = completeUrlStr;
    requestModel.uploadUrl = url;
    requestModel.method = methodStr;
    requestModel.parameters = completeParameters;
    requestModel.uploadImages = images;
    requestModel.imageCompressSize = compressSize;
    requestModel.compressType = compressType;
    requestModel.imagesIdentifer = name;
    requestModel.mimeType = mimeType;
    requestModel.requestIdentifer = requestIdentifer;
    requestModel.uploadSuccessBlock = uploadSuccessBlock;
    requestModel.uploadProgressBlock = uploadProgressBlock;
    requestModel.uploadFailedBlock = uploadFailureBlock;
    
    [self p_sendUploadImagesRequestWithRequestModel:requestModel];
}



#pragma mark- ============== Private Methods ==============

- (void)p_sendUploadImagesRequestWithRequestModel:(SKNetworkRequestModel *)requestModel{
    
    
    if (_isDebugMode) {
        SKNetworkLog(@"=========== Start upload request with url:%@...",requestModel.requestUrl);
    }
    
    __weak __typeof(self) weakSelf = self;
    NSURLSessionDataTask *uploadTask = [_sessionManager POST:requestModel.requestUrl
                                                  parameters:requestModel.parameters
                                   constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                       
                                       
                                       [requestModel.uploadImages enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
                                           
                                           //image data
                                           NSData *imageData = nil;
                                           
                                           //image type
                                           NSString *imageType = nil;
                                           
                                           if ([requestModel.mimeType isEqualToString:@"png"] || [requestModel.mimeType isEqualToString:@"PNG"]  ) {
                                               
                                               imageData = [self compressOfImageWithImage:image maxSize:requestModel.imageCompressSize compressType:requestModel.compressType];
                                               imageType = @"png";
                                               
                                           }else if ([requestModel.mimeType isEqualToString:@"jpg"] || [requestModel.mimeType isEqualToString:@"JPG"] ){
                                               
                                               imageData = [self compressOfImageWithImage:image maxSize:requestModel.imageCompressSize compressType:requestModel.compressType];
                                               imageType = @"jpg";
                                               
                                           }else if ([requestModel.mimeType isEqualToString:@"jpeg"] || [requestModel.mimeType isEqualToString:@"JPEG"] ){
                                               
                                               imageData = [self compressOfImageWithImage:image maxSize:requestModel.imageCompressSize compressType:requestModel.compressType];
                                               imageType = @"jpeg";
                                               
                                           }else{
                                               imageData = [self compressOfImageWithImage:image maxSize:requestModel.imageCompressSize compressType:requestModel.compressType];
                                               imageType = @"jpg";
                                           }
                                           
                                           
                                           if (imageData) {
                                               
                                               NSString *fileName = [NSString stringWithFormat:@"%@/%@.%@", [self getTodayString], [self randomString:18],imageType];
                                               [formData appendPartWithFileData:imageData
                                                                           name:requestModel.imagesIdentifer
                                                                       fileName:fileName
                                                                       mimeType:[NSString stringWithFormat:@"image/%@", imageType]];
                                               
                                           }
                                           
                                           
                                           
                                       }];
                                       
                                   } progress:^(NSProgress * _Nonnull uploadProgress) {
                                       
                                       if (_isDebugMode){
                                           SKNetworkLog(@"=========== Upload image progress:%@",uploadProgress);
                                       }
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           if (requestModel.uploadProgressBlock) {
                                               requestModel.uploadProgressBlock(uploadProgress);
                                           }
                                           
                                       });
                                       
                                   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                       
                                       if (_isDebugMode){
                                           SKNetworkLog(@"=========== Upload image request succeed:%@\n =========== Successfully uploaded images:%@",responseObject,requestModel.uploadImages);
                                       }
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           
                                           if (requestModel.uploadSuccessBlock) {
                                               requestModel.uploadSuccessBlock(responseObject);
                                           }
                                           
                                           [weakSelf handleRequesFinished:requestModel];
                                           
                                       });
                                       
                                       
                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                       
                                       
                                       if (_isDebugMode){
                                           SKNetworkLog(@"=========== Upload images request failed: \n =========== error:%@\n =========== status code:%ld\n =========== failed images:%@:",error,(long)error.code,requestModel.uploadImages);
                                       }
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           
                                           if (requestModel.uploadFailedBlock) {
                                               requestModel.uploadFailedBlock(task, error,error.code,requestModel.uploadImages);
                                           }
                                           [weakSelf handleRequesFinished:requestModel];
                                           
                                       });
                                       
                                   }];
    
    requestModel.task = uploadTask;
    [[SKNetworkRequestPool sharedPool] addRequestModel:requestModel];
    
}


#pragma mark- ============== Private Methods ==============

- (NSData *)compressOfImageWithImage:(UIImage *)image maxSize:(float)maxSize compressType:(SKUploadCompressType)compressType{
    
    if (compressType == SKSKUploadCompresArtwork)
    {
        return UIImageJPEGRepresentation(image, 1);
        
    } else if (compressType == SKUploadCompressWeiChat)
    {
        return [SKImageScaleTool compressOfImageWithWeiChat:image maxSize:maxSize];
        
    } else if (compressType == SKUploadCompressEqualProportion)
    {
        return [SKImageScaleTool compressOfImageWithEqualProportion:image maxSize:maxSize];
        
    } else if (compressType == SKUploadCompressTwoPoints)
    {
        return [SKImageScaleTool compressOfImageWithTwoPoints:image maxSize:maxSize];
        
    } else
    {
        return UIImagePNGRepresentation(image);
    }
}



#pragma mark- ============== Override Methods ==============

- (id)addDefaultParametersWithCustomParameters:(id)parameters{
    
    //if there is default parameters, then add them into custom parameters
    id parameters_spliced = nil;
    
    if (parameters && [parameters isKindOfClass:[NSDictionary class]]) {
        
        if ([[[SKNetworkConfig sharedConfig].defaultParameters allKeys] count] > 0) {
            
            NSMutableDictionary *defaultParameters_m = [[SKNetworkConfig sharedConfig].defaultParameters mutableCopy];
            [defaultParameters_m addEntriesFromDictionary:parameters];
            parameters_spliced = [defaultParameters_m copy];
            
        }else{
            
            parameters_spliced = parameters;
        }
        
    }else{
        
        parameters_spliced = [SKNetworkConfig sharedConfig].defaultParameters;
        
    }
    
    return parameters_spliced;
}



- (void)addCustomHeaders{
    
    //add custom header
    NSDictionary *customHeaders = [SKNetworkConfig sharedConfig].customHeaders;
    if ([customHeaders allKeys] > 0) {
        NSArray *allKeys = [customHeaders allKeys];
        if ([allKeys count] >0) {
            [customHeaders enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
                [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:key];
                if (_isDebugMode) {
                    SKNetworkLog(@"=========== added header:key:%@ value:%@",key,value);
                }
            }];
        }
    }
}



#pragma mark- ============== SKNetworkProtocol ==============

- (void)handleRequesFinished:(SKNetworkRequestModel *)requestModel{
    
    //clear all blocks
    [requestModel clearAllBlocks];
    
    //remove this requst model from request queue
    [[SKNetworkRequestPool sharedPool] removeRequestModel:requestModel];
}


/** random alphanumeric string */
- (NSString *)randomString:(NSInteger)number {
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < number; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
            
        } else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

/** get today date YYYYMMdd */
- (NSString *)getTodayString {
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString *morelocationString = [dateformatter stringFromDate:senddate];
    return morelocationString;
}


@end
