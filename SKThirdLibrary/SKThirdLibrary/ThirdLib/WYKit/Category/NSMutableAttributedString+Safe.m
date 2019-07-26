//
//  NSMutableAttributedString+Safe.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import "NSObject+Swizzling.h"
#import "NSMutableAttributedString+Safe.h"

@implementation NSMutableAttributedString (Safe)
#pragma mark -------------------------- Init Methods

+ (void)load {
    //只执行一次这个方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 替换 initWithString:
        NSString *tmpStr = @"initWithString:";
        NSString *tmpSafeStr = @"safeMutable_initWithString:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSConcreteMutableAttributedString")
                                         originalSelector:NSSelectorFromString(tmpStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeStr)];
        
        //替换 initWithString:attributes:
        NSString *tmpAttributedStr = @"initWithString:attributes:";
        NSString *tmpSafeAttributedStr  = @"safeMutable_initWithString:attributes:";
        
        [NSObject wy_exchangeInstanceMethodWithSelfClass:NSClassFromString(@"NSConcreteMutableAttributedString")
                                         originalSelector:NSSelectorFromString(tmpAttributedStr)                                     swizzledSelector:NSSelectorFromString(tmpSafeAttributedStr)];
        
    });
}

#pragma mark -------------------------- Exchange Methods

#pragma mark --- initWithString:


- (instancetype)safeMutable_initWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self safeMutable_initWithString:str];
    }
    @catch (NSException *exception) {
    }
    @finally {
        return object;
    }
}



#pragma mark --- initWithString:attributes:


- (instancetype)safeMutable_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self safeMutable_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {

    }
    @finally {
        return object;
    }
}

@end
