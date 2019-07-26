//
//  UIImageView+Base64Image.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "UIImageView+Base64Image.h"
//  依赖于 SDWebImage 中的 UIImageView+WebCache.h   开发者可根据需求自行更换
#if __has_include(<SDWebImage/UIImageView+WebCache.h>)
#import <SDWebImage/UIImageView+WebCache.h>
#else
#import "UIImageView+WebCache.h"
#endif

@implementation UIImageView (Base64Image)

/** 查询图像缓存大小 */
+ (double)querycacheSize {
    
    SDImageCache *manager = [SDImageCache sharedImageCache];
//    return [manager getSize] / 1024 * 1.0;
    return manager.totalDiskSize /1024 * 1.0;
}

/** 清除图像缓存 */
+ (void)clearImageCache {
    
    SDImageCache *manager = [SDImageCache sharedImageCache];
    [manager clearMemory];
    [manager deleteOldFilesWithCompletionBlock:nil];
    [manager clearDiskOnCompletion:nil];
}


//  根据图片下载地址或者二进制字符串 设置图片
- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(UIImage *)image {
    
    if (![url isKindOfClass:[NSString class]] || !url.length) {
        self.image = image;
        return;
    }
    
    if (url.length >= 10 && [[url substringWithRange:NSMakeRange(0, 10)] isEqualToString:@"data:image"])
    {
        NSArray *imageArray = [url componentsSeparatedByString:@","];
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageArray[1] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.image = [UIImage imageWithData:imageData];
        
    } else
    {
        NSString *encodingUrlString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
        NSString *imageURL = [encodingUrlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        [self sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:image];
    }
}


- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(UIImage *)image
                   completion:(void (^)(CGSize))handler {
    
    if (![url isKindOfClass:[NSString class]] || !url.length) {
        self.image = image;
        return;
    }
    
    if (url.length >= 10 && [[url substringWithRange:NSMakeRange(0, 10)] isEqualToString:@"data:image"])
    {
        NSArray *imageArray = [url componentsSeparatedByString:@","];
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageArray[1] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.image = [UIImage imageWithData:imageData];
        handler(self.image.size);
        
    } else
    {
        NSString *encodingUrlString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
        NSString *imageURL = [encodingUrlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        [self sd_setImageWithURL:[NSURL URLWithString:imageURL]
                placeholderImage:image
                         options:SDWebImageRetryFailed
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
         {
             handler(image.size);
         }];
    }
}




- (void)setImageWithURLString:(NSString *)url
             placeholderImage:(UIImage *)image
              imageCompletion:(void (^)(UIImage *))handler
{
    if (![url isKindOfClass:[NSString class]] || !url.length) {
        self.image = image;
        return;
    }
    
    if (url.length >= 10 && [[url substringWithRange:NSMakeRange(0, 10)] isEqualToString:@"data:image"])
    {
        NSArray *imageArray = [url componentsSeparatedByString:@","];
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageArray[1] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        self.image = [UIImage imageWithData:imageData];
        handler(self.image);
        
    } else
    {
        NSString *encodingUrlString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
        NSString *imageURL = [encodingUrlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        [self sd_setImageWithURL:[NSURL URLWithString:imageURL]
                placeholderImage:image
                         options:SDWebImageRetryFailed
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
         {
             handler(image);
         }];
    }
}




@end
