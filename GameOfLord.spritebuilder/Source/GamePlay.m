//
//  GamePlay2.m
//  GameOfLord
//
//  Created by Manfred on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay{
    CCAction *_fingerMove;
    
    CCNode *_contentNode;    
    UI *_uiNode;
    
    CGPoint touchStartPos;
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = YES;
    
    [_uiNode loadUI: CLOUDY];
    [[NodeController getAllNodes] setValue:_uiNode forKey:@"UI"];
    
    [self loadLevel: @"1-1"];
    [[NodeController getAllNodes] setValue:_levelNode forKey:@"Level"];
    
    [[NodeController getAllNodes] setValue:self forKey:@"GamePlay"];
    [self resetTouchStartPos];
    
}

- (void)loadLevel:(NSString*) name{
    NSString* levelName = [NSString stringWithFormat: @"Levels/Level%@", name];
    _levelNode = (Level *) [CCBReader load: levelName];
    _levelNode.name = name;
    [_contentNode addChild:_levelNode];
    [self centerLevelNode];
}

- (void)centerLevelNode{
    float centerX = CGRectGetMidX(_contentNode.boundingBox);
    float centerY = CGRectGetMidY(_contentNode.boundingBox);
    _levelNode.position = ccp(centerX , centerY) ;
}

-(void) touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event{
    [self setDragStartPos: [touch locationInNode:_contentNode]];
    
    if(!_selector){
        _selector = [CCBReader load:@"Selectors/Select"];
        _selector.scale = [MapHelper cellSize] / _selector.contentSizeInPoints.width;
        [_levelNode addChild: _selector];
    }
    
    [self placeSelector: [touch locationInNode:_levelNode]];
}

-(void) placeSelector:(CGPoint) touchLocation{
    int col = touchLocation.x / [MapHelper cellSize];
    int row = touchLocation.y / [MapHelper cellSize];
    
    CGPoint newPos = ccp(col * [MapHelper cellSize], row * [MapHelper cellSize]);
    
    if(CGPointEqualToPoint(_selector.position, newPos)){
        if (_levelNode.selectedCharacter) {
            
        }else
            return;
    }
    
    [self cleanUpSelect];
    _selector.position = newPos;
    
    if ([_levelNode showAction:ccp(row, col)]) {
        [self placeTiles:[_levelNode moveToTiles] withName:@"moveTile"
             withCCBName:@"Selectors/Move"];
        [self placeTiles:[_levelNode attackTiles] withName:@"attackTile"
             withCCBName:@"Selectors/Red"];
    }
}

-(void) cleanUpSelect{
    NSArray *children = [_levelNode children];
    for(int i = 0; i < [children count]; i++){
        CCNode *node = (CCNode*)[children objectAtIndex:i];
        if ([node.name hasPrefix:@"moveTile"] || [node.name hasPrefix:@"attackTile"]){
            [node removeFromParentAndCleanup:YES];
            i--;
        }
    }
}

-(void) placeTiles:(NSArray*)locations withName:(NSString*)name withCCBName:(NSString*)ccb{
    int count = 0;
    
    for(int i = 0; i < [locations count]; i++){
        CCNode *tile = [CCBReader load:ccb];
        tile.scale = [MapHelper cellSize] / tile.contentSizeInPoints.width;
        tile.name = [NSString stringWithFormat:@"%@%@", name, @(i)];
        [_levelNode addChild:tile];
        CGPoint pos = [[locations objectAtIndex:i] CGPointValue];
        tile.position = [MapHelper placeAtIndexes: pos];
        count++;
    }
}

-(void) touchMoved:(CCTouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    [self dragScreen:touchLocation];
}

-(void) touchEnded:(CCTouch *)touch withEvent:(UIEvent *)event{
    // when touches end
    [self resetTouchStartPos];
}

-(void) touchCancelled:(CCTouch *)touch withEvent:(UIEvent *)event{
    // when touches are cancelled
    [self resetTouchStartPos];
}

-(void) update:(CCTime)delta{
    _levelNode.position = [self posInBound:[_levelNode position]];
    
}

-(void) setDragStartPos:(CGPoint)touchLocation{
    if(CGRectContainsPoint([_contentNode boundingBox], touchLocation)){
        touchStartPos = touchLocation;
    }else
        [self resetTouchStartPos];
}

-(void) dragScreen:(CGPoint)touchLocation{
    if(CGRectContainsPoint([_contentNode boundingBox], touchLocation)){
        if([self hasTouchStarted]){
            CGPoint moveTo = ccpSub(touchLocation, touchStartPos);
            touchStartPos = touchLocation;
            
            CGPoint newPos = ccpAdd(moveTo, _levelNode.position);
            [_levelNode setPosition: newPos];
        }else
            touchStartPos = touchLocation;
    }else
        [self resetTouchStartPos];
}

- (void)resetTouchStartPos{
    touchStartPos = ccp(NAN, NAN);
}

- (BOOL)hasTouchStarted{
    return !isnan(touchStartPos.x) && !isnan(touchStartPos.y);
}

- (CGPoint)posInBound:(CGPoint) pos{
    if(CGRectContainsRect(_levelNode.boundingBox, _contentNode.boundingBox))
        return pos;
    
    float xMin = _contentNode.boundingBox.origin.x;
    float xMax = xMin + _contentNode.boundingBox.size.width;
    
    float yMin = _contentNode.boundingBox.origin.y;
    float yMax = yMin + _contentNode.boundingBox.size.height;
    
    float x = pos.x;
    float y = pos.y;
    
    if(_levelNode.boundingBox.origin.x > xMin)
        x = xMin;
    
    if((_levelNode.boundingBox.origin.x + _levelNode.boundingBox.size.width) < xMax)
        x = xMax - _levelNode.boundingBox.size.width;
    
    if(_levelNode.boundingBox.origin.y + _levelNode.boundingBox.size.height < yMax)
        y = yMax - _levelNode.boundingBox.size.height;
    
    if (_levelNode.boundingBox.origin.y > yMin)
        y = yMin;
    
    return ccp(x, y);
}

@end
