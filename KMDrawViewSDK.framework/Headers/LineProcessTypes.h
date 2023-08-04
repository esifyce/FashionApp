//
//  LineProcessTypes.h
//  KMDrawViewDemo
//
//  Created by zhudongyong on 14-3-15.
//  Copyright (c) 2014年 kdanmobile. All rights reserved.
//

#ifndef KMDrawViewDemo_LineProcessTypes_h
#define KMDrawViewDemo_LineProcessTypes_h

#include <string.h>
#include <stdbool.h> //C99
#include <stddef.h>
#include <float.h>


#define PreModelEnable      1

typedef float LPFloat;
typedef void LPVoid;
typedef unsigned int LPUInteger;
typedef double LPDouble;
typedef int LPInteger;
typedef bool LPBool;

#define LPEPS (1e-3)
#define LQ(a,b) ((a)<(b)+LPEPS)
#define EQ(a,b) (fabs((a)-(b))<LPEPS)
#define GQ(a,b) ((a)>(b)-LPEPS)


/** Point control parameter
 */
struct LPControlParams {
    LPFloat pressure;   //Pressure control value, such as apple pencil
    LPFloat altitude;   //Altitude control value, such as apple pencil
    LPFloat speed;      //Speed control value. Suitable for finger and digital pen
};
typedef struct LPControlParams LPControlParams;

#define FLOAT_ZERO              0.0000
#define isZero(value)           (fabs(value) <= FLOAT_ZERO)
#define isControlDisable(ctl)   (isZero(ctl.pressure) && isZero(ctl.altitude) && isZero(ctl.speed))


/** Point type, consistent with iOS platform CGPoint
 */
struct LPPosition {
    LPFloat x;
    LPFloat y;
};
typedef struct LPPosition LPPosition;

/**
 */
struct LPPoint {
    LPPosition      position;
    LPFloat         size;
    LPControlParams controlParams;
};
typedef struct LPPoint LPPoint;

typedef struct _LPTrace
{
    LPPoint*    points;
    LPUInteger  number;
    LPUInteger  volume;
}LPTrace;





/**
 * @discussion Line drawing status information*
 */
typedef enum {LPStateBegin, LPStateBegining, LPStateDrawing, LPStateEnd} LPState;



typedef enum {
    LPControlTypeNone = 0,
    LPControlTypeDisappear,     //Fade away or become smaller
    LPControlTypeEnhance,       //Gradually enlarge
    LPControlTypeMixPressure,   //Mixing pressure, pressure and speed mixing control
    LPControlTypeInvMixPressure,//Reverse mixing pressure, pressure and speed mixing control
    LPControlTypeMixAltitude,   //Mixing slope, pressure and altitude mixing control
    LPControlTypeOppMixAltitude,//Reverse mixing slope, pressure and altitude mixing control
    LPControlTypePurePressure,  //Pressure control
    LPControlTypeInvPurePressure,//Reverse pressure control
    LPControlTypePureAltitude,  //Altitude control
    LPControlTypeOppPureAltitude,//Reverse altitude control
    LPControlTypeMixParams,      //Pressure and altitude control
}LPControlType;


