//
//  Animation.h
//  GameOfLord
//
//  Created by Manfred on 3/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "MapHelper.h"
#import "Constants.h"
#import "NodeController.h"

@interface Animation : CCSprite

@property (nonatomic, strong) NSString *frameDir;
@property (nonatomic, strong) NSString *action;
@property (nonatomic, assign) int timer;
@property (nonatomic, assign) CGSize frameSize;
@property (nonatomic, strong) NSMutableDictionary *actionMap;

-(void) addAction:(NSString*) action withFrameNum:(NSInteger) num;

-(void) changeAction:(NSString*) action withFrameNum:(NSInteger) num;

-(void) resetActionFrames:(NSString*) dir withActionName:(NSString*) action
        withFrameNum:(NSInteger) num;

-(id) init;
-(id) initWithFrameDir:(NSString*) dir;

-(void) loadWithAction:(NSString*) action withFrameNum:(NSInteger) num;

@end
