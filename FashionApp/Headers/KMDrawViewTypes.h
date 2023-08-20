//
//  KMDrawViewTypes.h
//  KMEAGLViewDemo
//
//  Created by zhudongyong on 13-9-23.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#ifndef KMEAGLViewDemo_KMDrawViewTypes_h
#define KMEAGLViewDemo_KMDrawViewTypes_h

/// The framework exports macro definitions
#pragma mark - The framework exports macro definitions
// Drawing pattern recognition
#define EnableRecogition    1 //Enable graphic recognition
// Digital pen & Stylus support
#define kDigitPenEnable     (1 && TARGET_OS_IOS)//(Digital pen)
// Platform bundling
#define kPlatformBinding    0

///Digital pen related configuration
#if kDigitPenEnable
//Whether Adoint stylus is supported
#define kEnableJotPen       0
//Whether to support the Pogo stylus
#define kEnablePogoPen      0
//Whether to support the Hex3 company stylus
#define kEnableJajaPen      0
//Whether the Wacom stylus is supported
#define kEnableWacomPen     0

#if kEnableJotPen
//Anti-miscontact function, JotTouch
#define kRejectModeEnable   0
#endif//kEnableJotPen

#endif//kDigitPenEnable


/// Background print information definition
#pragma mark - Background print information definition
#ifndef KMPLog
#if DEBUG
#define KMPLog(...) NSLog(__VA_ARGS__)
#else
#define KMPLog(...) {}
#endif//DEBUG
#endif//KMPLog

#ifndef KMPPrintf
#if DEBUG
#define KMPPrintf(...) printf(__VA_ARGS__)
#else
#define KMPPrintf(...) {}
#endif//DEBUG
#endif//KMPPrintf


///Shape Recognizer
#if EnableRecogition
#pragma mark - Shape Recognizer
/**
 //ShapeTypeLine            :<LineOutput>       line
 //ShapeTypeTriangle        :<TriangleOutput>   triangle
 //ShapeTypeCircle          :<CircleOutput>     circle
 //ShapeTypeEllipse         :<EllipseOutput>    ellipse
 //ShapeTypeDiarec          :<DiaRecOutput>     diarec
 //ShapeTypeFoldLine        :<FoldLineType>     foldLineOutput
 //ShapeTypeCurve           :<CurveType>        curveOutput
 //ShapeTypeArrow           :<ArrowType>        arrowOutput
 //ShapeTypeParallelogram   :<TypeParallelogram>   parallelogram
 */
typedef enum {
    ShapeTypeUnknow         = 0,     //Unknow shape
    ShapeTypeLine           = 0x0001,//Line
    ShapeTypeTriangle       = 0x0002,//Triangle
    ShapeTypeCircle         = 0x0004,//Circle
    ShapeTypeEllipse        = 0x0008,//Ellipse
    ShapeTypeDiarec         = 0x0010,//Rectangle
    ShapeTypeFoldLine       = 0x0020,//Fold Line
    ShapeTypeDiamond        = 0x0040,//Diamond
    ShapeTypeCurve          = 0x0080,//Curve
    ShapeTypeArrow          = 0x0100,//Arrow
    ShapeTypeParallelogram  = 0x0200,//Parallelogram
    ShapeTypeArrowsystem    = 0x0400,//Arrow system
    ShapeTypeAllShapes      = 0xffff,//All Shapes
}ShapeType;
#endif


/**
 * Angle control type, used to control the angle variation of points on the line during graphic drawing.
 */
typedef NS_ENUM(NSUInteger, ESRadianControlType) {
    ESRadianControlTypeNone             = 0,    //Close
    ESRadianControlTypeDissolving       = 1,    //Dissolving
    ESRadianControlTypeIncreasing       = 2,    //Increasing
    ESRadianControlTypeMixPressure      = 3,    //Mix pressure with speed control
    ESRadianControlTypeOppMixPressure   = 4,    //Mix reverse pressure with speed control
    ESRadianControlTypeStartRadian      = 5,    //Start angle
    ESRadianControlTypeMoveRadian       = 6,    //Direction of movement
    ESRadianControlTypeMixAltitude      = 7,    //Mix altitude with Speed control,Stylus support is required
    ESRadianControlTypeOppMixAltitude   = 8,    //Mix reverse altitude with speed control,Stylus support is required
    ESRadianControlTypePurePressure     = 9,    //Pressure control
    ESRadianControlTypeOppPurePressure  = 10,   //Reverse pressure control
    ESRadianControlTypePureAltitude     = 11,   //Altitude control, Stylus support is required
    ESRadianControlTypeOppPureAltitude  = 12,   //Reverse altitude control, Stylus support is required
#if !TARGET_OS_IOS
    ESRadianControlTypePenWheel         = 13,    //Pen wheel, Stylus support is required
    ESRadianControlTypeRotate           = 14,    //Rotate,Stylus support is required
#endif
};

