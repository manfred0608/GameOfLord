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

-(void) selectedMoveTo:(CGPoint)indexes{
    if(!_selectedCharacter)
        return;
    
    [self updateGameBoard:_selectedCharacter.indexes withValue:NON_OCCUPIED];
    [self updateGameBoard:indexes withValue:OCCUPIED];
    
    _selectedCharacter.dest = indexes;
}

-(void) update:(CCTime)delta{
    
}

-(void) addEnemy{
    
}

-(void) addFriend{
    
}

-(void) addSelf{
    
}

-(NSMutableArray*) moveToTiles{
    if(_selectedCharacter == nil)
        return nil;
    
    NSMutableArray *res = [NSMutableArray array];
    int count = 0;
    
    for(int i = 0; i < _rowNum; i++){
        for(int j = 0; j < _colNum; j++){
            NSMutableArray *row = (NSMutableArray*)[_gameBoard objectForKey:[NSNumber numberWithInt:i]];
            NSInteger status = [[row objectAtIndex:j] integerValue];
            
            BOOL inrange = [MapHelper inRange:_selectedCharacter.indexes withRange: _selectedCharacter.moveRange compareWith: ccp(i, j)];
            if(status == NON_OCCUPIED && inrange){
                [res insertObject: [NSValue valueWithCGPoint:ccp(i, j)] atIndex:count];
                count++;
            }
        }
    }
    return res;
}

/*
-(NSArray*) attackTiles{
    if(_selectedCharacter)
        return nil;
}
*/


-(void) addNewCharacter:(NSString*) cname withFaceTo:(NSString*) faceTo atPos:(CGPoint) indexes{
    Character* person = [[Character alloc] initWithType:SELF withBlood:100 withLevel:1 withExperience:0 withAttack:25 withDef:15 withMiss:20 withName:cname withFaceTo:faceTo
        withAttackRange:NSMakeRange(1, 0) withMoveRange:NSMakeRange(1, 10)];
    
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
