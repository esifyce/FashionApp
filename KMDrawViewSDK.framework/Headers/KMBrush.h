//
//  KMBrush.h
//  KMDrawViewDemo
//
//  Created by zhudongyong on 13-11-20.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#ifndef KMDrawViewDemo_KMBrush_h
#define KMDrawViewDemo_KMBrush_h

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h> //C99
#include <stddef.h>
#include <float.h>
#include <math.h>

typedef NS_ENUM(int32_t, KBRParamKey) {
    KBRParamKeyEnd              = 0x0000,
    
    
    ///Brush Type Setting
    /**
     *Brush Type
     */
    KBRParamKeyBrushType        = 0x1001,
    
    
    ///Blend Type Setting
    /**
     *Blend Type
     */
    KBRParamKeyBlendType        = 0x1002,
    
    
    ///Shaders
    /**
     *Shaders
     */
    KBRParamKeyLineVertexShaderString       = 0x9001,
    KBRParamKeyLineFrangmentShaderString    = 0x9002,
    KBRParamKeySublineVertexShaderString    = 0x9003,
    KBRParamKeySublineFrangmentShaderString = 0x9004,
    KBRParamKeyImageVertexShaderString      = 0x9005,
    KBRParamKeyImageFrangmentShaderString   = 0x9006,
    KBRParamKeySmudgeVertexShaderString     = 0x9007,
    KBRParamKeySmudgeFrangmentShaderString  = 0x9008,
    
    
    ///Common Parameters Setting
    /**
     *Color
     */
    KBRParamKeyRenderColor      = 0x1003,
    /**
     *The opacity of the brush. The value range is [0, 1], Default is 1.
     */
    KBRParamKeyOpacity          = 0x1006,
    /**
     *The radius of the brush. The value range is [1, 1000]
     */
    KBRParamKeyRadius           = 0x2002,
    /**
     *The flow of the brush. The value range is (0, 1]
     */
    KBRParamKeyFlow             = 0x1007,
    /**
     *The track numbers of the brush. The value is usually between 0 and 3.
     */
    KBRParamKeyTrackNum         = 0x300C,
    
    
    ///Smudge Parameters
    /**
     *The moist quantity for smudge. The value range is [0, 1].
     */
    KBRParamKeyMoistQuantity    = 0x1008,
    /**
     *The load quantity for smudge. The value range is [0, 1].
     */
    KBRParamKeyLoadQuantity     = 0x1009,
    /**
     *The mix Quantity for smudge. The value range is [0, 1].
     */
    KBRParamKeyMixQuantity      = 0x100A,
    /**
     *Set whether the smudge effect fades.
     */
    KBRParamKeySmudgeControl    = 0x100B,
    /**
     *Set the control value for the smudge effect to gradually weaken,  controlled by the number of drawing points.
     */
    KBRParamKeySmudgeControlValue = 0x100C,
    
    
    ///Texture
    /**
     *TextureType
     */
    KBRParamKeyTextureType      = 0x200a,
    /**
     * hardness of the brush.
     */
    KBRParamKeyHardness         = 0x200b,
    /**
     * control value for texture of the brush. Data parameter is valid only for 'TextureTypeRing' and 'TextureTypeRectangle'.
     */
    KBRParamKeyTextureControlValue = 0x200c,
    /**
     * texture images of the brush. Data parameter is valid only for 'TextureTypeNormal'.
     */
    KBRParamKeyTextureImage     = 0x2001,
    ///Flip
    /**
     * Flip texture in X direction.
     */
    KBRParamKeyFlipX            = 0x2003,
    /**
     * Flip texture in Y direction.
     */
    KBRParamKeyFlipY            = 0x2004,
    
    
    ///Mask
    //Whether to enable mask texture.
    KBRParamKeyNeedMaskTexture              = 0x800D,
    /**
     * scale for mask texture.
     */
    KBRParamKeyMaskScaleValue               = 0x800E,
    /**
     * mask image of the brush.
     */
    KBRParamKeyMaskTextureImage             = 0x800F,
    
    
    ///Base Setting
    /**
     * Whether to turn on the control of point spacing. If it is turned off, only the Touch points obtained are drawn
     */
    KBRParamKeyPointsDistanceEnabled = 0x2007,
    /**
     * The distance between the center of the front and back points. The value range is [0.01, 1000].
     */
    KBRParamKeyPointsDistance   = 0x2008,
    /**
     * Bezier curves are enabled for smoothing of lines
     */
    KBRParamKeySmoothEnabled    = 0x7004,
    /**
     * speed sencitive of the brush
     */
    KBRParamKeySpeedSencitive   = 0x3007,
    /**
     * sensitivity of the brush
     */
    KBRParamKeySensitivity      = 0x3008,
    /**
     * Render the real color of the texture image.
     */
    KBRParamKeyColorFul         = 0x1005,
    /**
     * Mainline processing type
     */
    KBRParamKeyLineProcessType  = 0x100D,
    
    
    ///Control
    ///Size Control
    /**
     * Maximum drawing percentage of brush radius
     */
    KBRParamKeyMaxRadius        = 0x3016,
    /**
     * Minimum drawing percentage of brush radius
     */
    KBRParamKeyMinRadius        = 0x3006,
    /**
     * Starting percentage of line drawing radius
     */
    KBRParamKeyStartRadius      = 0x3009,
    /**
     * After the start of the line control value within the line thickness gradient
     */
    KBRParamKeyStrokeControlValue           = 0x300A,
    /**
     * Line weight control at the end of line
     */
    KBRParamKeyEndRadius                    = 0x300B,
    /**
     * Control the variation range of line thickness during line drawing. The parameter range is (0,1].
     */
    KBRParamKeyRadiusTingle                 = 0x3002,
    /**
     * Line radius control with speed
     */
    KBRParamKeyRadiusControlSpeed           = 0x3101,
    /**
     * Line radius control with pressure
     */
    KBRParamKeyRadiusControlPressure        = 0x3102,
    /**
     * Line radius control with altitude
     */
    KBRParamKeyRadiusControlAltitude        = 0x3103,
    
    
    ///Position Control
    /**
     * Sets whether the texture is allowed to be offset in the X direction of the drawing line during rendering.
     */
    KBRParamKeyDisTwoAxes                       = 0x4002,
    /**
     * distribution of texture.
     */
    KBRParamKeyDistribution                     = 0x4003,
    /**
     * Control texture distribution with speed
     */
    KBRParamKeyDistributionControlSpeed         = 0x4101,
    /**
     * Control texture distribution with pressuree
     */
    KBRParamKeyDistributionControlPressure      = 0x4102,
    /**
     * Control texture distribution with altitude
     */
    KBRParamKeyDistributionControlAltitude      = 0x4103,
    
    
    ///Render quantity control
    /**
     * distribution count
     */
    KBRParamKeyDistributionCount                    = 0x4006,
    /**
     * distribution count jitter
     */
    KBRParamKeyDistributionCountTingle              = 0x4007,
    /**
     * distribution count control with speed
     */
    KBRParamKeyDistributionCountControlSpeed        = 0x4201,
    /**
     * distribution count control with pressure
     */
    KBRParamKeyDistributionCountControlPressure     = 0x4202,
    /**
     * distribution count control with altitude
     */
    KBRParamKeyDistributionCountControlAltitude     = 0x4203,
    
    
    ///Texture rendering Angle control
    /**
     * Texture rendering Angle. The value range is [-PI, PI]. The default value is 0.0
     */
    KBRParamKeyRadian               = 0x2005,
    /**
     * Whether the texture rendering Angle is always consistent with the direction at which the line started
     */
    KBRParamKeyStartRadianEnable    = 0x200D,
    /**
     * The texture rendering Angle changes automatically with the Angle of the line
     */
    KBRParamKeyMoveRadianEnable     = 0x200E,
    /**
     * Whether the texture flip property in the X direction supports jitter
     */
    KBRParamKeyFlipXTingle          = 0x3014,
    /**
     * Whether the texture flip property in the Y direction supports jitter
     */
    KBRParamKeyFlipYTingle          = 0x3015,
    /**
     * Percentage of texture rotation radian jitter. The value ranges from 0 to 1. The default value is 0.
     */
    KBRParamKeyRadianTingle         = 0x300D,
    /**
     * radian control with speed
     */
    KBRParamKeyRadianControlSpeed       = 0x3201,
    /**
     * radian control with pressure
     */
    KBRParamKeyRadianControlPressure    = 0x3202,
    /**
     * radian control with altitude
     */
    KBRParamKeyRadianControlAltitude    = 0x3203,
    
    
    ///Roundness control
    /**
     * roundness of texture, ratio of texture widths. The value range (0.1, 1). The default is 1.
     */
    KBRParamKeyRoundness                    = 0x2006,
    /**
     * roundness jitter. The value range is (0.1, 1]. The default is 1.
     */
    KBRParamKeyRoundnessTingle              = 0x3010,
    /**
     * minimum roundness. The value ranges from 0.1 to 1. The default value is 0.
     */
    KBRParamKeyMinRoundness                 = 0x3011,
    /**
     * roundness control fo speed
     */
    KBRParamKeyRoundnessControlSpeed        = 0x3301,
    /**
     * roundness control with pressure
     */
    KBRParamKeyRoundnessControlPressure     = 0x3302,
    /**
     * roundness control with altitude
     */
    KBRParamKeyRoundnessControlAltitude     = 0x3303,
    
    
    ///Flow control
    /**
     * Minimum flow. The value ranges is [0, 1]. The default value is 0.
     */
    KBRParamKeyFlowTingle                   = 0x6006,
    /**
     * Maximum flow. The value ranges from [0，1]. The default value is 0.01.
     */
    KBRParamKeyMinFlow                      = 0x6009,
    /**
     * flow jitter. The value ranges is [0, 1]. The default value is 0.01.
     */
    KBRParamKeyMaxFlow                      = 0x600C,
    /**
     * Flow value Attenuation control value. The default value is 0, and the traffic does not attenuate*
     */
    KBRParamKeyFlowDecay                    = 0x6008,
    /**
     * flow control with speed
     */
    KBRParamKeyFlowControlSpeed             = 0x6101,
    /**
     * flow control with pressure
     */
    KBRParamKeyFlowControlPressure          = 0x6102,
    /**
     * flow control with altitude
     */
    KBRParamKeyFlowControlAltitude          = 0x6103,
    
    
    ///Texture control
    /**
     * Texture jitter, using the specified ordinal texture in the texture array
     */
    KBRParamKeyTextureTingleEnabled         = 0x8002,
    /**
     * Texture control with speed
     */
    KBRParamKeyTextureControlSpeed          = 0x8101,
    /**
     * Texture control with pressure
     */
    KBRParamKeyTextureControlPressure       = 0x8102,
    /**
     * Texture control with altitude
     */
    KBRParamKeyTextureControlAltitude       = 0x8103,
    
    
    ///Color Control
    //Background color
    KBRParamKeyBackRenderColor              = 0x1004,
    /**
     * Foreground/background color jitter. The value range is [0, 1], and default is 0
     */
    KBRParamKeyColorTingle                  = 0x5002,
    /**
     * Color control with speed
     */
    KBRParamKeyColorControlSpeed            = 0x5101,
    /**
     * Color control with pressure
     */
    KBRParamKeyColorControlPressure         = 0x5102,
    /**
     * Color control with altitude
     */
    KBRParamKeyColorControlAltitude         = 0x5103,
    
    
    ///HSB jitter
    /**
     * hue jitter. The value range is [0, 1]. default is 0.
     */
    KBRParamKeyHueTingle                    = 0x5005,
    /**
     * Saturation jitter. The value range is [0, 1]. default is 0.
     */
    KBRParamKeySaturationTingle             = 0x5006,
    /**
     * brightness jitter. The value range is [0, 1]. default is 0.
     */
    KBRParamKeyBrightnessTingle             = 0x5007,
    
    
    ///Repeatedly Render
    /**
     * Repeatedly Render Enabled
     */
    KBRParamKeyRepeatedlyRenderEnabled      = 0x400A,
    /**
     * Subline texture image
     */
    KBRParamKeySlTextureImage               = 0x400B,
    /**
     * Subline point radius
     */
    KBRParamKeySlRadius                     = 0x400D,
    /**
     * Distance between the front and rear points of sublines
     */
    KBRParamKeySlPointsDistance             = 0x400E,
    /**
     * Percentage of subline distribution
     */
    KBRParamKeySlDistribution               = 0x400F,
    /**
     * Whether subline X distribution is enabled
     */
    KBRParamKeySlDistbTwoAxes               = 0x4010,
    /**
     * Number of sublines distributed
     */
    KBRParamKeySlDistbCount                 = 0x4011,
    /**
     * Sub-line width and main line width association type
     */
    KBRParamKeySLRadiusRelationType         = 0x4012,
    /**
     * relation value
     */
    KBRParamKeyRelationValue                = 0x4013,
    
    
    
#pragma mark - DEPRECATED
    ///DEPRECATED
    /**
     * Pressure type
     */
    KBRParamKeyPressureStyle    = 0x2009,
    /**
     * Shape dynamic switch
     */
    KBRParamKeyShapeTendencyEnabled         = 0x3001,
    ///Radius Control
    /**
     * Radius jitter control type
     */
    KBRParamKeyRadiusControlType            = 0x3003,
    /**
     * Radius jitter control type value
     */
    KBRParamKeyRadiusControlValue           = 0x3004,
    /**
     * Angle control type
     */
    KBRParamKeyRadianControlType            = 0x300E,
    /**
     * Point of control values, only the ESRadianControlTypeDissolving work
     */
    KBRParamKeyRadianControlValue           = 0x300F,
    /**
     * Roundness control
     */
    KBRParamKeyRoundnessControlType         = 0x3012,
    /**
     * Roundness control values, only the ` ESRoundnessControlTypeDissolving ` effectively
     */
    KBRParamKeyRoundnessControlValue        = 0x3013,
    ///Distribution
    /**
     * Distribution Enabled
     */
    KBRParamKeyDistributionEnabled          = 0x4001,
    /**
     * Distribution control
     */
    KBRParamKeyDistributionControlType      = 0x4004,
    KBRParamKeyDistributionControlValue     = 0x4005,
    /**
     * Distribution quantity control
     */
    KBRParamKeyDistributionCountControlType = 0x4008,
    KBRParamKeyDistributionCountControlValue= 0x4009,
    /**
     * Color dynamic switch
     */
    KBRParamKeyColorTendencyEnabled         = 0x5001,
    /**
     * Color jitter control
     */
    KBRParamKeyColorControlType             = 0x5003,
    /**
     *  Color jitter control value
     */
    KBRParamKeyColorControlValue            = 0x5004,
    ///Transmission Enabled
    KBRParamKeyTransmissionEnabled          = 0x6001,
    /**
     * Opacity jitter The value range is [0, 1] and default is 0.
     */
    KBRParamKeyOpacityTingle                = 0x6002,
    /**
     * Opacity jitter control type
     */
    KBRParamKeyOpacityControlType           = 0x6003,
    /**
     * Opacity jitter control value
     */
    KBRParamKeyOpacityControlValue          = 0x6004,
    /**
     * Minimum opacity. The value range is [0, 1], and default is 0.01
     */
    KBRParamKeyMinOpacity                   = 0x6005,
    /**
     * Flow jitter control type
     */
    KBRParamKeyFlowControlType              = 0x6007,
    /**
     * Flow fade (/ strong) recovery start position
     */
    KBRParamKeyFlowReservePos               = 0x600A,
    /**
     * Flow fade (/ strong) recovery control value
     */
    KBRParamKeyFlowReserveControlValue      = 0x600B,
    /**
     * Variegated color
     */
    KBRParamKeyVaricoloredEnabled           = 0x7001,
    /**
     * Wet side
     */
    KBRParamKeyWetSideEnabled               = 0x7002,
    /**
     * Spray gun
     */
    KBRParamKeySpryGunEnabled               = 0x7003,
    /**
     * Protect Texture
     */
    KBRParamKeyProtectTextureEnabled        = 0x7005,
    /**
     * Texture dynamics
     */
    KBRParamKeyTextureTendencyEnabled       = 0x8001,
    /**
     * Initial sequence number
     */
    KBRParamKeyBeginIndexOfTingle           = 0x8003,
    /**
     * End sequence number
     */
    KBRParamKeyEndIndexOfTingle             = 0x8004,
    /**
     * Line start control type
     */
    KBRParamKeyLineFrontTextureControlType  = 0x8005,
    /**
     * Start of line control value
     */
    KBRParamKeyLineFrontTextureControlValue = 0x8006,
    /**
     * The texture sequence number is used at the beginning of the line
     */
    KBRParamKeyBeginIndexOfFrontLine        = 0x8007,
    /**
     * The beginning of the line ends with a texture sequence number
     */
    KBRParamKeyEndIndexOfFrontLine          = 0x8008,
    /**
     * End of line control type
     */
    KBRParamKeyLineTerminalTextureControlType = 0x8009,
    /**
     *End of line control value
     */
    KBRParamKeyLineTerminalTextureControlValue= 0x800A,
    /**
     * The end of the line uses the texture sequence number starting value
     */
    KBRParamKeyBeginIndexOfTerminalTexture  = 0x800B,
    /**
     * The end of the line uses the texture sequence number end value
     */
    KBRParamKeyEndIndexOfTerminalTexture    = 0x800C,
};

