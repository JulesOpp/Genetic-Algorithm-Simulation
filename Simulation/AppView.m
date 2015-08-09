//
//  AppView.m
//  Simulation
//
//  Created by Jules on 10/16/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "AppView.h"
#import "SimOne.h"
#import "AppDelegate.h"

@implementation AppView

SimOne* simOne[8];
AppDelegate* parentObject;
bool mouseDown;
int done[4];
bool newGen;
int gen;
int sum;
int num;
double results[9];
int resultCount;

- (id)initWithI:(NSRect)frame: (AppDelegate*)parent
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i=0; i<8; i++) {
            simOne[i] = [[SimOne alloc] init];
        }
        parentObject = parent;
        mouseDown = true;
        for (int i=0;i<4;i++) done[i] = -1;
        newGen = false;
        gen = 1;
        sum = 0;
        num = 0;
        resultCount = 0;
    }
    
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSPoint point = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    NSLog(@"%f %f",point.x, point.y);
    if (mouseDown == true) {
        [parentObject stopTimer];
        mouseDown = false;
        NSLog(@"%f",(double)sum/num);
    }
    else {
        [parentObject startTimer];
        mouseDown = true;
    }
    [self display];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [self drawBackground: dirtyRect];
    [self drawObjects];
}

-(void)drawBackground:(NSRect)dirtyRect {
    [[NSColor blackColor] set];
    NSRectFill(CGRectMake(700, 0, 5, 30));
    NSRectFill(CGRectMake(700, 30, 30, 5));
}

-(void)drawObjects 
{
    //[[NSColor redColor] set];
    //NSRectFill(CGRectMake(100,200,50,50));
    for (int i=0; i<8; i++) {
        [[simOne[i] getColor] set];
        NSRectFill(CGRectMake([simOne[i] getX], [simOne[i] getY], [simOne[i] getH], [simOne[i] getW]));
    }
}

-(void)nextPop {
    int temp[4];
    int temp1 = 0;
    for (int i=0; i<8; i++) {
        if (i!=done[0] || i!=done[1] || i!=done[2] || i!=done[3]) {
            temp[temp1] = i;
            temp1++;
        }
    }
    
    for (int i=0; i<4; i++) {
        simOne[temp[i]] = [[SimOne alloc] initChild: simOne[done[i]]: simOne[done[(i+1)%4]]];
    }
    
    for (int i=0; i<8; i++) {
        [simOne[i] resetX];
    }
    
    for (int i=0; i<4; i++) {
        done[i] = -1;
    }
    
    gen++;
}

-(void) restart {
    for (int i=0; i<8; i++) {
        simOne[i] = [[SimOne alloc] init];
    }
    for (int i=0; i<8; i++) {
        [simOne[i] resetX];
    }
    
    for (int i=0; i<4; i++) {
        done[i] = -1;
    }
    sum += gen;
    num++;
    gen = 1;
    
    // How many generations per mutation rate
    if (num == 50) {
        //[parentObject stopTimer];
        NSLog(@"%f",(double)sum/num);
        results[resultCount] = (double)sum/num;
        resultCount++;
        for (int i=0; i<1; i++) {
            [simOne[i] setMut: [simOne[i] getMut]+0.1];
        }
        num = 0;
        sum = 0;
    }
    
    // How many mutation rate trials
    if (resultCount == 9) {
        for (int i=0; i<8; i++) {
            NSLog(@"%d %f",i+1,results[i]);
        }
        [parentObject stopTimer];
    }
}

-(void)checkDone {
    for (int i=0; i<8; i++) {
        
        // At what point is a population deemed done
        //if ([simOne[i] getAtt][2]+[simOne[i] getAtt][3] > 0.9) {
        if ([simOne[i] getAtt][2] > 0.4 && [simOne[i] getAtt][3] > 0.4) {
            //[parentObject stopTimer];
            NSLog(@"%d done",gen);
            [self restart];
        }
    }
    
    for (int i=0; i<8; i++) {
        
        // Where do the populations have to reach
        if ([simOne[i] getX] > 700 && [simOne[i] getY] < 30) {
            for (int j=0; j<4; j++) {
                if (done[j] == i) {
                    break;
                }
                if (done[j] == -1) {
                    done[j] = i;
                    break;
                }
            }
        }
    }
    if (done[0]!=-1 && done[1]!=-1 && done[2]!=-1 && done[3]!=-1) {
        newGen = true;
        NSLog(@"%d %f",gen,[simOne[0] getMut]);
        [self nextPop];
    }
}

-(void)run {
    int temp;
    for (int i=0; i<8; i++) {
        temp = [simOne[i] randDirection];
        //NSLog(@"%d",temp);
        switch (temp) {
            case 0:
                [simOne[i] subX];
                break;
            case 1:
                [simOne[i] addY];
                break;
            case 2:
                [simOne[i] addX];
                break;
            case 3:
                [simOne[i] subY];
                break;
            default:
                break;
        }
    }
    [self display];
    [self checkDone];
}

@end
