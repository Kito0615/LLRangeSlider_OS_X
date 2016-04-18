//
//  NSBezierPath+TransformToCGPath.m
//  EditWindowController
//
//  Created by AnarL on 16/4/14.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "NSBezierPath+TransformToCGPath.h"

@implementation NSBezierPath (TransformToCGPath)

- (CGMutablePathRef)transformToCGPath
{
   CGMutablePathRef path = CGPathCreateMutable();
    NSInteger numElements = self.elementCount;
//    NSPointArray * points = CFBridgingRetain([[NSPointerArray alloc] init]);
//    NSBezierPathElement element = [self elementAtIndex:0];
    NSPoint points[3];
    
    if (numElements > 0) {
        BOOL didClosePath = YES;
        
        for (NSInteger i = 0; i < numElements; i ++) {
            NSBezierPathElement element = [self elementAtIndex:i associatedPoints:points];
            
            if (isnan(points[0].x)) {
                points[0].x = 0;
            }
            if (isnan(points[1].x)) {
                points[1].x = 0;
            }
            if (isnan(points[2].x)) {
                points[2].x = 0;
            }
            if (isnan(points[0].y)) {
                points[0].y = 0;
            }
            if (isnan(points[1].y)) {
                points[1].y = 0;
            }
            if (isnan(points[2].y)) {
                points[2].y = 0;
            }
            
            switch (element) {
                case NSMoveToBezierPathElement:
                    CGPathMoveToPoint(path, nil, points[0].x, points[0].y);
                    break;
                case NSLineToBezierPathElement:
                    CGPathAddLineToPoint(path, nil, points[0].x, points[0].y);
                    didClosePath = NO;
                    break;
                case NSCurveToBezierPathElement:
                    CGPathAddCurveToPoint(path, nil, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
                    didClosePath = NO;
                    break;
                case NSClosePathBezierPathElement:
                    CGPathCloseSubpath(path);
                    didClosePath = YES;
                    break;
            }
        }
        if (!didClosePath) {
            CGPathCloseSubpath(path);
        }
    }
    return path;
}

@end
