//
//  Animation.h
//  GameOfLord
//
//  Created by Manfred on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Animation : CCSprite

@property (nonatomic, strong) NSMutableDictionary *actionMap;
@property (nonatomic, strong) NSString *action;

-(void) addActionFrames:(NSString*) action;
@end
