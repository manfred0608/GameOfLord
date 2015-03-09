//
//  Level.m
//  GameOfLord
//
//  Created by Manfred on 3/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Level.h"

@implementation Level

-(void) test{
    [self addNewCharacter: @"1-1" withFaceTo: FACE_RIGHT atPos:ccp(5, 12)];
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

-(BOOL) showAction:(CGPoint) newTouch{
    NSArray *pMoves = [self moveToTiles];
    if (_selectedCharacter && [MapHelper containsMoves:pMoves withValue:newTouch]){
        [self selectedMoveTo:newTouch];
        return NO;
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
    if(!_selectedCharacter)
        return;
    
    [self updateGameBoard:_selectedCharacter.indexes withValue:NON_OCCUPIED];
    [self updateGameBoard:indexes withValue:OCCUPIED];
    
    _selectedCharacter.dest = indexes;
}

-(void) addEnemy{
    
}

-(void) addFriend{
    
}

-(void) addSelf{
    
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
            NSMutableArray *row = (NSMutableArray*)[_gameBoard objectForKey:[NSNumber numberWithInt:i]];
            NSInteger status = [[row objectAtIndex:j] integerValue];
            
            BOOL inrange = [MapHelper inRange:_selectedCharacter.indexes withRange: range compareWith: ccp(i, j)];
            if(status == NON_OCCUPIED && inrange){
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
    
    [self updateGameBoard:indexes withValue:OCCUPIED];
    
    [person placeAt:indexes withDest:indexes withScale:[MapHelper cellSize]];
}

-(void) updateGameBoard:(CGPoint)pos withValue:(NSInteger)status{
    NSMutableArray *modifiedRow = [_gameBoard objectForKey:[NSNumber numberWithInt:pos.x]];
    [modifiedRow replaceObjectAtIndex:pos.y withObject:@(status)];
}

@end
