//
//  LLRangeSlider.h
//  EditWindowController
//
//  Created by AnarL on 16/4/14.
//  Copyright © 2016年 AnarL. All rights reserved.
//
#define DRAG_CELL_NOTIFICATION @"dragCell"

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
    LLRangeSliderDirectionHorizontal = 1,
    LLRangeSliderDirectionVertical
} LLRangeSliderDirection;

typedef enum{
    LLRangeSliderCellSideUp = 1,
    LLRangeSliderCellSideDown,
    LLRangeSliderCellSideLeft,
    LLRangeSliderCellSideRight
} LLRangeSliderCellSide;

@interface LLRangeSlider : NSControl

/**
 *  滑块位置
 */
@property (nonatomic)LLRangeSliderCellSide cellSide;
/**
 *  滑动条方向
 */
@property (nonatomic) LLRangeSliderDirection direction;
/**
 *  滑动条最小值(默认值为0.0)
 */
@property (nonatomic) double minValue;
/**
 *  滑动条最大值(默认值为1.0)
 */
@property (nonatomic) double maxValue;
/**
 *  滑动条分段较小值(默认值为0.0)
 */
@property (nonatomic) double smallerValue;
/**
 *  滑动条分段较大值(默认值为1.0)
 */
@property (nonatomic) double biggerValue;

/**
 *  进度值初始值为0.0
 */
@property (nonatomic) float indicatorValue;
/**
 *  滑动块宽度(默认值为20.0)
 */
@property (nonatomic) CGFloat cellWidth;
/**
 *  滑动块高度(默认值为20.0)
 */
@property (nonatomic) CGFloat cellHeight;
/**
 *  进度指示条高度(默认值为10.0)
 */
@property (nonatomic) CGFloat trackThickness;
/**
 *  进度指示条前景色
 */
@property (nonatomic) NSColor * trackTintColor;
/**
 *  进度指示条背景色
 */
@property (nonatomic) NSColor * trackBackgroundColor;
/**
 *  进度条分段高亮颜色
 */
@property (nonatomic) NSColor * trackHighlightTintColor;
/**
 *  滑块前景色
 */
@property (nonatomic) NSColor * cellTintColor;
/**
 *  进度条圆角大小
 */
@property (nonatomic) CGFloat cornerRadius;
/**
 *  是否有分段标志
 */
@property (nonatomic) BOOL hasTrimMark;

/**
 *  判断滑动条是否垂直
 */
- (BOOL)isVertical;
/**
 *  根据值设置滑块位置
 *
 *  @param value 滑块值
 *
 *  @return 滑块位置
 */
- (double)positionForValue:(double)value;
/**
 *  删除分段标志
 */
- (void)removeTrimMark;
/**
 *  添加分段标志
 */
- (void)addTrimMark;

@end
