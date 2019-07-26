//
//  NSObject+Parse.h
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/24.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Parse) <YYModel>
    + (id)parse:(id)json;
@end

NS_ASSUME_NONNULL_END
