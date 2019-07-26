//
//  SKNetworkHeader.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#ifndef SKNetworkHeader_h
#define SKNetworkHeader_h

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

//Log used to debug
#ifdef DEBUG
#define SKNetworkLog(...) printf("\n%s  ---->  %s\n",__TIME__,[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define SKNetworkLog(...)
#endif

//#ifndef __OPTIMIZE__
//#define SKNetworkLog(...) printf("\n%s  ---->  %s\n",__TIME__,[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
//#endif

//============== Callbacks: Only for ordinary request ==================//
typedef void(^SKSuccessBlock)(id responseObject, BOOL isCacheObject);
typedef void(^SKFailureBlock)(NSURLSessionTask *task, NSError *error, NSInteger statusCode);


//============== Callbacks: Only for upload request ==================//
typedef void(^SKUploadSuccessBlock)(id responseObject);
typedef void(^SKUploadProgressBlock)(NSProgress *uploadProgress);
typedef void(^SKUploadFailureBlock)(NSURLSessionTask *task, NSError *error, NSInteger statusCode, NSArray<UIImage *>*uploadFailedImages);


//============== Callbacks: Only for download request ==================//
typedef void(^SKDownloadSuccessBlock)(id responseObject);
typedef void(^SKDownloadProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress);
typedef void(^SKDownloadFailureBlock)(NSURLSessionTask *task, NSError *error, NSString* resumableDataPath);


/** 网络请求方方式 */
typedef NS_ENUM(NSInteger, SKRequestMethod) {
    
    SKRequestMethodGET = 60000,
    SKRequestMethodPOST,
    SKRequestMethodPUT,
    SKRequestMethodDELETE,
    
};


/** 网络请求方式 */
typedef NS_ENUM(NSInteger, SKRequestType) {
    
    SKRequestTypeOrdinary = 70000,  //  普通请求
    SKRequestTypeUpload,            //  上传
    SKRequestTypeDownload           //  下载
    
};


/** 下载状态 */
typedef NS_ENUM(NSInteger, SKDownloadManualOperation) {
    
    SKDownloadManualOperationStart = 80000, //  开始下载
    SKDownloadManualOperationSuspend,       //  暂停下载
    SKDownloadManualOperationResume,        //  继续加载
    SKDownloadManualOperationCancel,        //  取消下载
    
};


/** 请求序列化方式 */
typedef NS_ENUM(NSUInteger, SKRequestSerializer) {
    
    SKJSONRequestSerializer = 90000,
    SKHTTPRequestSerializer,
    SKJSONHTTPRequestSerializer
    
};


/** 网络请求缓存策略 */
typedef NS_ENUM(NSUInteger, SKNetworkCacheType) {
    
    SKNetworkCacheTypeCacheNetwork = 50000,      //  先加载网络数据，当发生断网或者链接错误的时候加载缓存数据
    SKNetworkCacheTypeNetworkOnly,               //  只加载网络数据
    SKNetworkCacheTypeNetworkOnlyOneOfCache      //  第一次加载网络数据,以后加载都加载缓存
    
};


/** 图片压缩策略 */
typedef NS_ENUM(NSUInteger, SKUploadCompressType) {
    
    SKSKUploadCompresArtwork = 40000,       //  原图上传，不进行压缩
    SKUploadCompressWeiChat,                //  仿照微信压缩      （仿照微信的压缩比例）
    SKUploadCompressEqualProportion,        //  图像等比例缩小压缩 （宽度参照 1242 进行等比例缩小）
    SKUploadCompressTwoPoints               //  采用二分法压缩    （最接近压缩比例）
};

#endif /* SKNetworkHeader_h */