typedef NS_ENUM(int32_t, KBRPlatform) {
    KBRPlatformIOS      = 0x1001,
    KBRPlatformMac      = 0x1002,
    KBRPlatformAndroid  = 0x1003,
    KBRPlatformWindow   = 0x1004
};

typedef NS_ENUM(int32_t, KBRVersion) {
    KBRVersion_1_0_0    = 100,
    KBRVersion_2_0_0    = 200,
};

/**
 */
struct _KBRInfo {
    int32_t     version;    //version
    KBRPlatform platform;   //platform
    int32_t     count;      //numbers of brush
};
typedef struct _KBRInfo KBRInfo;

struct _RGBAType {
    int16_t      red;
    int16_t      green;
    int16_t      blue;
    int16_t      alpha;
};
typedef struct _RGBAType RGBAType;

typedef NS_ENUM(int32_t, KBRValueType) {
    KBRValueTypeBOOL = 0x2001,
    KBRValueTypeInt,
    KBRValueTypeInt8,
    KBRValueTypeInt32,
    KBRValueTypeInt64,
    KBRValueTypeFloat,
    KBRValueTypeDouble,
    KBRValueTypeChar,
    KBRValueTypeCharPointer,
    KBRValueTypeRGBAType,
};

typedef struct _KBRSize {
    int32_t   width;
    int32_t   height;
}KBRSize;

