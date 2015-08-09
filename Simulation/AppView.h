//
//  AppView.h
//  Simulation
//
//  Created by Jules on 10/16/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@interface AppView : NSView
{
    @public
    double mutationCap;
}
-(void)drawObjects;
- (void)drawRect:(NSRect)dirtyRect;
-(void) drawBackground: (NSRect)dirtyRect;
- (void)mouseDown:(NSEvent *)theEvent;
- (id)initWithI: (NSRect)frame : (AppDelegate*)parent;
-(void) run;
-(void) checkDone;
-(void) nextPop;
-(void) restart;
@end
