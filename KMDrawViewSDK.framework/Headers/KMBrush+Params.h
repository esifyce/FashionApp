//
//  KMBrush+Params.h
//  KMDrawViewDemo
//
//  Created by zhudongyong on 16/9/6.
//  Copyright © 2016年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#import "UIImage+Mac.h"
#endif
#import "KMDrawView.h"
#import "KMBrush.h"
#import "KMBrushManager.h"

#pragma mark -
#pragma mark - KMBrush Protocol
@protocol KMBrush <NSObject>

/// Brush Type
#pragma mark - Brush Type Setting
/**
 * @return brush type of the brush.
 */
@property (nonatomic, readonly) ESBrushType   brushType;

/// Blend Mode
#pragma mark - Blend Type Setting
/**
 * @return brush blend mode of the brush.
 */
@property (nonatomic, readonly) ESLayerBlendType blendType;

#pragma mark Shaders
/**
 * @return blend fragment fhader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, readonly) NSString *blendFragmentShaderString;

/**
 * @return base line vertex shader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, readonly) NSString *baselineVertexShaderString;

/**
 * @return base line fragment shader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, readonly) NSString *baselineFragmentShaderString;

/**
 * @return subline vertex shader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, readonly) NSString *sublineVertexShaderString;

/**
 * @return subline fragment shader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, readonly) NSString *sublineFragmentShaderString;


/// Common Parameters
#pragma mark - Common Parameters Setting
/**
 * @return The default render color of the brush.
 */
@property (nonatomic, readonly) UIColor *renderColor;

/**
 * @return The opacity of the brush. The value range is [0, 1], Default is 1.
 */
@property (nonatomic, readonly) float opacity;

/**
 * @return The radius of the brush. The value range is [1, 1000]
 */
@property (nonatomic, readonly) float radius;

/**
 * @return The flow of the brush. The value range is (0, 1]
 */
@property (nonatomic, readonly) float flow;

/**
 * @discussion Point delay, used to deal with line segment smoothing,
 * @return The track numbers of the brush. The value is usually between 0 and 3.
 */
@property (nonatomic, readonly) NSUInteger  trackNum;

/// Smudge Parameters
#pragma mark - Smudge Parameters
/**
 * @discussion The moistness of ink blot, the more humid, the stronger the smearing effect
 * @return The moist quantity for smudge. The value range is [0, 1].
 */
@property (nonatomic, readonly) float moistQuantity;

/**
 * @discussion The percentage of color set is loaded when blending
 * @return The load quantity for smudge. The value range is [0, 1].
 */
@property (nonatomic, readonly) float loadQuantity;

/**
 * @return The mix Quantity for smudge. The value range is [0, 1].
 */
@property (nonatomic, readonly) float mixQuantity;

/**
 * @return Set whether the smudge effect fades.
 */
@property (nonatomic, readonly) BOOL  smudgeControl;

/**
 * @return Set the control value for the smudge effect to gradually weaken,
 *         controlled by the number of drawing points.
 */
@property (nonatomic, readonly) float smudgeControlValue;


/// Texture
#pragma mark - Texture
/**
 * @see TextureTypes.h
 * @return texture type of the brush.
 */
@property (nonatomic, readonly) TextureType   textureType;

/**
 * @return hardness of the brush.
 */
@property (nonatomic, readonly) float         hardness;

/**
 * @return control value for texture of the brush. Data parameter is valid only for 'TextureTypeRing' and 'TextureTypeRectangle'.
 */
@property (nonatomic, readonly) float         textureControlValue;

/**
 * @return texture images of the brush. Data parameter is valid only for 'TextureTypeNormal'.
 */
@property (nonatomic, readonly) NSArray   *textureImages;

///Flip
/**
 * @return Flip texture in X direction.
 */
@property (nonatomic, readonly) BOOL flipX;

/**
 * @return Flip texture in Y direction.
 */
@property (nonatomic, readonly) BOOL flipY;

/// Mask
#pragma mark - Mask
/**
 * @return Whether to enable mask texture.
 */
@property (nonatomic, readonly) BOOL needMaskTexture;

/**
 * @return scale for mask texture.
 */
@property  (nonatomic, readonly) float    maskScale;

/**
 * @return mask image of the brush.
 */
