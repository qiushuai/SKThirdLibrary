//
//  UIImageView+Base64Image.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <UIKit/UIKit.h>

@interface UIImageView (Base64Image)

/** 查询图像缓存大小 单位kb  */
+ (double)querycacheSize;

/** 清除图像缓存 */
+ (void)clearImageCache;



/**
 *  根据服务器返回的图片是 Base64图片还是 正常的Url加载网络图片
 *
 *  @param url   服务器返回的URL (Base直接填写)
 *  @param image 加载前显示的默认图片
 */
- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(UIImage *)image;


/**
 *  根据服务器返回的图片是 Base64图片还是 正常的Url加载网络图片
 *
 *  @param url      服务器返回的URL (Base直接填写)
 *  @param image    加载前显示的默认图片
 *  @param handler  图片尺寸
 */
- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(UIImage *)image
                   completion:(void(^)(CGSize imageSize))handler;


/**
 *  根据服务器返回的图片是 Base64图片还是 正常的Url加载网络图片
 *
 *  @param url      服务器返回的URL (Base直接填写)
 *  @param image    加载前显示的默认图片
 *  @param handler  加载完的得到的网络图片
 */
- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(UIImage *)image
              imageCompletion:(void(^)(UIImage *image))handler;



@end
