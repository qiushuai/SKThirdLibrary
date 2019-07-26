//
//  NSMutableArray+Safe.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
#import "NSMutableArray+Safe.h"


@implementation NSMutableArray (Safe)

#pragma mark -------------------------- Init Methods

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换 objectAtIndex:
        NSString *tmpGetStr = @"objectAtIndex:";
        NSString *tmpSafeGetStr = @"safeMutable_objectAtIndex:";
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpGetStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeGetStr)];
        
        //替换 removeObjectsInRange:
        NSString *tmpRemoveStr = @"removeObjectsInRange:";
        NSString *tmpSafeRemoveStr = @"safeMutable_removeObjectsInRange:";
        

        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpRemoveStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveStr)];
        
        
        //替换 insertObject:atIndex:
        NSString *tmpInsertStr = @"insertObject:atIndex:";
        NSString *tmpSafeInsertStr = @"safeMutable_insertObject:atIndex:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpInsertStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeInsertStr)];
        
        //替换 removeObject:inRange:
        NSString *tmpRemoveRangeStr = @"removeObject:inRange:";
        NSString *tmpSafeRemoveRangeStr = @"safeMutable_removeObject:inRange:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpRemoveRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRemoveRangeStr)];
        
        
        // 替换 objectAtIndexedSubscript
        
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpSecondSubscriptStr = @"safeMutable_objectAtIndexedSubscript:";
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                     originalSelector:NSSelectorFromString(tmpSubscriptStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondSubscriptStr)];
        
        // 替换 getObjects:range:
        NSString *tmpFirstGetObjectsRangeStr = @"getObjects:range:";
        NSString *tmpSecondGetObjectsRangeStr = @"safeMutable_getObjects:range:";
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                         originalSelector:NSSelectorFromString(tmpFirstGetObjectsRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondGetObjectsRangeStr)];
        
        // 替换 setObject:atIndexedSubscript:
        NSString *tmpFirstSetObjectAtIndexedSubscriptStr = @"setObject:atIndexedSubscript:";
        NSString *tmpSecondSetObjectAtIndexedSubscriptStr = @"safe_setObject:atIndexedSubscript:";
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayM")
                                         originalSelector:NSSelectorFromString(tmpFirstSetObjectAtIndexedSubscriptStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondSetObjectAtIndexedSubscriptStr)];
    });
    
}

#pragma mark -------------------------- Exchange Methods

/**
 取出NSArray 第index个 值
 
 @param index 索引 index
 @return 返回值
 */
- (id)safeMutable_objectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safeMutable_objectAtIndex:index];
}

/**
 NSMutableArray 移除 索引 index 对应的 值
 
 @param range 移除 范围
 */
- (void)safeMutable_removeObjectsInRange:(NSRange)range {

    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
     return [self safeMutable_removeObjectsInRange:range];
}


/**
 在range范围内， 移除掉anObject

 @param anObject 移除的anObject
 @param range 范围
 */
- (void)safeMutable_removeObject:(id)anObject inRange:(NSRange)range {
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    if (!anObject){
        return;
    }

    
    return [self safeMutable_removeObject:anObject inRange:range];

}

/**
 NSMutableArray 插入 新值 到 索引index 指定位置
 
 @param anObject 新值
 @param index 索引 index
 */
- (void)safeMutable_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
            return;
    }
    
    if (!anObject){
        return;
    }
    
    [self safeMutable_insertObject:anObject atIndex:index];
}


/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param idx 索引 idx
 @return 返回值
 */
- (id)safeMutable_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count){
        return nil;
    }
    return [self safeMutable_objectAtIndexedSubscript:idx];
}


/**
 获取range范围数组并赋值给objects
 
 @param objects objects
 @param range 范围
 */
- (void)safeMutable_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    return [self safeMutable_getObjects:objects range:range];
}


//=================================================================
//                    array set object at index
//=================================================================
#pragma mark - get object from array


- (void)safe_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    
    if (idx >= self.count) {
        return;
    }
    
    if (!obj) {
        return;
    }
    
    return [self safe_setObject:obj atIndexedSubscript:idx];
}

@end
