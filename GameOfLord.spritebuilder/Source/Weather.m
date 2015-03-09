//
//  Weather.m
//  GameOfLord
//
//  Created by Manfred on 2/27/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (id)init{
    if(self = [super init])
        self.frameDir = @"GameOfLordAssets/UI/Weathers/";
    return self;
}

-(void) loadWeatherFrame:(NSString*) name{
    [self resetActionFrames:self.frameDir withActionName:name withFrameNum: NUM_WEATHER_FRAMES];
}

-(void) addWeather:(NSString*) name{
    [self addAction: name withFrameNum: NUM_WEATHER_FRAMES];
}

-(void) changeWeather:(NSString*) name{
    [self setAction: name];
}

@end
