//
//  SKNetworkDownloadResumeDataInfo.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/* =============================
 *
 * SKNetworkDownloadResumeDataInfo
 *
 * SKNetworkDownloadResumeDataInfo is in charge of recording the infomation of resume data of the corresponding download request
 *
 * =============================
 */

@interface SKNetworkDownloadResumeDataInfo : NSObject<NSSecureCoding>

// Record the resume data length
@property (nonatomic, readwrite, copy) NSString *resumeDataLength;

// Record total length of the download data
@property (nonatomic, readwrite, copy) NSString *totalDataLength;

// Record the ratio of resume data length and total length of download data (resumeDataLength/dataTotalLength)
@property (nonatomic, readwrite, copy) NSString *resumeDataRatio;

@end

NS_ASSUME_NONNULL_END
