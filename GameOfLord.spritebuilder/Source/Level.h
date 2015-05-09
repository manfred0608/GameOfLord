//
//  Level.h
//  GameOfLord
//
//  Created by Manfred on 3/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Character.h"

@interface Level : CCNode

@property (nonatomic, strong) NSString *levelNo;
@property (nonatomic, strong) Character *selectedCharacter;
@property (nonatomic, strong) NSMutableArray *characters;

@property (nonatomic, assign) int rowNum;
@property (nonatomic, assign) int colNum;
@property (nonatomic, strong) NSMutableDictionary *gameBoard;

-(NSArray*) moveToTiles;
-(NSArray*) attackTiles;

-(void) selectedMoveTo:(CGPoint)indexes;
-(void) selectAttackTo:(CGPoint)indexes;
-(BOOL) showAction:(CGPoint) newTouch withType:(BOOL)attackFlag;


@end