@property (nonatomic, readonly) UIImage *maskImage;


///General parameter setting
#pragma mark - Base Setting

/**
 * @return Whether to turn on the control of point spacing. If it is turned off, only the Touch points obtained are drawn
 */
@property (nonatomic, readonly) BOOL pointsDistanceEnabled;

/**
 * @return The distance between the center of the front and back points. The value range is [0.01, 1000].
 */
@property (nonatomic, readonly) float pointsDistance;

/**
 * @return Bezier curves are enabled for smoothing of lines
 */
@property (nonatomic, readonly) BOOL smoothEnabled;

/**
 * @return speed sencitive of the brush
 */
@property (nonatomic, readonly) float speedSencitive;

/**
 * @return sensitivity of the brush
 */
@property (nonatomic, readonly) float sensitivity;

/**
 * @return Render the real color of the texture image.
 */
@property (nonatomic, readonly) BOOL colorFul;

/**
 * @see ESRenderTypes.h
 * @return Mainline processing type
 */
@property (nonatomic, readonly) ESLineProcessType  lineProcessType;


///Control
#pragma mark - Control
#pragma mark Size Control

/**
 * @return Minimum drawing percentage of brush radius
 */
@property (nonatomic, readonly) float minRadius;

/**
 * @return Maximum drawing percentage of brush radius
 */
@property (nonatomic, readonly) float maxRadius;

/**
 * @return Starting percentage of line drawing radius
 */
@property (nonatomic, readonly) float startRadius;

/**
 * @discussion After the start of the line control value within the line thickness gradient
 * @return Starting percentage of line drawing radius
 */
@property (nonatomic, readonly) float strokeControlValue;

/**
 * @return Line weight control at the end of line
 */
@property (nonatomic, readonly) float endRadius;

/**
 * @return Control the variation range of line thickness during line drawing. The parameter range is (0,1].
 */
@property (nonatomic, readonly) float radiusTingle;

/**
 * @see LineProcessTypes.h
 * @return Line radius control.
 */
@property (nonatomic, readonly) LPControlParams radiusControl;

#pragma mark Position Control
/**
 * @return Sets whether the texture is allowed to be offset in the X direction of the drawing line during rendering.
 */
@property (nonatomic, readonly) BOOL disTwoAxes;

/**
 * @return distribution of texture.
 */
@property (nonatomic, readonly) float distribution;

/**
 * @see LineProcessTypes.h
 * @return Control texture distribution
 */
@property (nonatomic, readonly) LPControlParams distributionControl;

#pragma mark Render quantity control

/**
 * @return distribution count
 */
@property (nonatomic, readonly) float distributionCount;

/**
 * @return distribution count jitter
 */
@property (nonatomic, readonly) float distributionCountTingle;

/**
 * @see LineProcessTypes.h
 * @return distribution count control
 */
@property (nonatomic, readonly) LPControlParams distributionCountControl;

#pragma mark - Texture rendering Angle control

/**
 * @return Texture rendering Angle. The value range is [-PI, PI]. The default value is 0.0
 */
@property (nonatomic, readonly) float radian;

/**
 * @return Whether the texture rendering Angle is always consistent with the direction at which the line started
 */
@property (nonatomic, readonly) BOOL startRadianEnable;

/**
 * @return The texture rendering Angle changes automatically with the Angle of the line
 */
@property (nonatomic, readonly) BOOL moveRadianEnable;

//***************** Flip Tingle *****************
/**
 * @return Whether the texture flip property in the X direction supports jitter
 */
@property (nonatomic, readonly) BOOL flipXTingle;

/**
 * @return Whether the texture flip property in the Y direction supports jitter
 */
@property (nonatomic, readonly) BOOL flipYTingle;

///Angle control
//***************** Angle control *****************

/**
 * @return Percentage of texture rotation radian jitter. The value ranges from 0 to 1. The default value is 0.
 */
@property (nonatomic, readonly) float radianTingle;

/**
 * @see LineProcessTypes.h
 * @return radian control.
 */
@property (nonatomic, readonly) LPControlParams radianControl;

#pragma mark - Roundness control

/**
 * @return roundness of texture, ratio of texture widths. The value range (0.1, 1). The default is 1.
 */
@property (nonatomic, readonly) float roundness;

