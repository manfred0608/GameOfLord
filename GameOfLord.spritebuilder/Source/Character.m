//
//  Character.m
//  GameOfLord
//
//  Created by Manfred on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Character.h"

const NSString* baseDir = @"GameOfLordAssets/Characters/";
static const float speed = 300.0f;

@implementation Character{
    CCEffectBrightness *_brightnessEffect;
}

-(id) initWithType:(NSString*) type withBlood:(int) blood withLevel:(int) level
    withExperience:(int) experience withAttack:(int) attack withDef:(int) def
    withMiss:(int) miss withName:(NSString*) name withFaceTo:(NSString*) faceTo
    withAttackRange:(NSRange)attackRange withMoveRange:(NSRange)moveRange{
    
    if(self = [super init]){
        _type = type;
        _blood = blood;
        _level = level;
        _experience = experience;
        _attack = attack;
        _def = def;
        _miss = miss;
        _faceTo = faceTo;
        _attackRange = attackRange;
        _moveRange = moveRange;
        _dest = _indexes;
        
        self.frameDir = [NSString stringWithFormat:@"%@%@/%@", baseDir, type, name];
        self.scale = 1.5;
        [self setAnchorPoint:ccp(0, 0)];
    }
    return self;
}

-(void) actDefault{
    NSString *defaultAction = nil;
    
    if(_faceTo == FACE_RIGHT){
        defaultAction = [NSString stringWithFormat:@"%@%@_", MOVE, FACE_LEFT];
        self.flipX = YES;
    }
    
    [self changeAction:defaultAction withFrameNum: NUM_MOVE_FRAMES];
    self.effect = nil;
}

-(void) acted{
    NSString *actedAction= nil;
    
    if(_faceTo == FACE_RIGHT){
        actedAction = [NSString stringWithFormat:@"%@%@_", STAND, FACE_LEFT];
        self.flipX = YES;
    }else
        actedAction = [NSString stringWithFormat:@"%@%@_", STAND, _faceTo];
    
    [self changeAction:actedAction withFrameNum: NUM_STAND_FRAMES];
    
    if(_brightnessEffect == nil)
        _brightnessEffect = [[CCEffectBrightness alloc] initWithBrightness:-0.2f];
    self.effect = _brightnessEffect;
    
    [NodeController process:SELECTED_DONE withNodeName:@"Level"];
}

-(void) moveLeft{
    
    NSString *leftAction = [NSString stringWithFormat:@"%@%@_", MOVE, FACE_LEFT];
    self.flipX = NO;
    
    _faceTo = FACE_LEFT;
    [self changeAction: leftAction withFrameNum: NUM_MOVE_FRAMES];
}

-(void) moveUp{
    NSString *upAction = [NSString stringWithFormat:@"%@%@_", MOVE, FACE_UP];
    self.flipX = NO;
    
    _faceTo = FACE_UP;
    [self changeAction: upAction withFrameNum: NUM_MOVE_FRAMES];
}

-(void) moveRight{
    [self moveLeft];
    self.flipX = YES;
    _faceTo = FACE_RIGHT;
}

-(void) moveDown{
    NSString *downAction = [NSString stringWithFormat:@"%@%@_", MOVE, FACE_DOWN];
    self.flipX = NO;
    
    _faceTo = FACE_DOWN;
    [self changeAction: downAction withFrameNum: NUM_MOVE_FRAMES];
}

-(void) update:(CCTime)delta{
    [NodeController process:CLOSE_USER_INTERACTION withNodeName:@"GamePlay"];
    
    if(CGPointEqualToPoint(_indexes, _dest)){
        [NodeController process:OPEN_USER_INTERACTION withNodeName:@"GamePlay"];
    }else if(_dest.y != _indexes.y){
        int direction = (_dest.y - _indexes.y) > 0? 1: -1;
        
        if(direction > 0) [self moveRight]; else [self moveLeft];
        
        self.position = ccpAdd(self.position, ccp(delta * direction * speed, 0));
        
        if((self.position.x - _dest.y * [MapHelper cellSize]) * direction >= 0){
            CGPoint midPos = ccp(self.indexes.x, _dest.y);
            [self placeAt:midPos withDest:_dest withScale:[MapHelper cellSize]];
            if(_indexes.x == _dest.x){
                [self acted];
                return;
            }
        }
    }else{
        int direction = (_dest.x - _indexes.x) > 0? 1: -1;
        if(direction > 0) [self moveUp]; else [self moveDown];
        
        self.position = ccpAdd(self.position, ccp(0, delta * direction * speed));
        
        if((self.position.y - _dest.x * [MapHelper cellSize]) * direction >= 0){
            [self placeAt:_dest withDest:_dest withScale:[MapHelper cellSize]];
            [self acted];
        }
    }
    [super update:delta];
}

-(void) placeAt:(CGPoint)indexes withDest:(CGPoint)dest withScale:(int)scale{
    _indexes = indexes;
    _dest = dest;
    self.position = ccp(indexes.y * scale, indexes.x * scale);
}

-(void) attackLeft{}

-(void) attackRight{}

-(void) attackUp{}

-(void) attackDown{}

-(void) levelUp{}

-(void) hitted{}

-(void) dying{}

-(void) defLeft{}

-(void) defRight{}

-(void) defUp{}

-(void) defDown{}

@end
