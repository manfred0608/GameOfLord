//
//  Constants.m
//  GameOfLord
//
//  Created by Manfred on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

NSString* const MOVE = @"/move/";
NSString* const ATTACK = @"/attack/";
NSString* const DEF = @"/spec/def_";
NSString* const STAND = @"/move/stand_";

int const NUM_MOVE_FRAMES = 2;

int const NUM_STAND_FRAMES = 1;

NSString* const DYING = @"/move/dying_";
int const NUM_DYING_FRAMES = 2;

int const NUM_ATTACK_FRAMES = 4;

int const NUM_DEF_FRAMES = 1;

NSString* const HIT = @"/spec/hit_";
int const NUM_HIT_FRAMES = 1;

NSString* const LEVEL_UP = @"/spec/level_up_";
int const NUM_LEVEL_UP_FRAMES = 1;

NSString* const SUNNY = @"Sunny/";
NSString* const CLOUDY = @"Cloudy/";
NSString* const SNOWY = @"Snowy/";
NSString* const RAINY = @"Rainy/";
NSString* const HEAVY_RAINY = @"Heavy_Rain/";

int const NUM_WEATHER_FRAMES = 4;

NSString* const SELF = @"Self";
NSString* const ENEMY = @"Enemy";
NSString* const NPC = @"Friend";

NSInteger const OCCUPIED = 3;
NSInteger const NON_OCCUPIED = 4;

float const DYING_BLOOD_RATIO = 0.2f;
int const SCALE = 100;

NSString* const FACE_UP = @"up";
NSString* const FACE_DOWN = @"down";
NSString* const FACE_LEFT = @"left";
NSString* const FACE_RIGHT = @"right";

int const CLOSE_USER_INTERACTION = 5;
int const OPEN_USER_INTERACTION = 6;

int const SELECTED_DONE = 7;
int const ARRIVED_DEST = 8;

int const SELECTED_CANCEL = 9;
int const SELECTED_ATTACK = 10;
int const SELECTED_MAGIC = 11;
int const SELECTED_PACKAGE = 12;
