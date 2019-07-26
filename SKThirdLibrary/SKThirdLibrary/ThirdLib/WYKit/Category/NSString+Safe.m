//
//  NSString+Safe.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <objc/runtime.h>
#import "NSString+Safe.h"
#import "NSObject+Swizzling.h"

@implementation NSString (Safe)

#pragma mark -------------------------- Init Methods

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换 substringFromIndex:
        NSString *tmpSubFromStr = @"substringFromIndex:";
        NSString *tmpSafeSubFromStr = @"safe_substringFromIndex:";
        NSString *tmpSafePointSubFromStr = @"safePoint_substringFromIndex:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                     originalSelector:NSSelectorFromString(tmpSubFromStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubFromStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSTaggedPointerString")
                                     originalSelector:NSSelectorFromString(tmpSubFromStr)                                     swizzledSelector:NSSelectorFromString(tmpSafePointSubFromStr)];
        

        
        
        // 替换 substringToIndex:
        NSString *tmpSubToStr = @"substringToIndex:";
        NSString *tmpSafeSubToStr = @"safe_substringToIndex:";
        NSString *tmpSafePointSubToStr = @"safePoint_substringToIndex:";
        
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                     originalSelector:NSSelectorFromString(tmpSubToStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubToStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSTaggedPointerString")
                                     originalSelector:NSSelectorFromString(tmpSubToStr)                                     swizzledSelector:NSSelectorFromString(tmpSafePointSubToStr)];
        

        
        
        // 替换 substringWithRange:
        NSString *tmpSubRangeStr = @"substringWithRange:";
        NSString *tmpSafeSubRangeStr = @"safe_substringWithRange:";
        NSString *tmpSafePointSubRangeStr = @"safePoint_substringWithRange:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                     originalSelector:NSSelectorFromString(tmpSubRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubRangeStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSTaggedPointerString")
                                     originalSelector:NSSelectorFromString(tmpSubRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafePointSubRangeStr)];
        
        
        
        // 替换 rangeOfString:options:range:locale:
        NSString *tmpRangeOfStr = @"rangeOfString:options:range:locale:";
        NSString *tmpSafeRangeOfStr = @"safe_rangeOfString:options:range:locale:";
        NSString *tmpSafePointRangeOfStr = @"safePoint_rangeOfString:options:range:locale:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                     originalSelector:NSSelectorFromString(tmpRangeOfStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRangeOfStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSTaggedPointerString")
                                     originalSelector:NSSelectorFromString(tmpRangeOfStr)                                     swizzledSelector:NSSelectorFromString(tmpSafePointRangeOfStr)];
        
        
        
        // 替换 characterAtIndex:
        NSString *tmpCharacterAtIndexStr = @"characterAtIndex:";
        NSString *tmpSafeCharacterAtIndexStr = @"safe_characterAtIndex:";
        NSString *tmpSafePointCharacterAtIndexStr = @"safePoint_characterAtIndex:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                         originalSelector:NSSelectorFromString(tmpCharacterAtIndexStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeCharacterAtIndexStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSTaggedPointerString")
                                         originalSelector:NSSelectorFromString(tmpCharacterAtIndexStr)                                     swizzledSelector:NSSelectorFromString(tmpSafePointCharacterAtIndexStr)];
        
        
        //替换 stringByReplacingOccurrencesOfString:withString:options:range:
        
        NSString *tmpStringByReplacingOccurrencesOfStringRangeStr = @"stringByReplacingOccurrencesOfString:withString:options:range:";
        NSString *tmpSafeStringByReplacingOccurrencesOfStringRangeStr = @"safe_stringByReplacingOccurrencesOfString:withString:options:range:";
        NSString *tmpSafePointStringByReplacingOccurrencesOfStringRangeStr  = @"safePoint_stringByReplacingOccurrencesOfString:withString:options:range:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                         originalSelector:NSSelectorFromString(tmpStringByReplacingOccurrencesOfStringRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeStringByReplacingOccurrencesOfStringRangeStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSTaggedPointerString")
                                         originalSelector:NSSelectorFromString(tmpStringByReplacingOccurrencesOfStringRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafePointStringByReplacingOccurrencesOfStringRangeStr)];
        
        
        // 替换 stringByReplacingCharactersInRange:withString:
        
        NSString *tmpStringByReplacingCharactersInRangeStr = @"stringByReplacingCharactersInRange:withString:";
        NSString *tmpSafeStringByReplacingCharactersInRangeStr = @"safe_stringByReplacingCharactersInRange:withString:";
        NSString *tmpSafePointStringByReplacingCharactersInRangeStr  = @"safePoint_stringByReplacingCharactersInRange:withString:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFConstantString")
                                         originalSelector:NSSelectorFromString(tmpStringByReplacingCharactersInRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeStringByReplacingCharactersInRangeStr)];
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSTaggedPointerString")
                                         originalSelector:NSSelectorFromString(tmpStringByReplacingCharactersInRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafePointStringByReplacingCharactersInRangeStr)];
        
    });
}

