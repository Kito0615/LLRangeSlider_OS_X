//
//  LLRangeSliderCellLayer.m
//  EditWindowController
//
//  Created by AnarL on 16/4/14.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "LLRangeSliderCellLayer.h"
#import "LLRangeSlider.h"
#import "NSBezierPath+TransformToCGPath.h"

@implementation LLRangeSliderCellLayer

#pragma mark -Override
/**
 *  重写父类方法，画出滑块
 */
- (void)drawInContext:(CGContextRef)ctx
{
    if (_rangeSlider) {
        NSPoint begin = NSMakePoint(0, 0);
        NSPoint second = NSMakePoint(0, 0);
        NSPoint third = NSMakePoint(0, 0);
        NSPoint fourth = NSMakePoint(0, 0);
        
        NSBezierPath * cellPath = [NSBezierPath bezierPath];
        
        CGFloat sliceCutHeight = 2 * self.frame.size.height / 3;
        CGFloat sliceCutWidth = self.frame.size.width / 3;
        
        switch (_rangeSlider.cellSide) {
                /**
                 *  滑动条横向，滑块在上方
                 */
            case LLRangeSliderCellSideUp:
                begin = NSMakePoint(0, sliceCutHeight);
                second = NSMakePoint(0, self.frame.size.height);
                third = NSMakePoint(self.frame.size.width, self.frame.size.height);
                fourth = NSMakePoint(self.frame.size.width, 0);
                
                /**
                 *  滑块如果是较大值，需要修改切割位置
                 */
                if (_cellPosition == LLRangeSliderCellPositionBigger) {
                    begin.y = 0;
                    fourth.y = sliceCutHeight;
                }
                /**
                 *  滑块如果是进度块，需要还原为方块
                 */
                if (_cellPosition == LLRangeSliderCellPositionIndicator) {
                    begin.y = self.frame.size.height;
                }
                break;
                /**
                 *  滑动条横向，滑块在下方
                 */
            case LLRangeSliderCellSideDown:
                begin = NSMakePoint(0, 0);
                second = NSMakePoint(0, sliceCutHeight);
                third = NSMakePoint(self.frame.size.width, self.frame.size.height);
                fourth = NSMakePoint(self.frame.size.width, 0);
                
                if (_cellPosition == LLRangeSliderCellPositionBigger) {
                    second.y = self.frame.size.height;
                    third.y = sliceCutHeight;
                }
                if (_cellPosition == LLRangeSliderCellPositionIndicator) {
                    third.y = sliceCutHeight;
                }
                break;
                /**
                 *  滑动条纵向，滑块在左侧
                 */
            case LLRangeSliderCellSideLeft:
                begin = NSMakePoint(0, 0);
                second = NSMakePoint(0, self.frame.size.height);
                third = NSMakePoint(self.frame.size.width, self.frame.size.height);
                fourth = NSMakePoint(sliceCutWidth, 0);
                
                if (_cellPosition == LLRangeSliderCellPositionBigger) {
                    third.x = sliceCutWidth;
                    fourth.x = self.frame.size.width;
                }
                if (_cellPosition == LLRangeSliderCellPositionIndicator) {
                    third.x = sliceCutWidth;
                }
                break;
                /**
                 *  滑动条纵向，滑块在右侧
                 */
            case LLRangeSliderCellSideRight:
                begin = NSMakePoint(sliceCutWidth, 0);
                second = NSMakePoint(0, self.frame.size.height);
                third = NSMakePoint(self.frame.size.width, self.frame.size.height);
                fourth = NSMakePoint(self.frame.size.width, 0);
                
                if (_cellPosition == LLRangeSliderCellPositionBigger) {
                    begin.x = 0;
                    second.x = sliceCutWidth;
                }
                if (_cellPosition == LLRangeSliderCellPositionIndicator) {
                    third.x = sliceCutWidth;
                }
                break;
        }
        [cellPath moveToPoint:begin];
        [cellPath lineToPoint:second];
        [cellPath lineToPoint:third];
        [cellPath lineToPoint:fourth];
        [cellPath lineToPoint:begin];
        
        NSColor * shadowColor = [NSColor grayColor];
        
        CGContextSetShadowWithColor(ctx, CGSizeMake(0.0, 1.0), 1.0, shadowColor.CGColor);
        CGContextSetFillColorWithColor(ctx, _rangeSlider.cellTintColor.CGColor);
        CGContextAddPath(ctx, [cellPath transformToCGPath]);
        CGContextFillPath(ctx);
        
        CGContextSetStrokeColorWithColor(ctx, shadowColor.CGColor);
        CGContextSetLineWidth(ctx, 0.5);
        CGContextAddPath(ctx, [cellPath transformToCGPath]);
        CGContextStrokePath(ctx);
        
        if (_highlighted) {
            CGContextSetFillColorWithColor(ctx, [NSColor colorWithWhite:0.0 alpha:1.0].CGColor);
            CGContextAddPath(ctx, [cellPath transformToCGPath]);
            CGContextFillPath(ctx);
        }
    }
}

@end
