//
//  NSObject+Parse.m
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/24.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject(parse)
    + (id)parse:(id)json {
        if ([json isKindOfClass:[NSArray class]]) {
            //参数1:数组中的元素类型
            return [NSArray yy_modelArrayWithClass:[self class] json:json];
        }
        if ([json isKindOfClass:[NSDictionary class]]) {
            //YYModel提供的JSON字典转 类对象的方法
            return [self yy_modelWithJSON:json];
        }
        return json;
    }
@end
