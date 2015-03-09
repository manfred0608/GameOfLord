//
//  NodeController.m
//  GameOfLord
//
//  Created by Manfred on 3/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "NodeController.h"
#import "Level.h"

static NSMutableDictionary *nodes;
@implementation NodeController

+(void)process:(int) code withNodeName:(NSString*) name{
    CCNode* node = (CCNode*) [nodes objectForKey:name];
    
    if (code == CLOSE_USER_INTERACTION)
        node.userInteractionEnabled = NO;
    
    if (code == OPEN_USER_INTERACTION)
        node.userInteractionEnabled = YES;
    
    if(code == SELECTED_DONE)
        ((Level*)node).selectedCharacter = nil;
}

+(NSDictionary*)getAllNodes{
    return nodes;
}

+(void)setNodes:(NSDictionary*)allNodes{
    nodes = (NSMutableDictionary*)allNodes;
}
@end
