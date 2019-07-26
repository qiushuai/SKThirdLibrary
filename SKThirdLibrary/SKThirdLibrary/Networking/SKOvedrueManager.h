//
//  SKOvedrueManager.h
//  CSSM_OC
//
//  Created by 王三坤 on 2019/4/24.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKOvedrueManager : NSObject

    /** 初始化方法 */
+ (instancetype)sharedOvedrueManager;
    
    
- (void)showInObject:(id)responseObject;
@end

NS_ASSUME_NONNULL_END
