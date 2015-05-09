//
//  Animation.m
//  GameOfLord
//
//  Created by Manfred on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Animation.h"

static const int gap = 10;
@implementation Animation{
    NSMutableArray *_frameArray;
}

-(id) init{
    if(self = [super init]){
        _timer = 0;
        _actionMap = [NSMutableDictionary dictionary];
        _pauseAnimation = NO;
        _repeat = YES;
    }
    return self;
}

-(id) initWithFrameDir:(NSString *)dir{
    if(self = [self init]){
        _frameDir = dir;
    }
    return self;
}

-(void) loadWithAction:(NSString*) action withFrameNum:(NSInteger) num{
    [self addAction: action withFrameNum:num];
    _frameSize = ((CCSpriteFrame*)[_frameArray objectAtIndex:0]).originalSize;
    _action = action;
}

-(void) resetActionFrames:(NSString*) dir withActionName:(NSString*) action
             withFrameNum:(NSInteger) num{
    [_actionMap removeAllObjects];
    _frameDir = dir;
    _action = action;
    [self loadWithAction: action withFrameNum:num];
    return;
}

-(void) addAction:(NSString*) action withFrameNum:(NSInteger) num{
    if(![_actionMap objectForKey:action]){
        CCSpriteFrame *frame = nil;
        _frameArray = [NSMutableArray array];
        
        for(int i = 0; i < num; i++){
            NSString *fileName = [NSString stringWithFormat:@"%@%@%@.png",
                                  _frameDir, action, [@(i + 1) stringValue]];
            
            frame = [CCSpriteFrame frameWithImageNamed:fileName];
            [_frameArray addObject:frame];
        }
        _actionMap[action] = _frameArray;
    }
    return;
}

-(void) changeAction:(NSString*) action withFrameNum:(NSInteger) num{
    if([_action isEqualToString:action])
        return;
    
    _timer = 0;
    _action = action;
    if(![_actionMap objectForKey:action])
        [self addAction:action withFrameNum:num];
}

-(void) act:(NSString *)action withFrameNum:(NSInteger)num{
    if (![_actionMap objectForKey:action])
        [self addAction:action withFrameNum:num];
    
    _initialAction = _action;
    _action = action;
    _repeat = NO;
    CCLOG(@"act");
}

-(void) update:(CCTime)delta{
    _timer++;
    
    _frameArray = _actionMap[_action];
    
    NSInteger numOfFrams = [_frameArray count];
    if(numOfFrams < 1)
        return;
    
    if(_timer == (numOfFrams * gap)){
        _timer = 0;
        if(!_repeat){
            _repeat = YES;
            _action = _initialAction;
            _initialAction = nil;
            return;
        }
    }
    
    int index = 0;
    if(!_pauseAnimation)
        index = self.timer / gap;
        
    CCSpriteFrame *curFrame = [_frameArray objectAtIndex:index];
    [self setSpriteFrame:curFrame];
    return;
}

@end
