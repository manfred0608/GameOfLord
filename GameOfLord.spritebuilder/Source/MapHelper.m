//
//  MapHelper.m
//  GameOfLord
//
//  Created by Manfred on 3/6/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MapHelper.h"
#import "Constants.h"

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
    if (CGPointEqualToPoint(pos, another)) {
        return nil;
    }
    
    if(pos.x < another.x)
        return FACE_RIGHT;
    else if(pos.x > another.x)
        return FACE_LEFT;
    else{
        if (pos.y < another.y)
            return FACE_UP;
        else
            return FACE_DOWN;
    }
}

+(void) cleanUpSelect:(NSString*)name withNode:(CCNode*) levelNode{
    NSArray *children = [levelNode children];
    for(int i = 0; i < [children count]; i++){
        CCNode *node = (CCNode*)[children objectAtIndex:i];
        if ([node.name hasPrefix:name]){
            [node removeFromParentAndCleanup:YES];
            i--;
        }
    }
}

+(void) placeTiles:(NSArray*)locations withName:(NSString*)name withCCBName:(NSString*)ccb withNode:(CCNode*) levelNode{
    int count = 0;
    
    for(int i = 0; i < [locations count]; i++){
        CCNode *tile = [CCBReader load:ccb];
        tile.scale = CELL_SIZE / tile.contentSizeInPoints.width;
        tile.name = [NSString stringWithFormat:@"%@%@", name, @(i)];
        [levelNode addChild:tile];
        CGPoint pos = [[locations objectAtIndex:i] CGPointValue];
        tile.position = [MapHelper placeAtIndexes: pos];
        count++;
    }
}

+(void)placeOptionNode:(CCNode*)optionNode withCharacter:(CCNode*)character withLevel:(CCNode*)levelNode withWorld:(CCNode*)contentNode{
    optionNode.visible = YES;
    CCNode *option = [optionNode getChildByName:@"layout" recursively:false];
    
    CGRect selectArea = [character boundingBox];
    CGRect baseArea = [levelNode boundingBox];
    
    CGFloat centerX = CGRectGetMidX(selectArea) + CGRectGetMinX(baseArea);
    CGFloat centerY = CGRectGetMidY(selectArea) + CGRectGetMinY(baseArea);
    
    CGFloat selectX = CGRectGetMinX(selectArea) + CGRectGetMinY(baseArea);
    CGFloat selectY = CGRectGetMinY(selectArea) + CGRectGetMinY(baseArea);
    
    CGRect area = [contentNode boundingBox];
    
    CGFloat posX = 0;
    CGFloat posY = 0;
    
    if(centerX >= CGRectGetMidX(area))
        posX = selectX - [option boundingBox].size.width;
    else
        posX = CGRectGetMaxX(selectArea);
    
    if(centerY + [option boundingBox].size.height / 2 >= CGRectGetMaxY(area))
        posY = selectY - [option boundingBox].size.height;
    else if(centerY - [option boundingBox].size.height / 2 <= CGRectGetMinY(area))
        posY = selectY;
    else
        posY = selectY - [option boundingBox].size.height / 2   ;
    
    option.position = ccp(posX, posY);
    return;
}

@end
