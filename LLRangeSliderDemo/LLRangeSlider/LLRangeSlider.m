//
//  LLRangeSlider.m
//  EditWindowController
//
//  Created by AnarL on 16/4/14.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "LLRangeSlider.h"
#import "LLRangeSliderCellLayer.h"
#import "LLRangeSliderTrackLayer.h"

@interface LLRangeSlider()
/**
 *  上一次鼠标的位置
 */
@property CGPoint previousLocation;

/**
 *  进度条层
 */
@property LLRangeSliderTrackLayer * trackLayer;
/**
 *  较大值滑块层
 */
@property LLRangeSliderCellLayer * biggerCellLayer;
/**
 *  较小值滑块层
 */
@property LLRangeSliderCellLayer * smallerCellLayer;
/**
 *  进度指示滑块层
 */
@property LLRangeSliderCellLayer * indicatorCellLayer;

@end

@implementation LLRangeSlider

- (instancetype)init
{
    if (self = [super initWithFrame:NSZeroRect]) {
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    self.wantsLayer = YES;
    if (self) {
        [self setDefaultValues];
        
        _trackLayer = [[LLRangeSliderTrackLayer alloc] init];
        _trackLayer.rangeSlider = self;
        [_trackLayer setContentsScale:[[NSScreen mainScreen] backingScaleFactor]];
        [_layer addSublayer:_trackLayer];
        
        _smallerCellLayer = [[LLRangeSliderCellLayer alloc] init];
        _smallerCellLayer.rangeSlider = self;
        _smallerCellLayer.cellPosition = LLRangeSliderCellPositionSmaller;
        _smallerCellLayer.contentsScale = [[NSScreen mainScreen] backingScaleFactor];
        [_layer addSublayer:_smallerCellLayer];
        
        _biggerCellLayer = [[LLRangeSliderCellLayer alloc] init];
        _biggerCellLayer.rangeSlider = self;
        _biggerCellLayer.cellPosition = LLRangeSliderCellPositionBigger;
        _biggerCellLayer.contentsScale = [[NSScreen mainScreen] backingScaleFactor];
        [_layer addSublayer:_biggerCellLayer];
        
        _indicatorCellLayer = [[LLRangeSliderCellLayer alloc] init];
        _indicatorCellLayer.rangeSlider = self;
        _indicatorCellLayer.cellPosition = LLRangeSliderCellPositionIndicator;
        _indicatorCellLayer.contentsScale = [[NSScreen mainScreen] backingScaleFactor];
        [_layer addSublayer:_indicatorCellLayer];

        [self updateLayerFrames];
    }
    return self;
}

/**
 *  设置成员属性默认值
 */
- (void)setDefaultValues
{
    _minValue = 0.0;
    _maxValue = 1.0;
    _smallerValue = 0.0;
    _biggerValue = 1.0;
    _cellWidth = 20.0;
    _cellHeight = 20.0;
    _trackThickness = 10.0;
    _indicatorValue = 0.0;
    _trackTintColor = [NSColor colorWithRed:(181 / 255.0) green:(255 / 255.0) blue:(73 / 255.0) alpha:1.00];;
    _trackHighlightTintColor = [NSColor colorWithRed:(255 / 255.0) green:(14 / 255.0) blue:(0 / 255.0) alpha:1.00];;
    _cellTintColor = [NSColor whiteColor];
    _cornerRadius = 1.0;
    _cellSide = LLRangeSliderCellSideUp;
    _direction = LLRangeSliderDirectionHorizontal;
    _trackBackgroundColor = [NSColor blackColor];
    _hasTrimMark = NO;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

#pragma mark -Override
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)theEvent
{
    NSPoint location = [theEvent locationInWindow];
    _previousLocation = [self convertPoint:location fromView:nil];
    
    if (_hasTrimMark) {
        if (CGRectContainsPoint(_smallerCellLayer.frame, _previousLocation)) {
            [_smallerCellLayer setHighlighted:YES];
        } else if(CGRectContainsPoint(_biggerCellLayer.frame, _previousLocation)) {
            [_biggerCellLayer setHighlighted:YES];
        }
    }
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    NSPoint location = [theEvent locationInWindow];
    NSPoint pointInView = [self convertPoint:location fromView:nil];
    
    double deltaLocation = [self isVertical] ? pointInView.y - _previousLocation.y : pointInView.x - _previousLocation.x;
    double deltaValue = (self.maxValue - self.minValue) * deltaLocation / ([self isVertical] ? (double)(self.bounds.size.height - self.cellHeight) : (double)(self.bounds.size.width - self.cellWidth));
    
    _previousLocation = pointInView;
    
    //Update Values
    if (self.smallerCellLayer.highlighted) {
        _smallerValue += deltaValue;
        _smallerValue = [self boundValue:_smallerValue toSmallerValue:_minValue biggerValue:_biggerValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:DRAG_CELL_NOTIFICATION object:_smallerCellLayer];
    } else if(_biggerCellLayer.highlighted) {
        _biggerValue += deltaValue;
        _biggerValue = [self boundValue:_biggerValue toSmallerValue:_smallerValue biggerValue:_maxValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:DRAG_CELL_NOTIFICATION object:_biggerCellLayer];
    }
    [self updateLayerFrames];
    [NSApp sendAction:self.action to:self.target from:self];
}

- (void)mouseUp:(NSEvent *)theEvent
{
    _smallerCellLayer.highlighted = NO;
    _biggerCellLayer.highlighted = NO;
    
    [self updateLayerFrames];
}

- (BOOL)isVertical
{
    return self.direction == LLRangeSliderDirectionVertical ? YES : NO;
}
#pragma mark -UpdateLayerFrames
- (void)updateLayerFrames
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CGFloat smallerCellCenter = (CGFloat)[self positionForValue:_smallerValue];
    CGFloat biggerCellCenter = (CGFloat)[self positionForValue:_biggerValue];
//    CGFloat indicatorCellCenter = (CGFloat)[self positionForValue:_indicatorValue];
    
    if ([self isVertical]) {
        _trackLayer.frame = CGRectMake(self.frame.size.width - self.trackThickness, self.cellHeight, self.trackThickness, self.bounds.size.height - 2 * self.cellHeight);
        
        _smallerCellLayer.frame = CGRectMake(_trackLayer.frame.origin.x - _cellWidth, smallerCellCenter, _cellWidth, _cellHeight);
        _biggerCellLayer.frame = CGRectMake(_trackLayer.frame.origin.x - _cellWidth, biggerCellCenter + _cellHeight, _cellWidth, _cellHeight);
//        _indicatorCellLayer.frame = CGRectMake(_trackLayer.frame.origin.x - _cellWidth, indicatorCellCenter, _cellWidth, _cellHeight);
        
        if (self.cellSide == LLRangeSliderCellSideRight) {
            CGRect oldFrame = _trackLayer.frame;
            oldFrame.origin.x = 0;
            _trackLayer.frame = oldFrame;
            
            oldFrame = CGRectZero;
            
            oldFrame = _smallerCellLayer.frame;
            oldFrame.origin.x = _trackLayer.frame.size.width;
            _smallerCellLayer.frame = oldFrame;
            
            oldFrame = CGRectZero;
            
            oldFrame = _biggerCellLayer.frame;
            oldFrame.origin.x = _trackLayer.frame.size.width;
            _biggerCellLayer.frame = oldFrame;
            
            oldFrame = CGRectZero;
            
//            oldFrame = _indicatorCellLayer.frame;
//            oldFrame.origin.x = _trackLayer.frame.size.width;
//            _indicatorCellLayer.frame = oldFrame;
//            
//            oldFrame = CGRectZero;
        }
    } else {
    
        _trackLayer.frame = CGRectMake(self.cellWidth, 0, self.bounds.size.width - 2 * _cellWidth, self.trackThickness);
        
        _smallerCellLayer.frame = CGRectMake(smallerCellCenter, self.trackThickness, _cellWidth, _cellHeight);
        _biggerCellLayer.frame = CGRectMake(biggerCellCenter + _cellWidth, self.trackThickness, _cellWidth, _cellWidth);
//        _indicatorCellLayer.frame = CGRectMake(indicatorCellCenter, self.trackThickness, _cellWidth, _cellHeight);
        
        if (_cellSide == LLRangeSliderCellSideDown) {
            CGRect oldFrame = _trackLayer.frame;
            oldFrame.origin.y = self.frame.size.height - self.trackThickness;
            _trackLayer.frame = oldFrame;
            
            oldFrame = CGRectZero;
            
            oldFrame = _smallerCellLayer.frame;
            oldFrame.origin.y = _trackLayer.frame.origin.y - _cellHeight;
            _smallerCellLayer.frame = oldFrame;
            
            oldFrame = CGRectZero;
            
            oldFrame = _biggerCellLayer.frame;
            oldFrame.origin.y = _trackLayer.frame.origin.y - _cellHeight;
            _biggerCellLayer.frame = oldFrame;
            
            oldFrame = CGRectZero;
            
//            oldFrame = _indicatorCellLayer.frame;
//            oldFrame.origin.y = _trackLayer.frame.origin.y - _cellHeight;
//            _indicatorCellLayer.frame = oldFrame;
//            
//            oldFrame = CGRectZero;
        }
    }
    
    [_trackLayer setNeedsDisplay];
    [_smallerCellLayer setNeedsDisplay];
    [_biggerCellLayer setNeedsDisplay];
    [_indicatorCellLayer setNeedsDisplay];
    
    [CATransaction commit];
}

