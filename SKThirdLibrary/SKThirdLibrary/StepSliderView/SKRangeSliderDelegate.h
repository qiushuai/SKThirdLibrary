//
//  SKRangeSliderDelegate.h
//  SKThirdLibrary
//
//  Created by 王三坤 on 2019/7/12.
//  Copyright © 2019 王三坤. All rights reserved.
//
#import <Foundation/Foundation.h>
@class SKRangeSlider;
#ifndef SKRangeSliderDelegate_h
#define SKRangeSliderDelegate_h

@protocol SKRangeSliderDelegate <NSObject>

@optional

/**
 * Called when the RangeSlider values are changed
 */
-(void)rangeSlider:(SKRangeSlider *)sender didChangeSelectedMinimumValue:(float)selectedMinimum andMaximumValue:(float)selectedMaximum;

/**
 * Called when the user has finished interacting with the RangeSlider
 */
- (void)didEndTouchesInRangeSlider:(SKRangeSlider *)sender;

/**
 * Called when the user has started interacting with the RangeSlider
 */
- (void)didStartTouchesInRangeSlider:(SKRangeSlider *)sender;

@end

#endif /* SKRangeSliderDelegate_h */
