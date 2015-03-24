//
//  Character.h
//  GameOfLord
//
//  Created by Manfred on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Animation.h"

@interface Character : Animation

@property (nonatomic, assign) CGPoint indexes;
@property (nonatomic, assign) CGPoint dest;
@property (nonatomic, assign) CGPoint prev;

@property (nonatomic, assign) NSString* type;
@property (nonatomic, assign) int blood;
@property (nonatomic, assign) int level;
@property (nonatomic, assign) int experience;

@property (nonatomic, assign) int attack;
@property (nonatomic, assign) int def;
@property (nonatomic, assign) int miss;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) NSString *faceTo;

@property (nonatomic, assign) NSRange attackRange;
@property (nonatomic, assign) NSRange moveRange;
@property (nonatomic, assign) BOOL behaved;

-(id) initWithType:(NSString*) type withBlood:(int) blood withLevel:(int) level
    withExperience:(int) experience withAttack:(int) attack withDef:(int) def
    withMiss:(int) miss withName:(NSString*) name withFaceTo:(NSString*) faceTo
    withAttackRange:(NSRange) attackRange withMoveRange:(NSRange) moveRange;

-(void) undo;

-(void) acted;
-(void) actDefault;

-(void) placeAt:(CGPoint) indexes withDest:(CGPoint)dest withScale:(int) scale;

-(void) moveLeft;
-(void) moveRight;
-(void) moveUp;
-(void) moveDown;

-(void) attackTo:(CGPoint)indexes;

-(void) levelUp;
-(void) hittedTo:(CGPoint)indexes;

-(void) dying;

-(void) defTo:(CGPoint)indexes;

@end
