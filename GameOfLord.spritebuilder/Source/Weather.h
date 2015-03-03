//
//  Weather.h
//  GameOfLord
//
//  Created by Manfred on 2/27/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Animation.h"

@interface Weather : Animation

@property (nonatomic, assign) int timer;
@property (nonatomic, copy) NSArray *frameArray;
@property (nonatomic, assign) CGSize frameSize;

-(void) loadWeather:(NSString*) name;
@end
