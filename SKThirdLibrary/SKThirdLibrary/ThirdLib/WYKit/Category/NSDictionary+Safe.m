//
//  NSDictionary+Safe.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "NSDictionary+Safe.h"
#import "NSObject+Swizzling.h"

@implementation NSDictionary (Safe)
#pragma mark -------------------------- Init Methods

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换 removeObjectForKey:
        NSString *tmpRemoveStr = @"dictionaryWithObjects:forKeys:count:";
        NSString *tmpSafeRemoveStr = @"safe_dictionaryWithObjects:forKeys:count:";
        
        [NSObject wy_exchangeClassMethodWithSelfClass:[self class]
                                         originalSelector:NSSelectorFromString(tmpRemoveStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveStr)];
        
        
        [NSObject wy_exchangeClassMethodWithSelfClass:[self class]
                                originalSelector:@selector(initWithObjects:forKeys:count:) swizzledSelector:@selector(nilSafe_initWithObjects:forKeys:count:)];

        [NSObject wy_exchangeClassMethodWithSelfClass:[self class]
                           originalSelector:@selector(dictionaryWithObjects:forKeys:count:) swizzledSelector:@selector(nilSafe_dictionaryWithObjects:forKeys:count:)];
        
    
        
    });
    
}


#pragma mark -------------------------- Exchange Methods

+ (instancetype)nilSafe_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self nilSafe_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)nilSafe_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self nilSafe_initWithObjects:safeObjects forKeys:safeKeys count:j];
}



+ (instancetype)safe_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    id instance = nil;
    
    @try {
        instance = [self safe_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {

        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self safe_dictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

@end


#pragma mark 设置可变字典的崩溃处理
@implementation NSMutableDictionary (NilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject wy_exchangeClassMethodWithSelfClass:[self class]
                                     originalSelector:@selector(setObject:forKey:) swizzledSelector:@selector(nilSafe_setObject:forKey:)];
        
        [NSObject wy_exchangeClassMethodWithSelfClass:[self class]
                                     originalSelector:@selector(setObject:forKeyedSubscript:) swizzledSelector:@selector(nilSafe_setObject:forKeyedSubscript:)];
    });
}

- (void)nilSafe_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    if (!aKey || !anObject) {
        return;
    }
    [self nilSafe_setObject:anObject forKey:aKey];
}

- (void)nilSafe_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key || !obj) {
        return;
        
    }
    [self nilSafe_setObject:obj forKeyedSubscript:key];
}

@end