- (double)positionForValue:(double)value
{
    if ([self isVertical]) {
        return (double)((self.bounds.size.height - 2 * _cellHeight)  * (value - _minValue) / (_maxValue - _minValue));
    } else {
        return (double)((self.bounds.size.width - 2 * _cellWidth) * (value - _minValue) / (_maxValue - _minValue));
    }
}
- (double)boundValue:(double)value toSmallerValue:(double)smallerValue biggerValue:(double)biggerValue
{
    return MIN(MAX(value, smallerValue), biggerValue);
}

#pragma mark -Setters
- (void)setDirection:(LLRangeSliderDirection)direction
{
    _direction = direction;
    if (_direction == LLRangeSliderDirectionVertical) {
        if (_cellSide != LLRangeSliderCellSideLeft || _cellSide != LLRangeSliderCellSideRight) {
            _cellSide = LLRangeSliderCellSideLeft;
        }
    } else {
        if (_cellSide != LLRangeSliderCellSideUp || _cellSide != LLRangeSliderCellSideDown) {
            _cellSide = LLRangeSliderCellSideUp;
        }
    }
    [self updateLayerFrames];
}

- (void)setCellSide:(LLRangeSliderCellSide)cellSide
{
    _cellSide = cellSide;
    [self updateLayerFrames];
}

