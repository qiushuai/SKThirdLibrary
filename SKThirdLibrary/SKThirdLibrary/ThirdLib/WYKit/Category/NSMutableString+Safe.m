//
//  NSMutableString+Safe.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
#import "NSMutableString+Safe.h"

@implementation NSMutableString (Safe)

#pragma mark -------------------------- Init Methods

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换  substringFromIndex:
        NSString *tmpSubFromStr = @"substringFromIndex:";
        NSString *tmpSafeSubFromStr = @"safeMutable_substringFromIndex:";
    
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubFromStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubFromStr)];
        
        
        // 替换  substringToIndex:
        NSString *tmpSubToStr = @"substringToIndex:";
        NSString *tmpSafeSubToStr = @"safeMutable_substringToIndex:";
    
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubToStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubToStr)];
        
        
        // 替换  substringWithRange:
        NSString *tmpSubRangeStr = @"substringWithRange:";
        NSString *tmpSafeSubRangeStr = @"safeMutable_substringWithRange:";
    
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpSubRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeSubRangeStr)];
        

        
        // 替换  rangeOfString:options:range:locale:
        NSString *tmpRangeOfStr = @"rangeOfString:options:range:locale:";
        NSString *tmpSafeRangeOfStr = @"safeMutable_rangeOfString:options:range:locale:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpRangeOfStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeRangeOfStr)];
        
        
        // 替换  appendString
        NSString *tmpAppendStr = @"appendString:";
        NSString *tmpSafeAppendStr = @"safeMutable_appendString:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                     originalSelector:NSSelectorFromString(tmpAppendStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeAppendStr)];
        
        

        // 替换  replaceCharactersInRange
        NSString *tmpReplaceCharactersInRangeStr = @"replaceCharactersInRange:withString:";
        NSString *tmpSafeReplaceCharactersInRangeStr = @"safeMutable_replaceCharactersInRange:withString:";
        
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                         originalSelector:NSSelectorFromString(tmpReplaceCharactersInRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeReplaceCharactersInRangeStr)];

        
        //替换 insertString:atIndex:
        NSString *tmpInsertStringStr = @"insertString:atIndex:";
        NSString *tmpSafaInsertStringStr = @"safeMutable_insertString:atIndex:";
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                         originalSelector:NSSelectorFromString(tmpInsertStringStr)                                     swizzledSelector:NSSelectorFromString(tmpSafaInsertStringStr)];
        
        
        
        //替换 deleteCharactersInRange
        NSString *tmpDeleteCharactersInRangeStr = @"deleteCharactersInRange:";
        NSString *tmpSafaDeleteCharactersInRangeStr = @"safeMutable_deleteCharactersInRange:";
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"__NSCFString")
                                         originalSelector:NSSelectorFromString(tmpDeleteCharactersInRangeStr)                                     swizzledSelector:NSSelectorFromString(tmpSafaDeleteCharactersInRangeStr)];
        
        
    });
    
}


#pragma mark -------------------------- Exchange Methods
#pragma mark --- substringFromIndex:
/****************************************  substringFromIndex:  ***********************************/
/**
 从from位置截取字符串 对应 __NSCFString
 
 @param from 截取起始位置
 @return 截取的子字符串
 */
- (NSString *)safeMutable_substringFromIndex:(NSUInteger)from {
    if (from > self.length ) {
        return nil;
    }
    return [self safeMutable_substringFromIndex:from];
}


#pragma mark --- substringToIndex:
/****************************************  substringToIndex:  ***********************************/
/**
 从开始截取到to位置的字符串  对应  __NSCFString
 
 @param to 截取终点位置
 @return 返回截取的字符串
 */
- (NSString *)safeMutable_substringToIndex:(NSUInteger)to {
    if (to > self.length ) {
        return nil;
    }
    return [self safeMutable_substringToIndex:to];
}


#pragma mark --- rangeOfString:options:range:locale:
/*********************************** rangeOfString:options:range:locale:  ***************************/
/**
 搜索指定 字符串  对应  __NSCFString
 
 @param searchString 指定 字符串
 @param mask 比较模式
 @param rangeOfReceiverToSearch 搜索 范围
 @param locale 本地化
 @return 返回搜索到的字符串 范围
 */
- (NSRange)safeMutable_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale {
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
    
    
    return [self safeMutable_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
}


#pragma mark --- substringWithRange:
/*********************************** substringWithRange:  ***************************/
/**
 截取指定范围的字符串  对应  __NSCFString
 
 @param range 指定的范围
 @return 返回截取的字符串
 */
- (NSString *)safeMutable_substringWithRange:(NSRange)range {
    if (range.location > self.length) {
        return nil;
    }
    
    if (range.length > self.length) {
        return nil;
    }
    
    if ((range.location + range.length) > self.length) {
        return nil;
    }
    return [self safeMutable_substringWithRange:range];
}


#pragma mark --- appendString:
/*********************************** appendString:  ***************************/
/**
 追加字符串 对应  __NSCFString
 
 @param aString 追加的字符串
 */
- (void)safeMutable_appendString:(NSString *)aString {
    if (!aString) {
        return;
    }
    return [self safeMutable_appendString:aString];
}

#pragma mark ---  replaceCharactersInRange

- (void)safeMutable_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    if (range.location > self.length) {
        return;
    }
    
    if (range.length > self.length) {
        return;
    }
    
    if ((range.location + range.length) > self.length) {
        return;
    }
    
    if (!aString) {
        return;
    }
    
   return [self safeMutable_replaceCharactersInRange:range withString:aString];
}

#pragma mark ---  insertString:atIndex:

- (void)safeMutable_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if (loc > self.length) {
        return;
    }
   return  [self safeMutable_insertString:aString atIndex:loc];
}


#pragma mark ---   deleteCharactersInRange

- (void)safeMutable_deleteCharactersInRange:(NSRange)range {
    
    if (range.location > self.length) {
        return;
    }
    
    if (range.length > self.length) {
        return;
    }
    
    if ((range.location + range.length) > self.length) {
        return;
    }
    return [self safeMutable_deleteCharactersInRange:range];
}


@end
