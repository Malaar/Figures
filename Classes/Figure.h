//
//  Figure.h
//  Figures
//
//  Created by Malaar on 27.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Figure;

@protocol FigureDelegate <NSObject>

- (void) figureEndFly:(Figure*)aFigure;

@end


@interface Figure : CCSprite
{
	id<FigureDelegate> delegate;
	
	CCFiniteTimeAction* actionMove;
	CCFiniteTimeAction* actionRotate;
}

@property (nonatomic, retain) CCFiniteTimeAction* actionMove;
@property (nonatomic, retain) CCFiniteTimeAction* actionRotate;

+ (id) figure;

- (void) setDelegate:(id<FigureDelegate>) aDelegate;

- (void) setMoveFrom:(CGPoint)aPointFrom to:(CGPoint)aPointTo withDuration:(float)aDuration;
- (void) setRotationPerSecond:(float)aRotationPerSecond;

- (void) fly;

@end
