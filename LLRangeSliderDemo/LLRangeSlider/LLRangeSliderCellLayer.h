//
//  LLRangeSliderCellLayer.h
//  EditWindowController
//
//  Created by AnarL on 16/4/14.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef enum{
    LLRangeSliderCellPositionSmaller = 1,
    LLRangeSliderCellPositionBigger,
    LLRangeSliderCellPositionIndicator
} LLRangeSliderCellPosition;

@class LLRangeSlider;
@interface LLRangeSliderCellLayer : CALayer

/**
 *  是否选中滑块
 */
@property (nonatomic) BOOL highlighted;
/**
 *  滑动条
 */
@property (nonatomic, assign) LLRangeSlider * rangeSlider;
/**
 *  滑块位置
 */
@property (nonatomic) LLRangeSliderCellPosition cellPosition;

@end