typedef NS_ENUM(NSUInteger, ESRoundnessControlType) {
    ESRoundnessControlTypeNone              = 0,    //Close
    ESRoundnessControlTypeDissolving        = 1,    //Dissolving
    ESRoundnessControlTypeIncreasing        = 2,    //Increasing
    ESRoundnessControlTypeMixPressure       = 3,    //Mix pressure with speed control
    ESRoundnessControlTypeOppMixPressure    = 4,    //Mix reverse pressure with speed control
    ESRoundnessControlTypeMixAltitude       = 5,    //Mix altitude with Speed control,Stylus support is required
    ESRoundnessControlTypeOppMixAltitude    = 6,    //Mix reverse altitude with speed control,Stylus support is required
    ESRoundnessControlTypePurePressure      = 7,    //Pressure control
    ESRoundnessControlTypeOppPurePressure   = 8,    //Reverse pressure control
    ESRoundnessControlTypePureAltitude      = 9,    //Altitude control, Stylus support is required
    ESRoundnessControlTypeOppPureAltitude   = 10,   //Reverse altitude control, Stylus support is required
#if !TARGET_OS_IOS
    ESRoundnessControlTypePenWheel          = 11,    //Pen wheel, Stylus support is required
    ESRoundnessControlTypeRotate            = 12,    //Rotate,Stylus support is required
#endif
};

typedef NS_ENUM(NSUInteger, ESColorControlType) {
    ESColorControlTypeNone              = 0,        //Close
    ESColorControlTypeDissolving        = 1,        //Dissolving
    ESColorControlTypeIncreasing        = 2,        //Increasing
    ESColorControlTypeMixPressure       = 3,        //Mix pressure with speed control
    ESColorControlTypeOppMixPressure    = 4,        //Mix reverse pressure with speed control
    ESColorControlTypeMixAltitude       = 5,        //Mix altitude with Speed control,Stylus support is required
    ESColorControlTypeOppMixAltitude    = 6,        //Mix reverse altitude with speed control,Stylus support is required
    ESColorControlTypePurePressure      = 7,        //Pressure control
    ESColorControlTypeOppPurePressure   = 8,        //Reverse pressure control
    ESColorControlTypePureAltitude      = 9,        //Altitude control, Stylus support is required
    ESColorControlTypeOppPureAltitude   = 10,       //Reverse altitude control, Stylus support is required
#if !TARGET_OS_IOS
    ESColorControlTypePenWheel          = 11,        //Pen wheel, Stylus support is required
    ESColorControlTypeRotate            = 12,        //Rotate,Stylus support is required
#endif
};

typedef NS_ENUM(NSUInteger, ESDistributionControlType) {
    ESDistributionControlTypeNone               = 0,   //Close
    ESDistributionControlTypeDissolving         = 1,   //Dissolving
    ESDistributionControlTypeIncreasing         = 2,   //Increasing
    ESDistributionControlTypeMixPressure        = 3,   //Mix pressure with speed control
    ESDistributionControlTypeOppMixPressure     = 4,   //Mix reverse pressure with speed control
    ESDistributionControlTypeMixAltitude        = 5,   //Mix altitude with Speed control,Stylus support is required
    ESDistributionControlTypeOppMixAltitude     = 6,   //Mix reverse altitude with speed control,Stylus support is required
    ESDistributionControlTypePurePressure       = 7,   //Pressure control
    ESDistributionControlTypeOppPurePressure    = 8,   //Reverse pressure control
    ESDistributionControlTypePureAltitude       = 9,   //Altitude control, Stylus support is required
    ESDistributionControlTypeOppPureAltitude    = 10,  //Reverse altitude control, Stylus support is required
#if !TARGET_OS_IOS
    ESDistributionControlTypePenWheel           = 11,   //Pen wheel, Stylus support is required
    ESDistributionControlTypeRotate             = 12,   //Rotate,Stylus support is required
#endif
};

typedef NS_ENUM(NSUInteger, ESDistributionCountControlType) {
    ESDistributionCountControlTypeNone              = 0,      //Close
    ESDistributionCountControlTypeDissolving        = 1,      //Dissolving
    ESDistributionCountControlTypeIncreasing        = 2,      //Increasing
    ESDistributionCountControlTypeMixPressure       = 3,      //Mix pressure with speed control
    ESDistributionCountControlTypeOppMixPressure    = 4,      //Mix reverse pressure with speed control
    ESDistributionCountControlTypeMixAltitude       = 5,      //Mix altitude with Speed control,Stylus support is required
    ESDistributionCountControlTypeOppMixAltitude    = 6,      //Mix reverse altitude with speed control,Stylus support is required
    ESDistributionCountControlTypePurePressure      = 7,      //Pressure control
    ESDistributionCountControlTypeOppPurePressure   = 8,      //Reverse pressure control
    ESDistributionCountControlTypePureAltitude      = 9,      //Altitude control, Stylus support is required
    ESDistributionCountControlTypeOppPureAltitude   = 10,     //Reverse altitude control, Stylus support is required
#if !TARGET_OS_IOS
    ESDistributionCountControlTypePenWheel          = 11,      //Pen wheel, Stylus support is required
    ESDistributionCountControlTypeRotate            = 12,      //Rotate,Stylus support is required
#endif
};

