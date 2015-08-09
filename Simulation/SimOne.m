//
//  SimOne.m
//  Simulation
//
//  Created by Jules on 10/16/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SimOne.h"
#import "AppDelegate.h"
#import "AppView.h"

@implementation SimOne

double mutationCap = 0.1;

-(id)init {
    self = [super init];
    if (self) {
        speed = rand()%9+1;
        color = [NSColor colorWithSRGBRed:((double) rand() / (RAND_MAX)) green:((double) rand() / (RAND_MAX)) blue:((double) rand() / (RAND_MAX)) alpha:((double) rand() / (RAND_MAX))];
        x = 5;
        y = rand()%300;
        w = 5;
        h = 5;
        att[0] = 0.25;//rand();
        att[1] = 0.25;//rand();
        att[2] = 0.25;//rand();
        att[3] = 0.25;//rand();
        double sum = att[0]+att[1]+att[2]+att[3];
        for (int i=0; i<4; i++) att[i] /= sum;
        att[0] /= 2;
        att[2] += att[0];
        att[1] /= 2;
        att[3] += att[1];
    }
    return self;
}

-(id)initChild: (SimOne *)a: (SimOne *)b {
    self = [super init];
    if (self) {
        speed = ((double) [a getSpeed] + [b getSpeed])/2.0;
        color = [NSColor colorWithSRGBRed:((double) rand() / (RAND_MAX)) green:((double) rand() / (RAND_MAX)) blue:((double) rand() / (RAND_MAX)) alpha:((double) rand() / (RAND_MAX))];
        x = 5;
        y = rand()%300;
        w = 5;
        h = 5;
        att[0] = ([a getAtt][0] + [b getAtt][0]);
        if (((double) rand() / (RAND_MAX)) < mutationCap) {
            att[0] += ((double) rand() / (RAND_MAX));
        }
        att[1] = ([a getAtt][1] + [b getAtt][1]);
        if (((double) rand() / (RAND_MAX)) < mutationCap) {
            att[1] += ((double) rand() / (RAND_MAX));
        }
        att[2] = ([a getAtt][2] + [b getAtt][2]);
        if (((double) rand() / (RAND_MAX)) < mutationCap) {
            att[2] += ((double) rand() / (RAND_MAX));
        }
        att[3] = ([a getAtt][3] + [b getAtt][3]);
        if (((double) rand() / (RAND_MAX)) < mutationCap) {
            att[3] += ((double) rand() / (RAND_MAX));
        }
        double sum = att[0]+att[1]+att[2]+att[3];
        for (int i=0; i<4; i++) att[i] /= sum;
        //NSLog(@"%f %f %f %f",att[0],att[1],att[2],att[3]);
    }
    return self;
}

-(NSColor*)getColor { return color; }
-(int)getSpeed { return speed; }
-(double*)getAtt { return att; }

-(int)getX { return x; }
-(int)getY { return y; }
-(int)getW { return w; }
-(int)getH { return h; }

-(void)addX { if (x<720) x += 10; }
-(void)subX { if (x>10)  x -= 10; }
-(void)addY { if (y<380) y += 10; }
-(void)subY { if (y>10)  y -= 10; }

-(void)setMut:(double)a { mutationCap = a; }
-(double)getMut { return mutationCap; }

-(void)resetX { x = 5; }

-(int)randDirection {
    double temp = ((double) rand() / (RAND_MAX));
    if (temp < att[0])
        return 0;
    else if (temp < att[0]+att[1])
        return 1;
    else if (temp < att[0]+att[1]+att[2])
        return 2;
    else if (temp <= att[0]+att[1]+att[2]+att[3])
        return 3;
    return -1;
}

@end
