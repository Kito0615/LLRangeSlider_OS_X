//
//  AppDelegate.h
//  LLRangeSliderDemo
//
//  Created by AnarL on 16/4/18.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LLRangeSlider.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet NSTextField *verMaxValue;
@property (weak) IBOutlet NSTextField *verMinValue;
@property (weak) IBOutlet NSTextField *verBiggerValue;
@property (weak) IBOutlet NSTextField *verSmallerValue;


@property (weak) IBOutlet NSTextField *horMaxValue;
@property (weak) IBOutlet NSTextField *horMinValue;
@property (weak) IBOutlet NSTextField *horBiggerValue;
@property (weak) IBOutlet NSTextField *horSmallerValue;

@property (weak) IBOutlet NSButton *leftCheck;
@property (weak) IBOutlet NSButton *rightCheck;
@property (weak) IBOutlet NSButton *upCheck;
@property (weak) IBOutlet NSButton *downCheck;

- (IBAction)verCornerRadius:(NSButton *)sender;
- (IBAction)horCornerRadius:(NSButton *)sender;

- (IBAction)verCellSideLeft:(NSButton *)sender;
- (IBAction)verCellSideRight:(NSButton *)sender;

- (IBAction)horCellSideUp:(NSButton *)sender;
- (IBAction)horCellSideDown:(NSButton *)sender;

@end

