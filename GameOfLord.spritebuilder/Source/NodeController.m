//
//  NodeController.m
//  GameOfLord
//
//  Created by Manfred on 3/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "NodeController.h"
#import "Level.h"
#import "Constants.h"
#import "MapHelper.h"
#import "Character.h"
#import "GamePlay.h"
#import "Option.h"

static NSMutableDictionary *nodes;
@implementation NodeController

+(void)process:(int) code withNodeName:(NSString*) name{
    CCNode* node = (CCNode*) [nodes objectForKey:name];
    
    if (code == CLOSE_USER_INTERACTION)
        node.userInteractionEnabled = NO;
    
    if (code == OPEN_USER_INTERACTION)
        node.userInteractionEnabled = YES;
}

+(void)arrived{
    CCNode *contentNode = (CCNode*) [nodes objectForKey:@"Content"];
    Option *optionNode = (Option*) [nodes objectForKey:@"Options"];
    Level *level = (Level*) [nodes objectForKey:@"Level"];
    [MapHelper placeOptionNode:optionNode withCharacter:level.selectedCharacter withLevel:level withWorld:contentNode];
}

+(void)characterAction:(int) code{
    Level *level = (Level*) [nodes objectForKey:@"Level"];
    
    if(code == SELECTED_CANCEL){
        [level.selectedCharacter undo];
        level.selectedCharacter = nil;
        [GamePlay setAttackFlag:NO];
        //[game];
    }
    if(code == SELECTED_DONE){
        [level.selectedCharacter acted];
    }
    
    if(code == SELECTED_ATTACK){
        [MapHelper cleanUpSelect:@"moveTile" withNode:level];
        [MapHelper placeTiles:[level attackTiles] withName:@"attackTile" withCCBName:@"Selectors/Red" withNode:level];
        [GamePlay setAttackFlag:YES];
    }
    
    if(code == SELECTED_MAGIC){
        
    }
    
    if (code == SELECTED_PACKAGE) {
        
    }
}

+(NSDictionary*)getAllNodes{
    return nodes;
}

+(void)setNodes:(NSDictionary*)allNodes{
    nodes = (NSMutableDictionary*)allNodes;
}
@end
