//
//  SKLabel.h
//  CSSM_OC
//
//  Created by 王三坤 on 2019/5/5.
//  Copyright © 2019 王三坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface SKLabel : UILabel{
    @private VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;
@end

