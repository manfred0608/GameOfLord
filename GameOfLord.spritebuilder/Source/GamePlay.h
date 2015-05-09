//
//  GamePlay2.h
//  GameOfLord
//
//  Created by Manfred on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Level.h"

@interface GamePlay : CCNode

@property (nonatomic, strong) Level *levelNode;
@property (nonatomic, strong) CCNode *selector;

-(BOOL) attackFlag;

+(void) setAttackFlag:(BOOL)flag;
@end
