//
//  Option.m
//  GameOfLord
//
//  Created by Manfred on 3/16/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Option.h"
#import "NodeController.h"
#import "MapHelper.h"
#import "Constants.h"

@implementation Option

-(void) selectAttack{
    //CCNode *level = [[NodeController getAllNodes] objectForKey:@"Level"];

    self.visible = NO;
    
    [NodeController characterAction:SELECTED_ATTACK];
}

-(void) selectMagic{
    
}

-(void) selectPackage{
    
}

-(void) selectDone{
    _visible = NO;
    [NodeController characterAction:SELECTED_DONE];
}

-(void) selectCancel{
    _visible = NO;
    [NodeController characterAction:SELECTED_CANCEL];
}
@end
