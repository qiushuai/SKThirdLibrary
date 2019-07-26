//
//  SKNetworkRequestModel.m
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "SKNetworkRequestModel.h"
#import "SKNetworkConfig.h"
#import "SKNetworkUtils.h"

@interface SKNetworkRequestModel()

@property (nonatomic, readwrite, copy) NSString *cacheDataFilePath;
@property (nonatomic, readwrite, copy) NSString *cacheDataInfoFilePath;

@property (nonatomic, readwrite, copy) NSString *resumeDataFilePath;
@property (nonatomic, readwrite, copy) NSString *resumeDataInfoFilePath;

@end

@implementation SKNetworkRequestModel

#pragma mark- ============== Public Methods ==============


- (SKRequestType)requestType{
    
    if (self.downloadFilePath){
        
        return SKRequestTypeDownload;
        
    }else if(self.uploadUrl){
        
        return SKRequestTypeUpload;
        
    }else{
        
        return SKRequestTypeOrdinary;
        
    }
}




- (NSString *)cacheDataFilePath{
    
    if (self.requestType == SKRequestTypeOrdinary) {
        
        if (_cacheDataFilePath.length > 0) {
            
            return _cacheDataFilePath;
            
        }else{
            
            _cacheDataFilePath = [SKNetworkUtils cacheDataFilePathWithRequestIdentifer:_requestIdentifer];
            return _cacheDataFilePath;
        }
        
    }else{
        
        return nil;
    }
    
}




- (NSString *)cacheDataInfoFilePath{
    
    
    if (self.requestType == SKRequestTypeOrdinary) {
        
        if (_cacheDataInfoFilePath.length > 0) {
            
            return _cacheDataInfoFilePath;
            
        }else{
            
            _cacheDataInfoFilePath = [SKNetworkUtils cacheDataInfoFilePathWithRequestIdentifer:_requestIdentifer];
            return _cacheDataInfoFilePath;
        }
        
    }else{
        
        return nil;
    }
    
}





- (NSString *)resumeDataFilePath{
    
    if (self.requestType == SKRequestTypeDownload) {
        
        if (_resumeDataFilePath.length > 0) {
            
            return _resumeDataFilePath;
            
        }else{
            
            _resumeDataFilePath = [SKNetworkUtils resumeDataFilePathWithRequestIdentifer:_requestIdentifer downloadFileName:_downloadFilePath.lastPathComponent];
            return _resumeDataFilePath;
        }
        
    }else{
        
        return nil;
        
    }
}




- (NSString *)resumeDataInfoFilePath{
    
    if (self.requestType == SKRequestTypeDownload) {
        
        if (_resumeDataInfoFilePath.length > 0) {
            
            return _resumeDataInfoFilePath;
            
        }else{
            
            _resumeDataInfoFilePath = [SKNetworkUtils resumeDataInfoFilePathWithRequestIdentifer:_requestIdentifer];
            return _resumeDataInfoFilePath;
        }
        
    }else{
        
        return nil;
        
    }
    
}





- (void)clearAllBlocks{
    
    _successBlock = nil;
    _failureBlock = nil;
    
    _uploadProgressBlock = nil;
    _uploadSuccessBlock = nil;
    _uploadFailedBlock = nil;
    
    _downloadProgressBlock = nil;
    _downloadSuccessBlock = nil;
    _downloadFailureBlock= nil;
    
}


#pragma mark- ============== Override Methods ==============

- (NSString *)description{
    
    if ([SKNetworkConfig sharedConfig].debugMode) {
        
        switch (self.requestType) {
                
            case SKRequestTypeOrdinary:
                return [NSString stringWithFormat:@"\n{\n   <%@: %p>\n   type:            oridnary request\n   method:          %@\n   url:             %@\n   parameters:      %@\n   loadCache:       %@\n   cacheDuration:   %@ seconds\n   requestIdentifer:%@\n   task:            %@\n}" ,NSStringFromClass([self class]),self,_method,_requestUrl,_parameters,_loadCache?@"YES":@"NO",[NSNumber numberWithInteger:_cacheDuration],_requestIdentifer,_task];
                break;
                
            case SKRequestTypeUpload:
                return [NSString stringWithFormat:@"\n{\n   <%@: %p>\n   type:            upload request\n   method:          %@\n   url:             %@\n   parameters:      %@\n   images:          %@\n    requestIdentifer:%@\n   task:            %@\n}" ,NSStringFromClass([self class]),self,_method,_requestUrl,_parameters,_uploadImages,_requestIdentifer,_task];
                break;
                
            case SKRequestTypeDownload:
                return [NSString stringWithFormat:@"\n{\n   <%@: %p>\n   type:            download request\n   method:          %@\n   url:             %@\n   parameters:      %@\n   target path:     %@\n    requestIdentifer:%@\n   task:            %@\n}" ,NSStringFromClass([self class]),self,_method,_requestUrl,_parameters,_downloadFilePath,_requestIdentifer,_task];
                break;
                
            default:
                [NSString stringWithFormat:@"\n  request type:unkown request type\n  request object:%@",self];
                break;
        }
        
        
    }else{
        
        return [NSString stringWithFormat:@"<%@: %p>" ,NSStringFromClass([self class]),self];
    }
}

@end
