//
//  AppDelegate.m
//  Simulation
//
//  Created by Jules on 10/16/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "AppView.h"

@implementation AppDelegate

@synthesize window = _window;

AppView *view;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    srand(time(NULL));
    [self.window setFrame:CGRectMake(300, 200, 730, 420) display:YES];
    [self.window setStyleMask:[self.window styleMask] & ~NSResizableWindowMask];
    view = [[AppView alloc] initWithI:_window.frame: self];
    [view setFrameOrigin:NSMakePoint(0, 0)];
    [self.window.contentView addSubview:view];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.00000001 target:self selector:@selector(run) userInfo: nil repeats:YES];  
}

-(void) run {
    [view run];
}

-(void)stopTimer {
    [timer invalidate];
    timer = nil;
}

-(void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(run) userInfo: nil repeats:YES];  
}

@end
