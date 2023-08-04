//
//  Tools.h
//  EAGLViewDemo
//
//  Created by zhudongyong on 12-11-14.
//  Copyright (c) 2012年 zhudongyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/CALayer.h>
#import "math.h"

#define CompareString(str1,str2)    strcmp([str1 UTF8String], [str2 UTF8String])

#define MINFLOAT    0.0000
#define MINDOUBLE   0.000000000000

#pragma mark - C method
CGPoint* CreateArc(int segments, float x, float y, float width, float height, float r, float startAngle, float endAngle);

CGPoint* CreateEllipses(int segments, float x, float y, float width, float height, float radian);

NSUInteger ExponentialWithInter(int value);

CGRect RectWithSize(CGSize size);

CGSize CGSizeApplyRotation(CGSize size, float radian);

float RadianF(CGPoint p1, CGPoint p2);

long double RadianLD(CGPoint p1, CGPoint p2);

#pragma mark - Object-c method
@interface Tools : NSObject

+ (NSString*)dateString;

+ (NSInteger)randInteger;

+ (int)randValueBegin:(int)begin end:(int)end;

+ (int)string:(NSString*)str1 isThanString:(NSString*)str2;

@end