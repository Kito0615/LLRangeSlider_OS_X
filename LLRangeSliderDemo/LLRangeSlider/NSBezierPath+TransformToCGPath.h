//
//  NSBezierPath+TransformToCGPath.h
//  EditWindowController
//
//  Created by AnarL on 16/4/14.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSBezierPath (TransformToCGPath)
- (CGMutablePathRef)transformToCGPath;
@end
