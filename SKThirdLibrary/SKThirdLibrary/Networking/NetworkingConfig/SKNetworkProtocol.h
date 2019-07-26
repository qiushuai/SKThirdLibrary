//
//  SKNetworkProtocol.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#ifndef SKNetworkProtocol_h
#define SKNetworkProtocol_h

#import <Foundation/Foundation.h>

@class SKNetworkRequestModel;

@protocol SKNetworkProtocol <NSObject>

@required

/**
 *  This method is used to deal with the request model when the corresponding request is finished
 *
 *  @param requestModel      request model of a network request
 *
 */
- (void)handleRequesFinished:(SKNetworkRequestModel *)requestModel;



@end

#endif /* SKNetworkProtocol_h */
