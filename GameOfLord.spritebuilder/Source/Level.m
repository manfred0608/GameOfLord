//
//  Level.m
//  GameOfLord
//
//  Created by Manfred on 3/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Level.h"
static const int CELL_SIZE = 36;

@implementation Level{
    int rowNum;
    int colNum;
}

// is called when CCB file has completed loading
- (id) initLevel {
    self = (Level *) [CCBReader load: @"Levels/Level1-1"];
    
    rowNum = _contentSize.height / CELL_SIZE;
    colNum = _contentSize.width / CELL_SIZE;
    
    return self;
}

-(void) placeSelector:(CGPoint) touchLocation{    
    int col = touchLocation.x / CELL_SIZE;
    int row = touchLocation.y / CELL_SIZE;
    
    _selector.position = ccp(col * CELL_SIZE, row * CELL_SIZE);
}

@end