typedef NS_ENUM(int32_t, KBRIMGType) {
    KBRIMGTypeGray  = 0x0001,
    KBRIMGTypeRGB   = 0x0003,
    KBRIMGTypeRGBA  = 0x0004
};

typedef struct _KBRTexture {
    KBRSize     textureSize;//8
    KBRIMGType  imgType;    //4
    char  *textureData;     //4
}KBRTexture;

union _KBRParamValue {
    int8_t      boolValue;
    int8_t      int8Value;
    int16_t     int16Value;
    int32_t     intValue;
    float       floatValue;
    double      doubleValue;
    char        charValue;
    char*       charPointerValue;
    RGBAType    rgbValue;
    KBRTexture  textureValue;
};
typedef union _KBRParamValue KBRParamValue;

typedef NS_ENUM(int32_t, KBRParamValueType) {
    KBRParamValueTypeBOOL   = 0x1001,
    KBRParamValueTypeInt8,
    KBRParamValueTypeInt16,
    KBRParamValueTypeInt,
    KBRParamValueTypeFloat,
    KBRParamValueTypeDouble,
    KBRParamValueTypeRGBA,
    KBRParamValueTypeChar,
    KBRParamValueTypeCharPointer,
    KBRParamValueTypeTexture
};

typedef struct _KBRParamData {
    KBRParamKey         key;
    char                method[40];
    KBRParamValueType   valueType;
    KBRParamValue       value;
}KBRParamData;

FILE *KBRCreate(const char *filename);
FILE *KBROpen(const char *filename);

bool AddKBRInfo(FILE *kbr, KBRInfo info);
KBRInfo ReadKBRInfo(FILE *kbr);

bool AddBrushName(FILE *kbr, const char *brushname);
char *ReadBrushName(FILE *kbr);

bool AddValue(FILE *kbr, KBRParamKey key, const char *method, KBRParamValue value, KBRParamValueType type);
KBRParamData NextParamData(FILE *kbr);

bool AddBrushCreatorName(FILE *kbr, const char *creatorName);
char *ReadBrushCreatorName(FILE *kbr);

bool AddBrushCreatTime(FILE *kbr, const char *brushCreatTime);
char *ReadBrushCreatTime(FILE *kbr);

void KBRClose(FILE *kbr);

#endif
