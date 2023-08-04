//
//  LineProcess.h
//  EAGLViewDemo
//
//  Created by zhudongyong on 13-9-9.
//  Copyright (c) 2013年 zhudongyong. All rights reserved.
//

/** LineProcess is a set of calculation library used for point and line processing in the drawing module, which can make different Settings of parameters in it to produce completely different effects
 */

#ifndef EAGLViewDemo_LineProcess_h
#define EAGLViewDemo_LineProcess_h

#import <stdio.h>
#import <stdlib.h>
#import <math.h>
#import <time.h>
#import "LineProcessTypes.h"

/**
 * Property setting
 *
 *@param type    Parameter type to be set
 *@param value   The value to be set
 */
LPVoid lpSetPropertyi(LPPropertyType type, int value);
LPVoid lpSetPropertyd(LPPropertyType type, double value);
LPVoid lpSetPropertyf(LPPropertyType type, float value);
LPVoid lpSetPropertyb(LPPropertyType type, bool value);

/**
 * Read property value
 *
 * @param type    Parameter type to be read
 * @return `type`The value of the parameter
 */
int     lpGetPropertyi(LPPropertyType type);
double  lpGetPropertyd(LPPropertyType type);
float   lpGetPropertyf(LPPropertyType type);
bool    lpGetPropertyb(LPPropertyType type);

/**
 * Set parameter object
 *
 * @param obj The parameter object to set
 * @return The previous parameter object
 */
LPParaObj* lpSetParaObj(LPParaObj *obj);

/**
 * Gets the processed point, dimension value, and alternate attribute value of the last segment of the current line
 *
 * @param points   The address of a pointer to an array of points
 *       - sizes   The address of a pointer to an array of point sizes
 *       - values  The address of a pointer to an array of alternate attribute values at each point
 *
 * @return Process the data of the resulting points
 */
LPUInteger lpGetLastLineSegmentPoints1V(LPPoint **points);

/**
 * Start processing a new line
 *
 * @param position    The beginning of a new line
 * @param pressure    The starting pressure value of the new line
 * @param ascent      The starting ascent value of the new line
 */
LPVoid  lpStartLine(LPPosition position);
LPVoid  lpStartLineWithPressure(LPPosition position, LPFloat pressure);
LPVoid  lpStartLineWithParams(LPPosition position, LPFloat pressure, LPFloat ascent);

LPUInteger lpAppendingLine(LPPosition position, bool isEnd);
LPUInteger lpAppendingLineWithPressure(LPPosition position, bool isEnd, LPFloat pressure);
LPUInteger lpAppendingLineWithParams(LPPosition position, bool isEnd, LPFloat pressure, LPFloat ascent);

/**
 1:lpStartLine 0     {0,0}
 2:lpAppendingLine 1-2:n {10, 10}
 3:lpAppendingLine 2-3:n
 lpAppendingLine
 */

#endif
