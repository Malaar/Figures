//
//  GameScene.h
//  Figures
//
//  Created by Malaar on 27.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Figure.h"

@interface GameScene : CCLayer <FigureDelegate>
{
	NSMutableArray* figureFrames;
	NSMutableArray* figures;
	
	float currentTime;
	
	float timeToGenerate;
}

+ (id) scene;

@end
