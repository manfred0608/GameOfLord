//
//  GamePlay2.m
//  GameOfLord
//
//  Created by Manfred on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"
#import "Option.h"
#import "Constants.h"
#import "MapHelper.h"
#import "NodeController.h"
#import "Weather.h"
#import "Character.h"
#import "UI.h"

static BOOL attackFlag = NO;

@implementation GamePlay{
    CCAction *_fingerMove;
    
    CCNode *_contentNode;
    UI *_uiNode;
    
    CGPoint touchStartPos;
    
    Option *_optionNode;
}

// is called when CCB file has completed loading
- (void) didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = YES;
    
    [[NodeController getAllNodes] setValue:_contentNode forKey:@"Content"];
    
    [_uiNode loadUI: CLOUDY];
    [[NodeController getAllNodes] setValue:_uiNode forKey:@"UI"];
    
    [self loadLevel: @"1-1"];
    [[NodeController getAllNodes] setValue:_levelNode forKey:@"Level"];
    
    _optionNode = (Option*)[CCBReader load:@"Options"];
    [_contentNode addChild:_optionNode];
    _optionNode.visible = NO;
    [[NodeController getAllNodes] setValue:_optionNode forKey:@"Options"];
    
    [[NodeController getAllNodes] setValue:self forKey:@"GamePlay"];
    [self resetTouchStartPos];
}

- (void) loadLevel:(NSString*) name{
    NSString* levelName = [NSString stringWithFormat: @"Levels/Level%@", name];
    _levelNode = (Level *) [CCBReader load: levelName];
    _levelNode.name = name;
    
    [_contentNode addChild:_levelNode];
    [self centerLevelNode];
}

- (void) centerLevelNode{
    float centerX = CGRectGetMidX(_contentNode.boundingBox);
    float centerY = CGRectGetMidY(_contentNode.boundingBox);
    _levelNode.position = ccp(centerX , centerY) ;
}

-(void) touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [touch locationInNode:self];
    if(!CGRectContainsPoint([_contentNode boundingBox], touchLocation))
        return;
    
    if(_optionNode.visible == YES &&
       !CGRectContainsPoint([_optionNode boundingBox], touchLocation))
        return;
    
    [self setDragStartPos: [touch locationInNode:_contentNode]];    
    [self placeSelector: [touch locationInNode:_levelNode]];
}

-(void) placeSelector:(CGPoint) touchLocation{
    if(!_selector){
        _selector = [CCBReader load:@"Selectors/Select"];
        _selector.scale = [MapHelper cellSize] / _selector.contentSizeInPoints.width;
        [_levelNode addChild: _selector];
    }
    
    int col = touchLocation.x / [MapHelper cellSize];
    int row = touchLocation.y / [MapHelper cellSize];
    
    CGPoint newPos = ccp(col * [MapHelper cellSize], row * [MapHelper cellSize]);
    
    if(CGPointEqualToPoint(_selector.position, newPos)){
        if (attackFlag == YES)
            return;
        if(_levelNode.selectedCharacter){
            [MapHelper placeOptionNode:_optionNode withCharacter:_levelNode.selectedCharacter withLevel:_levelNode withWorld:_contentNode];
        }else
            return;
    }
    _selector.position = newPos;
    
    [MapHelper cleanUpSelect:@"attackTile" withNode:_levelNode];
    if(attackFlag){
        [_levelNode showAction:ccp(row, col) withType:YES];
        return;
    }
    
    [MapHelper cleanUpSelect:@"moveTile" withNode:_levelNode];
    
    if ([_levelNode showAction:ccp(row, col) withType:NO] && _levelNode.selectedCharacter) {
        [MapHelper placeTiles:[_levelNode moveToTiles] withName:@"moveTile"
             withCCBName:@"Selectors/Move" withNode:_levelNode];
        [MapHelper placeTiles:[_levelNode attackTiles] withName:@"attackTile"
             withCCBName:@"Selectors/Red" withNode:_levelNode];
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

-(void) resetTouchStartPos{
    touchStartPos = ccp(NAN, NAN);
}

-(BOOL) hasTouchStarted{
    return !isnan(touchStartPos.x) && !isnan(touchStartPos.y);
}

-(CGPoint) posInBound:(CGPoint) pos{
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

-(BOOL) attackFlag{
    return attackFlag;
}

-(void) setAttackFlag:(BOOL)flag{
    attackFlag = flag;
}

@end