#pragma mark -------------------------- Exchange Methods

#pragma mark ---- substringFromIndex
/****************************************  substringFromIndex:  ***********************************/
/**
 从from位置截取字符串 对应 __NSCFConstantString
 
 @param from 截取起始位置
 @return 截取的子字符串
 */
- (NSString *)safe_substringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        return nil;
    }
    return [self safe_substringFromIndex:from];
}
/**
 从from位置截取字符串 对应  NSTaggedPointerString
 
 @param from 截取起始位置
 @return 截取的子字符串
 */
- (NSString *)safePoint_substringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        return nil;
    }
    return [self safePoint_substringFromIndex:from];
}

#pragma mark ---- substringToIndex
/****************************************  substringFromIndex:  ***********************************/
/**
 从开始截取到to位置的字符串  对应  __NSCFConstantString
 
 @param to 截取终点位置
 @return 返回截取的字符串
 */
- (NSString *)safe_substringToIndex:(NSUInteger)to {
    if (to > self.length ) {
        return nil;
    }
    return [self safe_substringToIndex:to];
}

/**
 从开始截取到to位置的字符串  对应  NSTaggedPointerString
 
 @param to 截取终点位置
 @return 返回截取的字符串
 */
- (NSString *)safePoint_substringToIndex:(NSUInteger)to {
    if (to > self.length ) {
        return nil;
    }
    return [self safePoint_substringToIndex:to];
}


#pragma mark ---- rangeOfString:options:range:locale:
/*********************************** rangeOfString:options:range:locale:  ***************************/
/**
 搜索指定 字符串  对应  __NSCFConstantString
 
 @param searchString 指定 字符串
 @param mask 比较模式
 @param rangeOfReceiverToSearch 搜索 范围
 @param locale 本地化
 @return 返回搜索到的字符串 范围
 */
- (NSRange)safe_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale {
    if (!searchString) {
        searchString = self;
    }
    
    if (rangeOfReceiverToSearch.location > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if (rangeOfReceiverToSearch.length > self.length) {
         rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if ((rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length) > self.length) {
         rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }

    
    return [self safe_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}


/**
 搜索指定 字符串  对应  NSTaggedPointerString

 @param searchString 指定 字符串
 @param mask 比较模式
 @param rangeOfReceiverToSearch 搜索 范围
 @param locale 本地化
 @return 返回搜索到的字符串 范围
 */
- (NSRange)safePoint_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale {
    if (!searchString) {
        searchString = self;
    }
    
    if (rangeOfReceiverToSearch.location > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if (rangeOfReceiverToSearch.length > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }
    
    if ((rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length) > self.length) {
        rangeOfReceiverToSearch = NSMakeRange(0, self.length);
    }

    
    return [self safePoint_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}

#pragma mark ---- substringWithRange:
/*********************************** substringWithRange:  ***************************/
/**
 截取指定范围的字符串  对应  __NSCFConstantString
 
 @param range 指定的范围
 @return 返回截取的字符串
 */
- (NSString *)safe_substringWithRange:(NSRange)range {
    if (range.location > self.length) {
        return nil;
    }
    
    if (range.length > self.length) {
        return nil;
    }
    
    if ((range.location + range.length) > self.length) {
        return nil;
    }
    return [self safe_substringWithRange:range];
}

/**
 截取指定范围的字符串 对应  NSTaggedPointerString
 
 @param range 指定的范围
 @return 返回截取的字符串
 */
- (NSString *)safePoint_substringWithRange:(NSRange)range {
    if (range.location > self.length) {
        return nil;
    }
    
    if (range.length > self.length) {
        return nil;
    }
    
    if ((range.location + range.length) > self.length) {
        return nil;
    }
    return [self safePoint_substringWithRange:range];
}

#pragma mark ---- characterAtIndex

- (unichar)safe_characterAtIndex:(NSUInteger)index {
    unichar characteristic = 0;
    if (index < self.length) {
        characteristic = [self safe_characterAtIndex:index];
    }
    
    return characteristic;
};

- (unichar)safePoint_characterAtIndex:(NSUInteger)index {
    unichar characteristic = 0;
    if (index < self.length) {
        characteristic = [self safePoint_characterAtIndex:index];
    }

    return characteristic;
};


#pragma mark - stringByReplacingOccurrencesOfString:withString:options:range:

- (NSString *)safe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self safe_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

- (NSString *)safePoint_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self safePoint_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


//=================================================================
//       stringByReplacingCharactersInRange:withString:
//=================================================================
#pragma mark - stringByReplacingCharactersInRange:withString:

- (NSString *)safe_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self safe_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

- (NSString *)safePoint_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self safePoint_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}
@end
