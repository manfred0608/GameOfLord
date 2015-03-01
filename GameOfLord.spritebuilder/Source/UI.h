//
//  UI.h
//  GameOfLord
//
//  Created by Manfred on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface UI : CCNode

@property (nonatomic, strong) Weather *_weatherNode;

- (void)loadUI:(NSString*) name;
@end
