//
//  NSObject+Swizzling.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)


/** 获取属性列表 */
+ (void)getPropertyList;

/** 方法列表 */
+ (void)getMethodList;

/** 成员列表 */
+ (void)getIvarList;

/** 协议列表 */
+ (void)getProtocolList;



/**
 先判断是否添加方法是否成功，如果成功取代原方法，否则交换实例方法

 @param selfClass 类
 @param originalSelector 方法
 @param swizzledSelector 交换方法
 */
+ (void)wy_exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;

/**
 直接 类方法 交换

 @param selfClass 类
 @param originalSelector 方法
 @param swizzledSelector 交换方法
 */
+ (void)wy_exchangeClassMethodWithSelfClass:(Class)selfClass
                            originalSelector:(SEL)originalSelector
                            swizzledSelector:(SEL)swizzledSelector;
@end
