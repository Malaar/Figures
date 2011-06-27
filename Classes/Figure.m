//
//  Figure.m
//  Figures
//
//  Created by Malaar on 27.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Figure.h"

@interface Figure (Private)

- (void) endFly;

@end

@implementation Figure

@synthesize actionMove;
@synthesize actionRotate;

+ (id) figure
{
	return [[[Figure alloc] init] autorelease];
}

- (void) dealloc
{
	[delegate release];
	
	[super dealloc];
}

- (void) setDelegate:(id<FigureDelegate>) aDelegate
{
	delegate = [aDelegate retain];
}

- (void) setMoveFrom:(CGPoint)aPointFrom to:(CGPoint)aPointTo withDuration:(float)aDuration;
{
	position_ = aPointFrom;
	id callBack = [CCCallFunc actionWithTarget:self selector:@selector(endFly)];
	id actMove = [CCMoveTo actionWithDuration:aDuration position:aPointTo];
	self.actionMove = [CCSequence actions:actMove, callBack, nil];
}

- (void) setRotationPerSecond:(float)aRotationPerSecond;
{
	float duration = 1.0f / aRotationPerSecond;
	self.actionRotate = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:duration angle:360]];
}

- (void) fly
{
	[self runAction:actionMove];
	[self runAction:actionRotate];
}

- (void) endFly
{
	//[self stopAllActions];
	[delegate figureEndFly:self];
}

@end
