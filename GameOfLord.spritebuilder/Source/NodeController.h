//
//  NodeController.h
//  GameOfLord
//
//  Created by Manfred on 3/9/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface NodeController : NSObject

+(void)process:(int) code withNodeName:(NSString*) name;
+(NSDictionary*)getAllNodes;
+(void)setNodes:(NSDictionary*)allNodes;
@end
