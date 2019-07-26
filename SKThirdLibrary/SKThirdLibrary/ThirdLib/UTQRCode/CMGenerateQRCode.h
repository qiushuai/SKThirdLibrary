//
//  CMGenerateQRCode.h
//  CMKit
//
//  Created by jon on 16/10/25.
//  Copyright © 2016年 jon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 #生成二维码
 */
@interface CMGenerateQRCode : NSObject
/*!
 @method 生成二维码
 @Param content 二维码中的信息
 @Param size 二维码的大小
 */

+(UIImage *)encodeQRImageWithContent:(NSString *)content size:(CGSize)size;
/*!
 @method  在二维码中嵌入icon
 @Param image 二维码图片
 @Param icon logo图片
 @Param iconSize logo图片的尺寸
 */
+ (UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize;

+ (UIImage *)addQRCodeToImage:(UIImage *)image withQRCode:(UIImage *)qrCode withQRCodeRect:(CGRect)qrCodeRect;
@end
