//
//  LLRangeSliderTrackLayer.m
//  EditWindowController
//
//  Created by AnarL on 16/4/14.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "LLRangeSliderTrackLayer.h"
#import "LLRangeSlider.h"
#import "NSBezierPath+TransformToCGPath.h"

@implementation LLRangeSliderTrackLayer

/**
 *  重写父类方法，画出进度条
 */
- (void)drawInContext:(CGContextRef)ctx
{
    if (_rangeSlider) {
        CGFloat cornerRadius = ([_rangeSlider isVertical] ? self.bounds.size.width : self.bounds.size.height) * _rangeSlider.cornerRadius / 2.0;
        NSBezierPath * path = [NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:cornerRadius yRadius:cornerRadius];
        
        CGContextAddPath(ctx, [path transformToCGPath]);
        
        CGContextSetFillColorWithColor(ctx, _rangeSlider.trackTintColor.CGColor);
        CGContextFillPath(ctx);
        
        CGContextSetFillColorWithColor(ctx, _rangeSlider.trackHighlightTintColor.CGColor);
        
        if ([_rangeSlider hasTrimMark]) {
            CGFloat smallerValuePosition = [_rangeSlider positionForValue:_rangeSlider.smallerValue];
            CGFloat biggerValuePosition = [_rangeSlider positionForValue:_rangeSlider.biggerValue];
            
            CGRect rect = CGRectZero;
            if ([_rangeSlider isVertical]) {
                rect = CGRectMake(0.0, smallerValuePosition, self.bounds.size.width, biggerValuePosition - smallerValuePosition);
            } else {
                rect = CGRectMake(smallerValuePosition, 0.0, biggerValuePosition - smallerValuePosition, self.bounds.size.height);
            }
            
            NSBezierPath * hightlightPath = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:cornerRadius yRadius:cornerRadius];
            
            CGContextAddPath(ctx, [hightlightPath transformToCGPath]);
            CGContextFillPath(ctx);
        } else {
            CGContextSetFillColorWithColor(ctx, _rangeSlider.trackBackgroundColor.CGColor);
            CGContextFillPath(ctx);
        }
#if 0
        CGFloat indicatorValuePosition = [_rangeSlider positionForValue:_rangeSlider.indicatorValue];
        CGRect indicatorRect = CGRectZero;
        if ([_rangeSlider isVertical]) {
            indicatorRect = CGRectMake(0.0, indicatorValuePosition, self.bounds.size.width, 3);
        } else {
            indicatorRect = CGRectMake(indicatorValuePosition, 0.0, 3, self.bounds.size.height);
        }
        
        NSBezierPath * indicatorPath = [NSBezierPath bezierPathWithRoundedRect:indicatorRect xRadius:1 yRadius:1];
        CGContextSetFillColorWithColor(ctx, [NSColor blueColor].CGColor);
        CGContextAddPath(ctx, [indicatorPath transformToCGPath]);
        CGContextFillPath(ctx);
#endif
    }
}

@end
