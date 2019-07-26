//
//  NSObject+AZSafeArea.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define AZ_HAS_SAFEAREA [self az_hasSafeArea]

@interface NSObject (AZSafeArea)

/** 判断圆角（SafeArea） */
- (BOOL)az_hasSafeArea;

@end
