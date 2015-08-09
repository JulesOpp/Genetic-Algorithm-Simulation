//
//  AppDelegate.h
//  Simulation
//
//  Created by Jules on 10/16/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    @public
    NSTimer* timer;
    
}
@property (assign) IBOutlet NSWindow *window;
-(void)run;
-(void)stopTimer;
-(void)startTimer;
@end
