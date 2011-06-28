//
//  GameScene.m
//  Figures
//
//  Created by Malaar on 27.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@interface GameScene (Private)

- (Figure*) generateNewFigure;
- (void) createFigure:(ccTime)aTimeElapsed;

@end


@implementation GameScene

+ (id) scene
{
	CCScene* scene = [CCScene node];
	GameScene* layer = [GameScene node];
	[scene addChild:layer];
	
	return scene;
}

- (id) init
{
	if( (self = [super init]) )
	{
		currentTime = 0.0f;
		figureFrames = [NSMutableArray new];
		figures = [NSMutableArray new];

		// TEMPORARRY HERE:
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"assets/gameScene/figures.plist" textureFile:@"assets/gameScene/figures.png"];
		timeToGenerate = 0.25f;
		
		NSString* frameName;
		CCSpriteFrame* frame;
		int index = 0;
		do
		{
			frameName = [NSString stringWithFormat:@"figure_%03d.png", ++index];
			frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
			if(frame)
				[figureFrames addObject:frame];

		} while(frame);
		
		// schedules
		[self schedule:@selector(createFigure:) interval:1.0f / 60.0f];
	}
	
	return self;
}

- (void) dealloc
{
	[figures release];
	[figureFrames release];
	// TEMPORARRY HERE:
	[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
	
	[super dealloc];
}


- (Figure*) generateNewFigure
{
	Figure* figure = [Figure figure];
	[figure setDelegate:self];

	// generate position
	float alpha = rand() % 360;
	alpha = CC_DEGREES_TO_RADIANS(alpha);
	CGPoint pointA = ccpForAngle(alpha);
	pointA = ccpMult(pointA, 300);			// !!!
	pointA = ccpAdd(pointA, ccp(240, 160));
	
	alpha = rand() % (250 - 110) + 110;
	alpha = CC_DEGREES_TO_RADIANS(alpha);
	CGPoint pointB = ccpRotateByAngle(pointA, ccp(240,160), -alpha);
//	pointB = ccpMult(pointB, 100);
	
	// configure actions
	float duration = rand() / RAND_MAX * 4 + 3;		// from 3 to 7
	[figure setMoveFrom:pointA to:pointB withDuration:duration];
	float rps = rand() / RAND_MAX * 1.5f + 0.5f;	// from 0.5 to 2
	[figure setRotationPerSecond:rps];

	// set frame
	int rndIndex = rand() % [figureFrames count];
	CCSpriteFrame* frame = [figureFrames objectAtIndex:rndIndex];
	[figure setDisplayFrame:frame];
	
	// set scale
	float scale = rand() / RAND_MAX; // from 0 to 1
	scale = scale * 0.4f + 0.6f;		// from 0.6 to 1.0
	figure.scale = scale;
	
	return figure;
}

- (void) createFigure:(ccTime)aTimeElapsed
{
	currentTime += aTimeElapsed;
	
	if(currentTime >= timeToGenerate)
	{
		currentTime -= timeToGenerate;

		Figure* figure = [self generateNewFigure];
		[self addChild:figure];
		[figures addObject:figure];
		[figure fly];
	}
}

- (void) figureEndFly:(Figure*)aFigure
{
	[self removeChild:aFigure cleanup:YES];
	[figures removeObject:aFigure];
}


@end
