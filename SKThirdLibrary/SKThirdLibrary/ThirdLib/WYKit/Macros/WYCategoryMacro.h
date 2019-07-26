//
//  WYCategoryMacro.h
//  WYKit
//  博客地址：https://www.wncblog.top
//  GitHub地址：https://github.com/unseim
//  QQ：9137279
//

#ifndef WYCategoryMacro_h
#define WYCategoryMacro_h

// 动态Get方法
#define wy_categoryPropertyGet(property) return objc_getAssociatedObject(self, @#property);
// 动态Set方法
#define wy_categoryPropertySet(property) objc_setAssociatedObject(self,@#property, property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

#ifndef WY_RUNTIME_CLASS
#define WY_RUNTIME_CLASS(_name_) \
@interface WY_RUNTIME_CLASS ## _name_ : NSObject @end \
@implementation WY_RUNTIME_CLASS ## _name_ @end
#endif




#ifndef weakly
#if DEBUG
#if __has_feature(objc_arc)
#define weakly(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakly(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakly(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakly(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongly
#if DEBUG
#if __has_feature(objc_arc)
#define strongly(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongly(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongly(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongly(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif





#pragma mark - 快速实现单例设计模式


/** 单例模式 .h文件的实现 */
#define SingletonH(methodName) + (instancetype)shared##methodName;


/** 单例模式 .m文件的实现 */
#if __has_feature(objc_arc) // 是ARC
#define SingletonM(methodName) \
static id _instace = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (_instace == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
} \
return _instace; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super init]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##methodName \
{ \
return [[self alloc] init]; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
} \
\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
}

#else // 不是ARC

#define SingletonM(methodName) \
static id _instace = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
if (_instace == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super allocWithZone:zone]; \
}); \
} \
return _instace; \
} \
\
- (id)init \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instace = [super init]; \
}); \
return _instace; \
} \
\
+ (instancetype)shared##methodName \
{ \
return [[self alloc] init]; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (id)retain \
{ \
return self; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
} \
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
} \
\
+ (id)mutableCopyWithZone:(struct _NSZone *)zone \
{ \
return _instace; \
}

#endif




#endif /* WYCategoryMacro_h */
