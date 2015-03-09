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
    [_weatherNode loadWeatherFrame:name];
    
    CGFloat scale = _contentSize.height / _weatherNode.frameSize.height;
    _weatherNode.scaleX = scale;
    _weatherNode.scaleY = scale;
}


@end
