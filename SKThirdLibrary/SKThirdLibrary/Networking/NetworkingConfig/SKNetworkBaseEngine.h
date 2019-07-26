//
//  SKNetworkBaseEngine.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/26.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SKNetworkRequestModel.h"


@interface SKNetworkBaseEngine : NSObject


/**
 *  This method is used to add customed headers, for subclass to override
 */
- (void)addCustomHeaders;



/**
 *  This method is used to add default parameters with custom parameters, for subclass to override
 *
 *  @param parameters        custom parameters
 *
 */
- (id)addDefaultParametersWithCustomParameters:(id)parameters;




/**
 *  This method is used to execute some operation with the request model when the corresponding request succeed, for subclass to override
 *
 *  @param requestModel      request model of a network request
 *
 */
- (void)requestDidSucceedWithRequestModel:(SKNetworkRequestModel *)requestModel;

@end
