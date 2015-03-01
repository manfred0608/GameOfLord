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
    CCNode *_levelNode;
    
    UI *_uiNode;
    
    CGPoint touchStartPos;
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    _levelNode = [CCBReader load:@"Levels/Level1-1"];
    [_contentNode addChild:_levelNode];
    
    [self initWeather];
    [self initLevelNode];
    [self resetTouchStartPos];
}

- (void)initLevelNode{
    _levelNode.position = ccp(_contentNode.contentSizeInPoints.width / 2,
                              _contentNode.contentSizeInPoints.height / 2);
}

- (void)initWeather{
    Weather *_weatherNode = _uiNode._weatherNode;
    [_weatherNode loadWeather:@"sunny"];
    CGFloat scale = _uiNode.contentSize.height / _weatherNode.frameSize.height;
    _weatherNode.scaleX = scale;
    _weatherNode.scaleY = scale;
}

-(void) touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    [self setDragStartPos:touchLocation];
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
            [_levelNode setPosition:newPos];
        }else
            touchStartPos = touchLocation;
    }else
        [self resetTouchStartPos];
}

- (void)touchMoved:(CCTouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    
    CGRect box = _levelNode.boundingBox;
    CCLOG(@"posX: %f; posY: %f; width: %f; height: %f", box.origin.x, box.origin.y, box.size.width, box.size.height);
    [self dragScreen:touchLocation];
}

-(void) touchEnded:(CCTouch *)touch withEvent:(UIEvent *)event{
    // when touches end
    [self resetTouchStartPos];
}

-(void) touchCancelled:(CCTouch *)touch withEvent:(UIEvent *)event{
    // when touches are cancelled, meaning the user drags their finger off the screen or onto something else, release the catapult
    [self resetTouchStartPos];
}


- (void)resetTouchStartPos{
    touchStartPos = ccp(NAN, NAN);
}

- (BOOL)hasTouchStarted{
    return !isnan(touchStartPos.x) && !isnan(touchStartPos.y);
}

- (BOOL)levelInBound{
    if(_levelNode.position.x > 0)
        return false;
    if(_levelNode.position.y > 0)
        return false;
    //if(level.position.x + level.contentSize.)
    return true;
}
@end