typedef struct _LPParaObj
{
    //Point size, in pixels
    LPFloat radius;
    
    //Whether to receive pressure parameters
    LPBool pressureEnabled;
    
    //Whether to altitude the slope parameter
    LPBool altitudeEnabled;
    
    //Dot spacing switch, Default is YES
    LPBool pointsDistanceEnabled;
    
    //Dot spacing percentage of dot size, default 25%, range [1%,1000%]
    LPFloat pointsDistancePercent;
    
    //The default value is 0%. In this case, the jitter does not occur. The jitter range is 0,100%
    LPFloat radiusJitterPercent;
    
    // Point size dynamic control
    LPControlParams radiusControl;
    
    //Minimum diameter percentage of point size, default 100%, range [0,100%]
    LPFloat minRadiusPercent;
    
    //Maximum diameter percentage of point size, default 100%, range [0, 1]
    LPFloat maxRadiusPercent;
    
    //Smoothing option, which is turned off by default, controls whether Bezier curves are smoothed
    LPBool smoothEnabled;
    
    //Speed control sensitivity factor, range [0.0,1.0], default is 0.5
    LPFloat speedSensitive;
    
    //Speed control scale, range [10,300], default is 40, together with the sensitivity factor controls the size of points caused by speed
    LPFloat speedScale;
    
    //The percentage of the starting point size to the size, default 1, range [0,5], maximum 5 times the size of the point
    LPFloat startRadiusPercent;
    
    //The percentage of the size of the end point. The default is 1, the range is 0,5, and the maximum size is 5
    LPFloat endRadiusPercent;
    
    //Control the tracking speed of the mouse. The range is 0,10. The default value is 0, which indicates the real-time tracking of the mouse
    LPInteger trackParam;
    
    //Duration distance
    LPFloat startDurDistance;
    
    
    /**
     * private
     */
    //Current status of line drawing. Default is the start status of line drawing
    LPState state;
    
    //The position of the last mouse click
    LPPosition lastTouchPosition;
    
    //The position of the point in the previous paragraph
    LPPosition lastSegPosition;
    
    //The position of the midpoint of the previous paragraph (before the previous point)
    LPPosition lastSegMidPosition;
    
    //The distance from the last line drawn
    LPFloat offsetDistance;
    
    //The current total distance of the line
    LPFloat totalDistance;
    
    //The current total number of points on the line
    LPUInteger totalPointNum;
    
    //The size of the last point
    LPFloat lastPointRadius;
    
    //The average pressure of the previous section, the pressure value range is [0,1]
    LPFloat lastSegPressure;
    
    //The Angle size of the previous paragraph, Angle range is [0,1], converted to the corresponding Angle, Angle range is [90, 0]
    LPFloat lastSegAltitude;
    
    //The magnitude of the velocity in the last paragraph. The value ranges from 0 to 1.
    LPFloat lastSegSpeed;
    
    //The number of mouse events for the current segment
    LPInteger mouseTouchNum;
    
    //The total distance of the current segment
    LPFloat segTotalDistance;
    
    //The total pressure of the current segment
    LPFloat segTotalPressure;
    
    //The total Altitude of the current segment
    LPFloat segTotalAltitude;
    
    //The length of the last paragraph
    LPFloat lastSegDistance;
    
    //Minimum point spacing
    LPFloat minPointDistance;
}LPParaObj;




typedef enum {
    /**
     * @discussion Line handling parameters: unknown parameter type
     */
    LPPropertyTypeUnknow                = 0,
    
    /**
     * @discussion Line handling parameter: Radius, a float parameter
     */
    LPPropertyTypeRadius,
    
    /**
     *@discussion Line handling parameter: dot - distance switch, a bool parameter
     */
    LPPropertyTypePointsDistanceEnabled,
    
    /**
     * @discussion Line handling parameter: Spacing, a float parameter representing the spacing between two points as a percentage of the point's diameter
     */
    LPPropertyTypePointsDistancePercent,
    
    /**
     * @discussion Line processing parameter: Shape dynamic switch, a bool value
     */
    LPPropertyTypeRadiusJitterSwitch,
    
    /**
     * @discussion Line handling parameter: Size jitter, a float parameter, is a percentage that represents the value of jitter as a percentage of radius
     */
    LPPropertyTypeRadiusJitterPercent,
    
    /**
     * @discussion Radius velocity control value
     */
    LPPropertyTypeRadiusSpeedControl,
    
    /**
     * @discussion Radius pressure control value
     */
    LPPropertyTypeRadiusPressControl,
    
    /**
     * @discussion Radius altitude control value
     */
    LPPropertyTypeRadiusAltitudeControl,
    
    
    /**
     * @discussion Line handling parameters: minimum diameter
     */
    LPPropertyTypeMinRadiusPercent,
    
    /**
     * @discussion Line handling parameters: maximum diameter
     */
    LPPropertyTypeMaxRadiusPercent,
    
    /**
     * @discussion Line handling parameter: Smoothing option, a bool parameter
     */
    LPPropertyTypeSmoothEnabled,
    
    /**
     * @discussion Line handling parameter: Control whether reverse, a bool parameter
     */
    LPPropertyTypeInverControl,
    
    /**
     * @discussion Line handling parameter: Speed sensitive factor, a float parameter
     */
    LPPropertyTypeSpeedSensitive,
    
    /**
     * @discussion Line handling parameter: Scale of speed, a float parameter
     */
    LPPropertyTypeSpeedScale,
    
    /**
     * @discussion Line handling parameter: Percentage of starting point size, a float parameter
     */
    LPPropertyTypeStartRadiusPercent,
    
    /**
     * @discussion Line handling parameter: Percentage of the size of the end point, a float parameter
     */
    LPPropertyTypeEndRadiusPercent,
    
    /**
     * @discussion Line handling parameter: Slow down the mouse tracking speed parameter, an int parameter
     */
    LPPropertyTypeTrackParam,
    
    /**
     * @discussion Line handling parameter: Duration distance, a float parameter
     */
    LPPropertyTypestartDurDistance,
    
    /**
     * @discussion Line handling parameter: pressure speed control mode, an unsigned int type parameter
     */
    LPPropertyTypeStyle,
    
    /**
     * @discussion Minimum spacing between lines. Default is 0.5
     */
    LPPropertyTypeMinPointDistance,
}LPPropertyType;


#endif
