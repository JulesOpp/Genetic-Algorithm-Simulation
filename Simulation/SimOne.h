//
//  SimOne.h
//  Simulation
//
//  Created by Jules on 10/16/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimOne : NSObject
{
    int speed;
    NSColor *color;
    int x;
    int y;
    int w;
    int h;
    double att[4];
}
-(id) init;
-(id) initChild: (SimOne *)a : (SimOne *)b;
-(NSColor*)getColor;

-(int)getSpeed;
-(double*)getAtt;

-(int)getX;
-(int)getY;
-(int)getW;
-(int)getH;

-(void)addX;
-(void)subX;
-(void)addY;
-(void)subY;

-(void)resetX;

-(void)setMut:(double)a;
-(double)getMut;

-(int)randDirection;

@end
