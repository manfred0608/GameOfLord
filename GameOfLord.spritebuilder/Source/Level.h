//
//  Level.h
//  GameOfLord
//
//  Created by Manfred on 3/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface Level : CCNode

@property (nonatomic, strong) CCSprite *selector;

-(id) initLevel;
-(void) placeSelector:(CGPoint) position;
@end
