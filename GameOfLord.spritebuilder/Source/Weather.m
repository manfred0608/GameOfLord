//
//  Weather.m
//  GameOfLord
//
//  Created by Manfred on 2/27/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Weather.h"

static const int numOfFrams = 4;
static const int gap = 6;

@implementation Weather

- (void) loadWeather:(NSString*) name{
    self.timer = 0;
    self._frameArray = [NSArray array];
    
    CCSpriteFrame *frame = nil;
    for (int i = 0; i < numOfFrams; i++) {
        NSString *dir = @"GameOfLordAssets/Weathers/";
        NSString *fileType = @".png";
        NSString *slash = @"/";
        NSString *num = [@(i + 1) stringValue];
        
        NSString *fileName = [NSString stringWithFormat:@"%@%@%@%@%@",
                              dir, name, slash, num, fileType];
        
        frame = [CCSpriteFrame frameWithImageNamed:fileName];
        self._frameArray = [self._frameArray arrayByAddingObject:frame];
    }

    self.frameSize = frame.originalSize;
}

-(void) update:(CCTime)delta{
    self.timer++;
    if(self.timer == (numOfFrams * gap))
        self.timer = 0;
    
    CCSpriteFrame *curFrame = [self._frameArray objectAtIndex:(self.timer / gap)];
    [self setSpriteFrame:curFrame];
    return;
}

@end
