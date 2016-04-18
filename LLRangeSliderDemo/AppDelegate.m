//
//  AppDelegate.m
//  LLRangeSliderDemo
//
//  Created by AnarL on 16/4/18.
//  Copyright © 2016年 AnarL. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    LLRangeSlider * verSlider;
    LLRangeSlider * horSlider;
}

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self setupSliders];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateValues) name:DRAG_CELL_NOTIFICATION object:nil];
}

- (void)setupSliders
{
    verSlider = [[LLRangeSlider alloc] initWithFrame:NSMakeRect(270, 70, 28, 440)];
    verSlider.direction = LLRangeSliderDirectionVertical;
    verSlider.smallerValue = 25;
    verSlider.biggerValue = 75;
    verSlider.maxValue = 100;
    verSlider.minValue = 0;
    self.verMaxValue.stringValue = transfer_value_to_string(verSlider.biggerValue, @"Max");
    self.verMinValue.stringValue = transfer_value_to_string(verSlider.smallerValue, @"Min");
    
    self.verBiggerValue.stringValue = transfer_value_to_string(horSlider.biggerValue, @"Bigger");
    self.verSmallerValue.stringValue = transfer_value_to_string(horSlider.smallerValue, @"Smaller");
    [verSlider setHasTrimMark:YES];
    [self.window.contentView addSubview:verSlider];
    
    horSlider = [[LLRangeSlider alloc] initWithFrame:NSMakeRect(380, 70, 310, 28)];
    horSlider.smallerValue = 25;
    horSlider.biggerValue = 75;
    horSlider.maxValue = 100;
    horSlider.minValue = 0;
    self.horMaxValue.stringValue = transfer_value_to_string(verSlider.biggerValue, @"Max");
    self.horMinValue.stringValue = transfer_value_to_string(verSlider.smallerValue, @"Min");
    
    self.horBiggerValue.stringValue = transfer_value_to_string(horSlider.biggerValue, @"Bigger");
    self.horSmallerValue.stringValue = transfer_value_to_string(horSlider.smallerValue, @"Smaller");
    [horSlider setHasTrimMark:YES];
    [self.window.contentView addSubview:horSlider];
    
    [self verCellSideLeft:self.leftCheck];
    [self horCellSideUp:self.upCheck];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)verCornerRadius:(NSButton *)sender {
    if (sender.state) {
        verSlider.cornerRadius = 1;
    } else {
        verSlider.cornerRadius = 0;
    }
}

- (IBAction)horCornerRadius:(NSButton *)sender {
    if (sender.state) {
        horSlider.cornerRadius = 1;
    } else {
        horSlider.cornerRadius = 0;
    }
}

- (IBAction)verCellSideLeft:(NSButton *)sender {
    [self.rightCheck setState:0];
    sender.state = 1;
    verSlider.cellSide = LLRangeSliderCellSideLeft;
}

- (IBAction)verCellSideRight:(NSButton *)sender {
    [self.leftCheck setState:0];
    sender.state = 1;
    verSlider.cellSide = LLRangeSliderCellSideRight;
}

- (IBAction)horCellSideUp:(NSButton *)sender {
    [self.downCheck setState:0];
    sender.state = 1;
    horSlider.cellSide = LLRangeSliderCellSideUp;
}

- (IBAction)horCellSideDown:(NSButton *)sender {
    [self.upCheck setState:0];
    sender.state = 1;
    horSlider.cellSide = LLRangeSliderCellSideDown;
}

- (void)updateValues
{
    self.verBiggerValue.stringValue = transfer_value_to_string(verSlider.biggerValue, @"Bigger");
    self.verSmallerValue.stringValue = transfer_value_to_string(verSlider.smallerValue, @"Smaller");
    
    self.horBiggerValue.stringValue = transfer_value_to_string(horSlider.biggerValue, @"Bigger");
    self.horSmallerValue.stringValue = transfer_value_to_string(horSlider.smallerValue, @"Smaller");
}

static NSString * transfer_value_to_string(double value, NSString * name)
{
    return [NSString stringWithFormat:@"%@ : %lf", name, value];
}
-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}
@end
