//
//  UIImage+CreateBarcode.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//


#import <UIKit/UIKit.h>

@interface UIImage (CreateBarcode)

/** 通过链接地址生成二维码图片 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress;


/** 通过链接地址生成二维码图片并且设置二维码宽度
 *  当网络图片加载错误的时候会返回一张黑色的图片
 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize;


/** 通过链接地址生成二维码图片以及设置二维码宽度和颜色 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue;


/** 通过链接地址生成二维码图片以及设置二维码宽度和颜色，在二维码中间插入图片 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue
                  insertImage: (UIImage *)insertImage;

/** 通过链接地址生成二维码图片以及设置二维码宽度和颜色，在二维码中间插入圆角图片 */
+ (UIImage *)imageOfQRFromURL: (NSString *)networkAddress
                     codeSize: (CGFloat)codeSize
                          red: (NSUInteger)red
                        green: (NSUInteger)green
                         blue: (NSUInteger)blue
                  insertImage: (UIImage *)insertImage
                  roundRadius: (CGFloat)roundRadius;

@end