- (void)setMinValue:(double)minValue
{
    _minValue = minValue;
    [self updateLayerFrames];
}

- (void)setMaxValue:(double)maxValue
{
    _maxValue = maxValue;
    [self updateLayerFrames];
}

- (void)setSmallerValue:(double)smallerValue
{
    _smallerValue = smallerValue;
    [self updateLayerFrames];
}

- (void)setBiggerValue:(double)biggerValue
{
    _biggerValue = biggerValue;
    [self updateLayerFrames];
}

- (void)setCellHeight:(CGFloat)cellHeight
{
    _cellHeight = cellHeight;
    [self updateLayerFrames];
}

- (void)setFrame:(NSRect)frame
{
    _frame = frame;
    [self updateLayerFrames];
}

-(void)setCellWidth:(CGFloat)cellWidth
{
    _cellWidth = cellWidth;
    [self updateLayerFrames];
}

- (void)setTrackThickness:(CGFloat)trackThickness
{
    _trackThickness = trackThickness;
    [self updateLayerFrames];
}

- (void)setTrackHighlightTintColor:(NSColor *)trackHighlightTintColor
{
    _trackHighlightTintColor = trackHighlightTintColor;
    [_trackLayer setNeedsDisplay];
}

- (void)setCellTintColor:(NSColor *)cellTintColor
{
    _cellTintColor = cellTintColor;
    [_smallerCellLayer setNeedsDisplay];
    [_biggerCellLayer setNeedsDisplay];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [_trackLayer setNeedsDisplay];
}

- (void)setIndicatorValue:(float)indicatorValue
{
    _indicatorValue = indicatorValue;
    [self updateLayerFrames];
}

- (void)setTrackBackgroundColor:(NSColor *)trackBackgroundColor
{
    _trackBackgroundColor = trackBackgroundColor;
    [self updateLayerFrames];
}

#pragma mark -Add/Remove Trim mark
- (void)removeTrimMark
{
    [_smallerCellLayer removeFromSuperlayer];
    [_biggerCellLayer removeFromSuperlayer];
    _hasTrimMark = NO;
}

- (void)addTrimMark
{
    [_layer addSublayer:_smallerCellLayer];
    [_layer addSublayer:_biggerCellLayer];
    _hasTrimMark = YES;
}

@end
