//
//  GamePlay2.m
//  GameOfLord
//
//  Created by Manfred on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"
#import "UI.h"

@implementation GamePlay{
    CCAction *_fingerMove;
    
    CCNode *_contentNode;    
    UI *_uiNode;
    
    CGPoint touchStartPos;
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    
    _levelNode = [[Level alloc] initLevel];
    [_contentNode addChild:_levelNode];
    
    [self initWeather];
    [self centerLevelNode];
    [self resetTouchStartPos];
}

- (void)centerLevelNode{
    float centerX = CGRectGetMidX(_contentNode.boundingBox);
    float centerY = CGRectGetMidY(_contentNode.boundingBox);
    _levelNode.position = ccp(centerX ,
                              centerY) ;
}

- (void)initWeather{
    Weather *weatherNode = _uiNode.weatherNode;
    [weatherNode loadWeather:@"Sunny"];
    CGFloat scale = _uiNode.contentSize.height / weatherNode.frameSize.height;
    weatherNode.scaleX = scale;
    weatherNode.scaleY = scale;
}

-(void) touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event{
    [self setDragStartPos: [touch locationInNode:_contentNode]];
    [_levelNode placeSelector: [touch locationInNode:_levelNode]];
}

- (void)touchMoved:(CCTouch *)touch withEvent:(UIEvent *)event{
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