typedef NS_ENUM(NSUInteger, ESLineFrontTextureControlType) {
    ESLineFrontTextureControlTypeNone               = 0,     //Close
    ESLineFrontTextureControlTypeDissoloving        = 1,     //Dissolving
    ESLineFrontTextureControlTypeIncreasing         = 2,     //Increasing
    ESLineFrontTextureControlTypeMixPressure        = 3,     //Mix pressure with speed control
    ESLineFrontTextureControlTypeOppMixPressure     = 4,     //Mix reverse pressure with speed control
    ESLineFrontTextureControlTypeMixAltitude        = 5,     //Mix altitude with Speed control,Stylus support is required
    ESLineFrontTextureControlTypeOppMixAltitude     = 6,     //Mix reverse altitude with speed control,Stylus support is required
    ESLineFrontTextureControlTypePurePressure       = 7,     //Pressure control
    ESLineFrontTextureControlTypeOppPurePressure    = 8,     //Reverse pressure control
    ESLineFrontTextureControlTypePureAltitude       = 9,     //Altitude control, Stylus support is required
    ESLineFrontTextureControlTypeOppPureAltitude    = 10,    //Reverse altitude control, Stylus support is required
#if !TARGET_OS_IOS
    ESLineFrontTextureControlTypePenWheel           = 11,     //Pen wheel, Stylus support is required
    ESLineFrontTextureControlTypeRotate             = 12,     //Rotate,Stylus support is required
#endif
};

typedef NS_ENUM(NSUInteger, ESOpacityControlType) {
    ESOpacityControlTypeNone            = 0,    //Close
    ESOpacityControlTypeDissolving      = 1,    //Dissolving
    ESOpacityControlTypeIncreasing      = 2,    //Increasing
    ESOpacityControlTypeMixPressure     = 3,    //Mix pressure with speed control
    ESOpacityControlTypeOppMixPressure  = 4,    //Mix reverse pressure with speed control
    ESOpacityControlTypeMixAltitude     = 5,    //Mix altitude with Speed control,Stylus support is required
    ESOpacityControlTypeOppMixAltitude  = 6,    //Mix reverse altitude with speed control,Stylus support is required
    ESOpacityControlTypePurePressure    = 7,    //Pressure control
    ESOpacityControlTypeOppPurePressure = 8,    //Reverse pressure control
    ESOpacityControlTypePureAltitude    = 9,    //Altitude control, Stylus support is required
    ESOpacityControlTypeOppPureAltitude = 10,   //Reverse altitude control, Stylus support is required
#if !TARGET_OS_IOS
    ESOpacityControlTypePenWheel        = 11,    //Pen wheel, Stylus support is required
#endif
};

typedef NS_ENUM(NSUInteger, ESFlowControlType) {
    ESFlowControlTypeNone               = 0,   //Close
    ESFlowControlTypeDissolving         = 1,   //Dissolving
    ESFlowControlTypeIncreasing         = 2,   //Increasing
    ESFlowControlTypeMixPressure        = 3,   //Mix pressure with speed control
    ESFlowControlTypeOppMixPressure     = 4,   //Mix reverse pressure with speed control
    ESFlowControlTypeMixAltitude        = 5,   //Mix altitude with Speed control,Stylus support is required
    ESFlowControlTypeOppMixAltitude     = 6,   //Mix reverse altitude with speed control,Stylus support is required
    ESFlowControlTypePurePressure       = 7,   //Pressure control
    ESFlowControlTypeOppPurePressure    = 8,   //Reverse pressure control
    ESFlowControlTypePureAltitude       = 9,   //Altitude control, Stylus support is required
    ESFlowControlTypeOppPureAltitude    = 10,  //Reverse altitude control, Stylus support is required
#if !TARGET_OS_IOS
    ESFlowControlTypePenWheel           = 11,   //Pen wheel, Stylus support is required
#endif
};

typedef NS_ENUM(NSUInteger, ESRadiusRelationType) {
    ESRadiusRelationTypeNone,           //None
    ESRadiusRelationTypeDifferential,   //Difference correlation
    ESRadiusRelationTypeRatio,          //Ratio correlation
};

#endif