/**
 * @return roundness jitter. The value range is (0.1, 1]. The default is 1.
 */
@property (nonatomic, readonly) float roundnessTingle;

/**
 * @return minimum roundness. The value ranges from 0.1 to 1. The default value is 0.
 */
@property (nonatomic, readonly) float minRoundness;

/**
 * @see LineProcessTypes.h
 * @return roundness control
 */
@property (nonatomic, readonly) LPControlParams roundnessControl;

#pragma mark - Flow control

/**
 * @return Minimum flow. The value ranges is [0, 1]. The default value is 0.
 */
@property (nonatomic, readonly) float minFlow;

/**
 * @return Maximum flow. The value ranges from [0，1]. The default value is 0.01.
 */
@property (nonatomic, readonly) float maxFlow;

/**
 * @return flow jitter. The value ranges is [0, 1]. The default value is 0.01.
 */
@property (nonatomic, readonly) float flowTingle;

/**
 * @see LineProcessTypes.h
 * @return flow ccontrol
 */
@property (nonatomic, readonly) LPControlParams flowControl;

/**
 * @return Flow value Attenuation control value. The default value is 0, and the traffic does not attenuate
 */
@property (nonatomic, readonly) float decay;

#pragma mark - Texture control
/**
 * @return Texture jitter, using the specified ordinal texture in the texture array
 */
@property (nonatomic, readonly) BOOL textureTingleEnabled;

/**
 * @see LineProcessTypes.h
 * @return Texture control
 */
@property (nonatomic, readonly) LPControlParams textureControl;

#pragma mark - Color Control
/**
 * @return Background color
 */
@property (nonatomic, readonly) UIColor *backRenderColor;

/**
 * @return Foreground/background color jitter. The value range is [0, 1], and default is 0
 */
@property (nonatomic, readonly) float colorTingle;

/**
 * @see LineProcessTypes.h
 * @return Color control
 */
@property (nonatomic, readonly) LPControlParams colorControl;

#pragma mark - HSB jitter
/**
 * @return hue jitter. The value range is [0, 1]. default is 0.
 */
@property (nonatomic, readonly) float hueTingle;

/**
 * @return Saturation jitter. The value range is [0, 1]. default is 0.
 */
@property (nonatomic, readonly) float saturationTingle;

/**
 * @return brightness jitter. The value range is [0, 1]. default is 0.
 */
@property (nonatomic, readonly) float brightnessTingle;

#pragma mark - Repeatedly Render
/**
 * @return Repeatedly Render Enabled
 */
@property (nonatomic, readonly) BOOL repeatedlyRenderEnabled;

/**
 * @return Subline texture image
 */
@property (nonatomic, readonly) UIImage   *slTextureImage;

/**
 * @return Subline point radius
 */
@property (nonatomic, readonly) float slRadius;

/**
 * @return Distance between the front and rear points of sublines
 */
@property (nonatomic, readonly) float slPointsDistance;

/**
 * @return Percentage of subline distribution
 */
@property (nonatomic, readonly) float slDistribution;

/**
 * @return Whether subline X distribution is enabled
 */
@property (nonatomic, readonly) BOOL slDistbTwoAxes;

/**
 * @return Number of sublines distributed
 */
@property (nonatomic, readonly) float slDistbCount;

/**
 * @return Sub-line width and main line width association type
 */
@property (nonatomic, readonly) ESRadiusRelationType slRadiusRelationType;

/**
 * @return relation value
 */
@property (nonatomic, readonly) float relationValue;

@end


#pragma mark -
#pragma mark - KMBrushInfo Protocol
@protocol KMBrushInfo <NSObject>

@property (nonatomic, readonly) NSString            *brushName;
@property (nonatomic, readonly) NSArray<KMBrush>    *brushParams;
@property (nonatomic, readonly) KBRVersion          brushVersion;
@property (nonatomic, readonly) NSString            *brushCreatorName;
@property (nonatomic, readonly) NSString            *brushCreatTime;

@end


#pragma mark - NSDictionary + KMBrush
@interface NSDictionary (Brush)<KMBrushInfo>

@end


#pragma mark - NSArray + KMBrush
@interface NSArray (Brush)<KMBrush>

- (id)paramValueForKey:(KBRParamKey)key;

@end
