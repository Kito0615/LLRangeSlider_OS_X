//
//  LLRangeSliderTrackLayer.h
//  EditWindowController
//
//  Created by AnarL on 16/4/14.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class LLRangeSlider;

@interface LLRangeSliderTrackLayer : CALayer
/**
 *  当前滑动条
 */
@property (assign) LLRangeSlider * rangeSlider;

@end
