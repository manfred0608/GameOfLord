//
//  Level.m
//  GameOfLord
//
//  Created by Manfred on 3/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Level.h"
#import "Constants.h"
#import "MapHelper.h"

@implementation Level

-(void) test{
    [self addNewCharacter: @"112-1" withFaceTo: FACE_RIGHT atPos:ccp(5, 12)];
    [self addNewCharacter: @"1-1" withFaceTo: FACE_LEFT atPos:ccp(5, 13)];
}

- (void)didLoadFromCCB {    
    _rowNum = _contentSize.height / [MapHelper cellSize];
    _colNum = _contentSize.width / [MapHelper cellSize];
    
    _gameBoard = [[NSMutableDictionary alloc] init];
    _characters = [NSMutableArray array];
    
    for(int i = 0; i < _rowNum; i++){
        NSMutableArray *row = [NSMutableArray arrayWithCapacity:_colNum];
        
        for(int j = 0; j < _colNum; j++)
            [row insertObject:@(NON_OCCUPIED) atIndex: j];
        
        [_gameBoard setObject:row forKey:[NSNumber numberWithInt:i]];
    }
    
    [self test];
    return;
}

-(BOOL) showAction:(CGPoint) newTouch withType:(BOOL)attackFlag{
    NSArray *possibles = nil;
    if (attackFlag) {
        if(_selectedCharacter && [self canAct:newTouch withPlaces:[self attackTiles]]){
            [self selectAttackTo:newTouch];
            return NO;
        }
    }else{
        possibles = [self moveToTiles];
        if (_selectedCharacter && [self canAct:newTouch withPlaces:[self moveToTiles]]){
            [self selectedMoveTo:newTouch];
            return NO;
        }
    }
    
    for(int i = 0; i < [_characters count]; i++){
        Character *cur = [_characters objectAtIndex:i];

        if (CGPointEqualToPoint(cur.indexes, newTouch)) {
            _selectedCharacter = cur;
            return YES;
        }
    }
    _selectedCharacter = nil;
    return NO;
}

-(void) selectedMoveTo:(CGPoint)indexes{
    [self updateGameBoard:_selectedCharacter.indexes withValue:@(NON_OCCUPIED)];
    [self updateGameBoard:indexes withValue:_selectedCharacter];
    
    _selectedCharacter.prev = _selectedCharacter.indexes;
    _selectedCharacter.dest = indexes;
}

-(void) selectAttackTo:(CGPoint)indexes{
    Character* enemy = [self occupied:indexes];
    
    if(self.selectedCharacter.type != ENEMY && enemy.type != ENEMY)
        return;

    if(enemy.type == ENEMY && self.selectedCharacter.type == ENEMY)
        return;
    
    [_selectedCharacter attackTo:enemy.indexes];
    if ([self attackCanBeDodged:self.selectedCharacter withTarget:enemy])
        [enemy defTo:self.selectedCharacter.indexes];
    else{
        [enemy hittedTo:self.selectedCharacter.indexes];
    }
    [self afterAttack:_selectedCharacter withTarget:enemy];
    _selectedCharacter = nil;
}

-(void) addEnemy{
    
}

-(void) addFriend{
    
}

-(void) addSelf{
    
}

-(void) afterAttack:(Character*)attacker withTarget:(Character*)target{
    return;
}

-(BOOL) attackCanBeDodged:(Character*)attacker withTarget:(Character*)target{
    return YES;
}

-(NSArray*) moveToTiles{
    return [self getTiles:self.selectedCharacter.moveRange];
}

-(NSArray*) attackTiles{
    return [self getTiles:self.selectedCharacter.attackRange];
}

-(NSArray*) getTiles:(NSRange)range{
    if(_selectedCharacter == nil)
        return nil;
    
    NSMutableArray *res = [NSMutableArray array];
    int count = 0;
    
    for(int i = 0; i < _rowNum; i++){
        for(int j = 0; j < _colNum; j++){
            BOOL inrange = [MapHelper inRange:_selectedCharacter.indexes withRange: range compareWith: ccp(i, j)];
            if(inrange){
                [res insertObject: [NSValue valueWithCGPoint:ccp(i, j)] atIndex:count];
                count++;
            }
        }
    }
    return res;
}


-(void) addNewCharacter:(NSString*) cname withFaceTo:(NSString*) faceTo atPos:(CGPoint) indexes{
    Character* person = [[Character alloc] initWithType:SELF withBlood:100 withLevel:1 withExperience:0 withAttack:25 withDef:15 withMiss:20 withName:cname withFaceTo:faceTo
        withAttackRange:NSMakeRange(1, 0) withMoveRange:NSMakeRange(1, 4)];
    
    [person actDefault];
    [self addChild:person];
    
    [_characters addObject:person];
    
    [self updateGameBoard:indexes withValue:person];
    
    [person placeAt:indexes withDest:indexes withScale:[MapHelper cellSize]];
}

-(void) updateGameBoard:(CGPoint)pos withValue:(NSObject*)character{
    NSMutableArray *modifiedRow = [_gameBoard objectForKey:[NSNumber numberWithInt:pos.x]];
    [modifiedRow replaceObjectAtIndex:pos.y withObject:character];
}

-(Character*)occupied:(CGPoint)indexes{
    int rowNum = indexes.x;
    int colNum = indexes.y;
    
    NSArray *row = (NSArray*)[_gameBoard objectForKey:[NSNumber numberWithInt:rowNum]];
    
    
    NSObject* status = [row objectAtIndex:colNum];
    
    if([status class]== [Character class])
        return (Character*)[row objectAtIndex:colNum];
    else
        return nil;
}

-(BOOL)canAct:(CGPoint)indexes withPlaces:(NSArray*) possibles{
    if ([MapHelper containsMoves:possibles withValue:indexes] && ![self occupied:indexes])
        return YES;
    else
        return NO;
}

@end
