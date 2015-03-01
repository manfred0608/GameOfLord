//
//  UI.m
//  GameOfLord
//
//  Created by Manfred on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UI.h"

@implementation UI

- (void)loadUI:(NSString *)name{
    [self._weatherNode loadWeather:@"sunny"];
}

@end
