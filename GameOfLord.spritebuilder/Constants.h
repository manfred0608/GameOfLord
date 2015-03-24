//
//  Constants.h
//  GameOfLord
//
//  Created by Manfred on 3/1/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#ifndef GameOfLord_Constants_h
#define GameOfLord_Constants_h

extern NSString* const MOVE;
extern NSString* const ATTACK;
extern NSString* const DEF;
extern NSString* const STAND;

extern int const NUM_MOVE_FRAMES;

extern int const NUM_STAND_FRAMES;

extern NSString * const DYING;
extern int const NUM_DYING_FRAMES;

extern int const NUM_ATTACK_FRAMES;

extern int const NUM_DEF_FRAMES;

extern NSString * const HIT;
extern int const NUM_HIT_FRAMES;

extern NSString * const LEVEL_UP;
extern int const NUM_LEVEL_UP_FRAMES;

extern NSString * const SUNNY;
extern NSString * const CLOUDY;
extern NSString * const SNOWY;
extern NSString * const RAINY;
extern NSString * const HEAVY_RAINY;
extern int const NUM_WEATHER_FRAMES;

extern NSString* const SELF;
extern NSString* const ENEMY;
extern NSString* const NPC;

extern NSInteger const OCCUPIED;
extern NSInteger const NON_OCCUPIED;

extern float const DYING_BLOOD_RATIO;
extern int const SCALE;

extern NSString* const FACE_UP;
extern NSString* const FACE_DOWN;
extern NSString* const FACE_LEFT;
extern NSString* const FACE_RIGHT;

extern int const CLOSE_USER_INTERACTION;
extern int const OPEN_USER_INTERACTION;

extern int const SELECTED_DONE;
extern int const ARRIVED_DEST;
extern int const SELECTED_CANCEL;
extern int const SELECTED_ATTACK;
extern int const SELECTED_MAGIC;
extern int const SELECTED_PACKAGE;
#endif
