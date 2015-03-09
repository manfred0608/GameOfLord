//
//  MapHelper.h
//  GameOfLord
//
//  Created by Manfred on 3/6/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapHelper : NSObject

+ (BOOL)inRange:(CGPoint) pos withRange:(NSRange) range compareWith:(CGPoint) another;

+ (BOOL)isLeft:(CGPoint) pos compareWith:(CGPoint) another;
+ (BOOL)isRight:(CGPoint) pos compareWith:(CGPoint) another;

+ (BOOL)isUp:(CGPoint) pos compareWith:(CGPoint) another;
+ (BOOL)isDown:(CGPoint) pos compareWith:(CGPoint) another;

+ (NSString*)relativePos:(CGPoint) pos compareWith:(CGPoint) another;
+ (CGPoint) placeAtIndexes:(CGPoint) indexes;
+ (int)cellSize;
+ (BOOL)containsMoves:(NSArray*) array withValue:(CGPoint) pos;

@end
