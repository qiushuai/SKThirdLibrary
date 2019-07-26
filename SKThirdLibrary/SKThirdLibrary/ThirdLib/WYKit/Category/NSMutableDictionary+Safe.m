//
//  NSMutableDictionary+Safe.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
#import "NSMutableDictionary+Safe.h"

@implementation NSMutableDictionary (Safe)
#pragma mark -------------------------- Init Methods

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换 removeObjectForKey:
        NSString *tmpRemoveStr = @"removeObjectForKey:";
        NSString *tmpSafeRemoveStr = @"safeMutable_removeObjectForKey:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSDictionaryM")
                                     originalSelector:NSSelectorFromString(tmpRemoveStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveStr)];
        
        if (@available(iOS 11.0, *)) {
            NSString *tmpSetObjectSubStr = @"setObject:forKeyedSubscript:";
            NSString *tmpSafeSetObjectSubStr = @"safe_setObject:forKeyedSubscript:";
            
            [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSDictionaryM")
                                             originalSelector:NSSelectorFromString(tmpSetObjectSubStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSetObjectSubStr)];
        }

        
        // 替换 setObject:forKey:
        NSString *tmpSetStr = @"setObject:forKey:";
        NSString *tmpSafeSetRemoveStr = @"safeMutable_setObject:forKey:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSDictionaryM")
                                     originalSelector:NSSelectorFromString(tmpSetStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSetRemoveStr)];
        
    });
    
}

#pragma mark -------------------------- Exchange Methods

/**
 根据akey 移除 对应的 键值对

 @param aKey key
 */
- (void)safeMutable_removeObjectForKey:(id<NSCopying>)aKey {
    if (!aKey) {
        return;
    }
    [self safeMutable_removeObjectForKey:aKey];
}

/**
 将键值对 添加 到 NSMutableDictionary 内

 @param anObject 值
 @param aKey 键
 */
- (void)safeMutable_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    return [self safeMutable_setObject:anObject forKey:aKey];
}

#pragma mark - setObject:forKeyedSubscript:
- (void)safe_setObject:(id)anObject forKeyedSubscript:(id<NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    return [self safe_setObject:anObject forKeyedSubscript:aKey];
}
@end
