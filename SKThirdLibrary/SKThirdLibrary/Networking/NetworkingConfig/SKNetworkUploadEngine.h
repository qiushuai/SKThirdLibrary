//
//  SKNetworkUploadEngine.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKNetworkBaseEngine.h"


/* =============================
 *
 * SKNetworkUploadEngine
 *
 * SKNetworkUploadEngine is in charge of upload image or images.
 *
 * =============================
 */


@interface SKNetworkUploadEngine : SKNetworkBaseEngine


//========================= Request API upload images ==========================//


/**
 *  This method offers the most number of parameters of a certain upload request.
 *
 *  @note:
 *        1. All the other upload image API will call this method.
 *
 *        2. If 'ignoreBaseUrl' is set to be YES, the base url which is holden by
 *           SKNetworkConfig will be ignored, so the 'url' will be the complete request
 *           url of this request.(default is set to be NO)
 *
 *        3. 'name' is the name of image(or images). When uploading more than one
 *           image, a new unique name of one single image will be generated in method
 *           implementation.
 *
 *  @param url                   request url
 *  @param ignoreBaseUrl         consider whether to ignore configured base url
 *  @param parameters            parameters
 *  @param images                UIImage object array
 *  @param compressSize          compress size of images
 *  @param compressType          compress size of type
 *  @param name                  file name
 *  @param mimeType              file type
 *  @param uploadProgressBlock   upload progress callback
 *  @param uploadSuccessBlock    upload success callback
 *  @param uploadFailureBlock    upload failure callback
 *
 */
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
                        failure:(SKUploadFailureBlock _Nullable)uploadFailureBlock;


@end
