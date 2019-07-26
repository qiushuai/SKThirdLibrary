//
//  SKImageScaleTool.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SKImageScaleTool : NSObject

/** 仿微信压缩图像
 
 宽高均 <= 1280，图片尺寸大小保持不变
 宽或高 > 1280 && 宽高比 <= 2，取较大值等于1280，较小值等比例压缩
 宽或高 > 1280 && 宽高比 > 2 && 宽或高 < 1280，图片尺寸大小保持不变
 宽高均 > 1280 && 宽高比 > 2，取较小值等于1280，较大值等比例压缩
 
 */
+ (NSData *)compressOfImageWithWeiChat:(UIImage *)source_image
                               maxSize:(NSInteger)maxSize;


/** 等比例缩小图像压缩 图像宽度参照 1242 进行等比例压缩 */
+ (NSData *)compressOfImageWithEqualProportion:(UIImage *)source_image
                                       maxSize:(NSInteger)maxSize;


/** 二分法压缩图像 */
+ (NSData *)compressOfImageWithTwoPoints:(UIImage *)source_image
                                 maxSize:(NSInteger)maxSize;

@end

NS_ASSUME_NONNULL_END
