//
//  NSObject+Swizzling.m
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSObject (Swizzling)

/** 获取属性列表 */
+ (void)getPropertyList {
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"propertyList = %@",[NSString stringWithUTF8String:propertyName]);
    }
}

/** 方法列表 */
+ (void)getMethodList {
    unsigned int count;
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method = %@",NSStringFromSelector(method_getName(method)));
    }
}

/** 成员列表 */
+ (void)getIvarList {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar var = ivarList[i];
        const char *varName = ivar_getName(var);
        NSLog(@"var = %@",[NSString stringWithUTF8String:varName]);
    }
    
}

/** 协议列表 */
+ (void)getProtocolList {
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Protocol *pro = protocolList[i];
        const char *proName = protocol_getName(pro);
        NSLog(@"proName = %@",[NSString stringWithUTF8String:proName]);
    }
}





#pragma mark -------------------------- Public Methods
+ (void)wy_exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(selfClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(selfClass, swizzledSelector);
    BOOL didAddMethod = class_addMethod(selfClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(selfClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


+ (void)wy_exchangeClassMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getClassMethod(selfClass, originalSelector);
    Method swizzledMethod = class_getClassMethod(selfClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end
