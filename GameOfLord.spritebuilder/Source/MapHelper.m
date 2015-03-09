//
//  MapHelper.m
//  GameOfLord
//
//  Created by Manfred on 3/6/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MapHelper.h"

static const int CELL_SIZE = 36;
@implementation MapHelper

+ (BOOL)inRange:(CGPoint) pos withRange:(NSRange) range compareWith:(CGPoint) another{
    int diff = abs(pos.x - another.x) + abs(pos.y - another.y);
    
    return diff >= range.location && diff <= (range.location + range.length);
}

+ (BOOL)isLeft:(CGPoint) pos compareWith:(CGPoint) another{
    return (pos.x - another.x > 0);
}

+ (BOOL)isRight:(CGPoint) pos compareWith:(CGPoint) another{
    return (pos.x - another.x < 0);
}

+ (BOOL)isUp:(CGPoint) pos compareWith:(CGPoint) another{
    return (pos.y - another.y > 0);
}

+ (BOOL)isDown:(CGPoint) pos compareWith:(CGPoint) another{
    return (pos.y - another.y < 0);
}

+ (CGPoint) placeAtIndexes:(CGPoint) indexes{
    return ccp(indexes.y * CELL_SIZE, indexes.x * CELL_SIZE);
}

+(int) cellSize{
    return CELL_SIZE;
}


+(BOOL) containsMoves:(NSArray*) array withValue:(CGPoint) pos{
    for (int i = 0; i < [array count]; i++) {
        CGPoint p = [[array objectAtIndex:i] CGPointValue];
        
        if (CGPointEqualToPoint(pos, p))
            return YES;
    }
    return NO;
}

+ (NSString*)relativePos:(CGPoint) pos compareWith:(CGPoint) another{
    
}


@end
