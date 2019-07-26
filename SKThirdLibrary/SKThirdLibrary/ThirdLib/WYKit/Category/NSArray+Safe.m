//
//  NSArray+Safe.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <objc/runtime.h>
#import "NSArray+Safe.h"
#import "NSObject+Swizzling.h"

@implementation NSArray (Safe)

#pragma mark -------------------------- Init Methods

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //替换 objectAtIndex
        NSString *tmpStr = @"objectAtIndex:";
        NSString *tmpFirstStr = @"safe_ZeroObjectAtIndex:";
        NSString *tmpThreeStr = @"safe_objectAtIndex:";
        NSString *tmpSecondStr = @"safe_singleObjectAtIndex:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArray0")
                                         originalSelector:NSSelectorFromString(tmpStr)                                     swizzledSelector:NSSelectorFromString(tmpFirstStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSSingleObjectArrayI")
                                         originalSelector:NSSelectorFromString(tmpStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayI")
                                         originalSelector:NSSelectorFromString(tmpStr)                                     swizzledSelector:NSSelectorFromString(tmpThreeStr)];
        
        // 替换 objectAtIndexedSubscript
        
        NSString *tmpSubscriptStr = @"objectAtIndexedSubscript:";
        NSString *tmpSecondSubscriptStr = @"safe_objectAtIndexedSubscript:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayI")
                                         originalSelector:NSSelectorFromString(tmpSubscriptStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondSubscriptStr)];
        
        // 替换 arrayWithObjects:count:
        NSString *tmpFirstArrayWithObjectsStr = @"arrayWithObjects:count:";
        NSString *tmpSecondArrayWithObjectsStr = @"safe_arrayWithObjects:count:";
        
        
        [NSObject wy_exchangeClassMethodWithSelfClass:[self class]
                                      originalSelector:NSSelectorFromString(tmpFirstArrayWithObjectsStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondArrayWithObjectsStr)];
        
        // 替换 objectsAtIndexes
        NSString *tmpFirstObjectsAtIndexesStr = @"objectsAtIndexes:";
        NSString *tmpSecondObjectsAtIndexesStr = @"safe_objectsAtIndexes:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSArray")
                                         originalSelector:NSSelectorFromString(tmpFirstObjectsAtIndexesStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondObjectsAtIndexesStr)];
        
        // 替换 getObjects:range:
       
        NSString *tmpFirstGetObjectsRangeStr = @"getObjects:range:";
        NSString *tmpSecondGetObjectsRangeStr = @"safe_arrayGetObjects:range:";
        NSString *tmpThreeGetObjectsRangeStr = @"safe_singleObjectArrayGetObjects:range:";
        NSString *tmpFourGetObjectsRangeStr = @"safe_arrayIGetObjects:range:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSArray")
                                         originalSelector:NSSelectorFromString(tmpFirstGetObjectsRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSecondGetObjectsRangeStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSSingleObjectArrayI")
                                         originalSelector:NSSelectorFromString(tmpFirstGetObjectsRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpThreeGetObjectsRangeStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSArrayI")
                                         originalSelector:NSSelectorFromString(tmpFirstGetObjectsRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpFourGetObjectsRangeStr)];
       
        
       
        
    });

}




#pragma mark -------------------------- Exchange Method

#pragma mark --- objectAtIndex

/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_objectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_objectAtIndex:index];
}


/**
 取出NSArray 第index个 值 对应 __NSSingleObjectArrayI
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_singleObjectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_singleObjectAtIndex:index];
}

/**
 取出NSArray 第index个 值 对应 __NSArray0
 
 @param index 索引 index
 @return 返回值
 */
- (id)safe_ZeroObjectAtIndex:(NSUInteger)index {
    if (index >= self.count){
        return nil;
    }
    return [self safe_ZeroObjectAtIndex:index];
}

#pragma mark --- objectAtIndexedSubscript
/**
 取出NSArray 第index个 值 对应 __NSArrayI
 
 @param idx 索引 idx
 @return 返回值
 */
- (id)safe_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count){
        return nil;
    }
    return [self safe_objectAtIndexedSubscript:idx];
}



#pragma mark --- objectsAtIndexes

/**
 取出NSArray

 @param indexes 索引范围
 @return 返回数组
 */
- (NSArray *)safe_objectsAtIndexes:(NSIndexSet *)indexes {
    __block BOOL beyondLimit = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > self.count) {
            *stop = YES;
            beyondLimit = YES;
        }
    }];
    if (beyondLimit) {
        return nil;
    }
   return [self safe_objectsAtIndexes:indexes];
}


#pragma mark --- ArrayWithObjects: count:
/**
 初始化方法

 @param objects 数组
 @param cnt 数量
 @return 数组
 */
+ (instancetype)safe_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    @try {
        instance = [self safe_arrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self safe_arrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}


#pragma mark --- getObjects:range:

//NSArray getObjects:range:
- (void)safe_arrayGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    return [self safe_arrayGetObjects:objects range:range];
}

// __NSSingleObjectArrayI safe_singleObjectArrayGetObjects:range:
- (void)safe_singleObjectArrayGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    return [self safe_arrayGetObjects:objects range:range];
}

//__NSArrayI safe_arrayIGetObjects:range:
- (void)safe_arrayIGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    if (range.location > self.count) {
        return;
    }
    
    if (range.length > self.count) {
        return;
    }
    
    if ((range.location + range.length) > self.count) {
        return;
    }
    
    return [self safe_arrayGetObjects:objects range:range];
}

@end
