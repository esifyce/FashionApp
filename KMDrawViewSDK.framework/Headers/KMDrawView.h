//
//  KMDrawView.h
//  KMDrawViewDemo
//
//  Created by zhudongyong on 13-9-23.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LineProcessTypes.h"
#import "Recognise.h"
#import "ESRenderTypes.h"
#import "KMDrawViewTypes.h"
#import "ESContextTypes.h"
#import "TextureTypes.h"
#import "ESShaderTools.h"

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#if kDigitPenEnable
#import "PenManager.h"
#endif//kDigitPenEnable
#else
#import <AppKit/AppKit.h>
#import "UIImage+Mac.h"
#import "UIColor+Mac.h"
#import "UIView+Mac.h"
#endif


@protocol KMDrawViewDelegate;

//Control parameter calibration
typedef float (^ParameterAdjust)(float originValue);

@interface KMDrawView : UIView
#if kDigitPenEnable
<PenManagerTouchEventDelegate>
#endif

#if TARGET_OS_IOS
@property (nonatomic, readonly) UIView *touchRefView;//View is used for gesture point conversion
#endif

#pragma mark - Normal
/**
 * @return Scale value for view
 */
@property (nonatomic, readonly) CGSize scale;

/**
 * @return The initial data size of the current control
 */
@property (nonatomic, readonly) CGSize bufferSize;

/**
 * @return By Default, the cancelled Line is automatically calibrated. Default is true.
 */
@property (nonatomic) BOOL adjustCancelLine;

/**
 * @return If the contact is out of bounds (beyond the boundary of KMDrawView), the Default is true.
 */
@property (nonatomic, readwrite) BOOL   shoudCancelDrawForPointBounds;

/**
 * @return Whether the contact is out of bounds
 */
@property (nonatomic, readonly)  BOOL   pointBounds;

#if PreModelEnable
/**
 * @return Effect preview mode, smear and other effects can also see the corresponding brush effect
 */
@property (nonatomic) BOOL      isDebug;
#endif

/**
 * Hardware pressure sensing control
 */
@property (nonatomic) BOOL      enableDevicePress;

/**
 * @return Pressure normal value. The value range is (0,1). This parameter is valid when enableDevicePress is set to YES. Default is 0.9
 */
@property (nonatomic) float     normalPress; //default is 0.9

#if EnableRecogition
#pragma mark - Shape Recognize
/**
 * @return Set whether to enable the graph identification function. The function is disabled by default.
 * @since Available in iOS 4.3 and later.
 */
@property (nonatomic, readwrite) BOOL       enableRecogition;

@property (nonatomic, readwrite) float      recogPointScale;    //Scale

/**
 * @return Set the pattern recognition type 'ShapeType'. By default, ShapeTypeLine(line), ShapeTypeTriangle, ShapeTypeCircle(circle), Shapetypecircle (circle) are supported.
 *         ShapeTypeEllipse(ellipse), ShapeTypeDiarec(rectangle), ShapeTypeArrow(arrow), ShapeTypeelogram (parallelogram)
 * @since Available in iOS 4.3 and later.
 */
@property (nonatomic, readwrite) ShapeType shapesMark;         //Shape Type
#endif//EnableRecogition



/// Brush Type
#pragma mark - Brush Type Setting
/**
 * @return brush type of the brush.
 */
@property (nonatomic) ESBrushType   brushType;

#pragma mark - gaussian radius for ESBrushTypeLeaf
@property (nonatomic) float gaussianRadius;

/// Blend Type
#pragma mark - Blend Type Setting
/**
 * @return brush blend mode of the brush.
 */
@property (nonatomic) ESLayerBlendType blendType;

/**
 * @return blend fragment fhader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, copy) NSString *blendFragmentShaderString;
#if TARGET_OS_IOS
#pragma mark Shaders
/**
 * @return base line vertex shader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, copy) NSString *baselineVertexShaderString;

/**
 * @return base line fragment shader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, copy) NSString *baselineFragmentShaderString;

/**
 * @return subline vertex shader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, copy) NSString *sublineVertexShaderString;

/**
 * @return subline fragment shader string of the brush. Used for OpenGL ES.
 */
@property (nonatomic, copy) NSString *sublineFragmentShaderString;
#endif


/// Common Parameters
#pragma mark - Common Parameters Setting
/**
 * @return The render color for drawing.
 */
@property (nonatomic, retain) UIColor *renderColor;

/**
 * @return The opacity for drawing. The value range is [0, 1], Default is 1.
 */
@property (nonatomic) float opacity;

/**
 * @return The radius for drawing. The value range is [1, 1000]
 */
@property (nonatomic) float radius;

/**
 * @return The flow for drawing. The value range is (0, 1]
 */
@property (nonatomic) float flow;

/**
 * @discussion Point delay, used to deal with line segment smoothing,
 * @return The track numbers for drawing. The value is usually between 0 and 3.
 */
@property (nonatomic) NSUInteger  trackNum;

///Smudge Parameters
#pragma mark - Smudge Parameters
/**
 * @discussion The moistness of ink blot, the more humid, the stronger the smearing effect
 * @return The moist quantity for smudge. The value range is [0, 1].
 */
@property (nonatomic) float moistQuantity;

/**
 * @discussion The percentage of color set is loaded when blending
 * @return The load quantity for smudge. The value range is [0, 1].
 */
@property (nonatomic) float loadQuantity;

/**
 * @return The mix Quantity for smudge. The value range is [0, 1].
 */
@property (nonatomic) float mixQuantity;

/**
 * @return Set whether the smudge effect fades.
 */
@property (nonatomic) BOOL  smudgeControl;

/**
 * @return Set the control value for the smudge effect to gradually weaken,
 *         controlled by the number of drawing points.
 */
@property (nonatomic) float smudgeControlValue;


/// Brush Texture
#pragma mark - Texture
/**
 * @see TextureTypes.h
 * @return texture type for drawing.
 */
@property (nonatomic) TextureType   textureType;

/**
 * @return hardness for drawing.
 */
@property (nonatomic) float         hardness;

/**
 * @return Texture control value in drawing. Data parameter is valid only for 'TextureTypeRing' and 'TextureTypeRectangle'.
 */
@property (nonatomic) float         textureControlValue;

/**
 * @return texture images for drawing. Data parameter is valid only for 'TextureTypeNormal'.
 */
@property (nonatomic, retain) NSArray   *textureImages;

///Flip

/**
 * @return Flip texture in X direction.
 */
@property (nonatomic) BOOL flipX;

/**
 * @return Flip texture in Y direction.
 */
@property (nonatomic) BOOL flipY;

/// Mask
#pragma mark - Mask
/**
 * @return Whether to enable mask texture.
 */
@property (nonatomic) BOOL needMaskTexture;

/**
 * @return scale for mask texture.
 */
@property  (nonatomic) float    maskScale;

/**
 * @return mask image of the brush.
 */
@property (nonatomic, strong) UIImage *maskImage;


///General parameter setting
#pragma mark - Base Setting

/**
 * @return Whether to turn on the control of point spacing. If it is turned off, only the Touch points obtained are drawn
 */
@property (nonatomic) BOOL pointsDistanceEnabled;

/**
 * @return The distance between the center of the front and back points. The value range is [0.01, 1000].
 */
@property (nonatomic) float pointsDistance;

/**
 * @return Bezier curves are enabled for smoothing of lines
 */
@property (nonatomic) BOOL smoothEnabled;

/**
 * @return speed sencitive for drawing
 */
@property (nonatomic) float speedSencitive;

/**
 * @return sensitivity for drawing
 */
@property (nonatomic) float sensitivity;

/**
 * @return Render the real color of the texture image.
 */
@property (nonatomic) BOOL colorFul;

/**
 * @see ESRenderTypes.h
 * @return Mainline processing type
 */
@property (nonatomic, readwrite) ESLineProcessType  lineProcessType;


///Control
#pragma mark - Control
#pragma mark Size control

/**
 * @return Minimum drawing percentage of brush radius
 */
@property (nonatomic) float minRadius;

/**
 * @return Maximum drawing percentage of brush radius
 */
@property (nonatomic) float maxRadius;

/**
 * @return Starting percentage of line drawing radius
 */
@property (nonatomic) float startRadius;

/**
 * @discussion After the start of the line control value within the line thickness gradient
 * @return Starting percentage of line drawing radius
 */
@property (nonatomic) float strokeControlValue;

/**
 * @return Line weight control at the end of line
 */
@property (nonatomic) float endRadius;

/**
 * @return Control the variation range of line thickness during line drawing. The parameter range is (0,1].
 */
@property (nonatomic) float radiusTingle;

/**
 * @see LineProcessTypes.h
 * @return Line radius control.
 */
@property (nonatomic) LPControlParams radiusControl;

#pragma mark Position Control
/**
 * @return Sets whether the texture is allowed to be offset in the X direction of the drawing line during rendering.
 */
@property (nonatomic) BOOL disTwoAxes;

/**
 * @return distribution of texture.
 */
@property (nonatomic) float distribution;

/**
 * @see LineProcessTypes.h
 * @return Control texture distribution
 */
@property (nonatomic) LPControlParams distributionControl;

#pragma mark Render quantity control

/**
 * @return distribution count
 */
@property (nonatomic) float distributionCount;

/**
 * @return distribution count jitter
 */
@property (nonatomic) float distributionCountTingle;

/**
 * @see LineProcessTypes.h
 * @return distribution count control
 */
@property (nonatomic) LPControlParams distributionCountControl;

#pragma mark - Texture rendering Angle control
/**
 * @return Texture rendering Angle. The value range is [-PI, PI]. The default value is 0.0
 */
@property (nonatomic) float radian;

/**
 * @return Whether the texture rendering Angle is always consistent with the direction at which the line started
 */
@property (nonatomic) BOOL startRadianEnable;

/**
 * @return The texture rendering Angle changes automatically with the Angle of the line
 */
@property (nonatomic) BOOL moveRadianEnable;

/**
 * @return Whether the texture flip property in the X direction supports jitter
 */
@property (nonatomic) BOOL flipXTingle;

/**
 * @return Whether the texture flip property in the Y direction supports jitter
 */
@property (nonatomic) BOOL flipYTingle;

///Angle control
/**
 * @return Percentage of texture rotation radian jitter. The value ranges from 0 to 1. The default value is 0.
 */
@property (nonatomic) float radianTingle;

/**
 * @see LineProcessTypes.h
 * @return radian control.
 */
@property (nonatomic) LPControlParams radianControl;

#pragma mark - Roundness control
/**
 * @return roundness of texture, ratio of texture widths. The value range (0.1, 1). The default is 1.
 */
@property (nonatomic) float roundness;

/**
 * @return roundness jitter. The value range is (0.1, 1]. The default is 1.
 */
@property (nonatomic) float roundnessTingle;

/**
 * @return minimum roundness. The value ranges from 0.1 to 1. The default value is 0.
 */
@property (nonatomic) float minRoundness;

/**
 * @see LineProcessTypes.h
 * @return roundness control
 */
@property (nonatomic) LPControlParams roundnessControl;

#pragma mark - Flow control 
/**
 * @return Minimum flow. The value ranges is [0, 1]. The default value is 0.
 */
@property (nonatomic) float minFlow;

/**
 * @return Maximum flow. The value ranges from [0，1]. The default value is 0.01.
 */
@property (nonatomic) float maxFlow;

/**
 * @return flow jitter. The value ranges is [0, 1]. The default value is 0.01.
 */
@property (nonatomic) float flowTingle;

/**
 * @return flow jitter. The value ranges is [0, 1]. The default value is 0.01.
 */
@property (nonatomic) LPControlParams flowControl;

/**
 * @return Flow value Attenuation control value. The default value is 0, and the traffic does not attenuate
 */
@property (nonatomic) float decay;

#pragma mark - Texture control
/**
 * @return Texture jitter, using the specified ordinal texture in the texture array
 */
@property (nonatomic) BOOL textureTingleEnabled;

/**
 * @see LineProcessTypes.h
 * @return Texture control
 */
@property (nonatomic) LPControlParams textureControl;

#pragma mark - Color Control
/**
 * @return Background color
 */
@property (nonatomic, retain) UIColor *backRenderColor;

/**
 * @return Foreground/background color jitter. The value range is [0, 1], and default is 0
 */
@property (nonatomic) float colorTingle;

/**
 * @see LineProcessTypes.h
 * @return Color control
 */
@property (nonatomic) LPControlParams colorControl;

#pragma mark - HSB jitter
/**
 * @return hue jitter. The value range is [0, 1]. default is 0.
 */
@property (nonatomic) float hueTingle;

/**
 * @return Saturation jitter. The value range is [0, 1]. default is 0.
 */
@property (nonatomic) float saturationTingle;

/**
 * @return brightness jitter. The value range is [0, 1]. default is 0.
 */
@property (nonatomic) float brightnessTingle;

#pragma mark - Repeatedly Render
/**
 * @return Repeatedly Render Enabled
 */
@property (nonatomic) BOOL repeatedlyRenderEnabled;

/**
 * @return Subline texture image
 */
@property (nonatomic, retain) UIImage   *slTextureImage;

/**
 * @return Subline point radius
 */
@property (nonatomic) float slRadius;

/**
 * @return Distance between the front and rear points of sublines
 */
@property (nonatomic) float slPointsDistance;

/**
 * @return Percentage of subline distribution
 */
@property (nonatomic) float slDistribution;

/**
 * @return Whether subline X distribution is enabled
 */
@property (nonatomic) BOOL slDistbTwoAxes;

/**
 * @return Number of sublines distributed
 */
@property (nonatomic) float slDistbCount;

/**
 * @return Sub-line width and main line width association type
 */
@property (nonatomic) ESRadiusRelationType slRadiusRelationType;

/**
 * @return relation value
 */
@property (nonatomic) float relationValue;

#pragma mark - Undo
/**
 * Modified marks (have they been edited, dotted, mapped, etc., since the last save)
 * @return Have been edited
 * @since Available in iOS 4.3 and later.
 */
@property (nonatomic, readonly) BOOL    edited;

/**
 * Whether to enable the automatic Mark function. The default value is NO
 * @note When enabled, EAGLView will save every action automatically
 * @return Whether to Mark automatically. The default value is NO
 * @since Available in iOS 4.3 and later.
 */
@property (nonatomic, readwrite) BOOL   autoMark;

/**
 * @return Whether you need to draw lines that Touch Cancel,
 */
@property (nonatomic, readwrite) BOOL   needCancelLine;

/**
 * @return The Mark picture interval, which defaults to 0, is executed at the end of each stroke, The default value is 0 seconds
 * @since Available in iOS 4.3 and later.
 */
@property (nonatomic, readwrite) float  markTimeInterval;

/**
 * Set Undo Cache file directory, default to "/ Library/Cache/TempDirectory", at the end of the Reset/change/procedures, clears the directory
 * @return The cache file directory for undo and redo.
 * @since Available in iOS 4.3 and later.
 */
@property (nonatomic, assign) NSString  *tempDirectory;


@property (nonatomic, assign) id<KMDrawViewDelegate> delegate;


#if TARGET_OS_IOS
- (void)setBaselineVertexShaderString:(NSString *)baselineVertexShaderString
                 fragmentShaderString:(NSString *)baselineFragmentShaderString;
- (void)setSublineVertexShaderString:(NSString *)sublineVertexShaderString
                 fragmentShaderString:(NSString *)sublineFragmentShaderString;
#endif

//Draw
- (void)clear;
- (void)clearOnline:(BOOL)online;
- (void)clearWithColor:(UIColor*)color online:(BOOL)online;

@end


@interface KMDrawView (KMDrawViewDrawing)

- (BOOL)isLining;

/// Draw line
/**
 * Draws a set of points of a specified number
 * @param points input points
 * @param count the number of points
 * @return the frame of points
 */
- (CGRect)drawPoints:(LPPoint*)points count:(NSUInteger)count;
- (CGRect)drawPoints:(LPPoint*)points count:(NSUInteger)count layerType:(ESRenderLayerType)layerType;

/**
 * Start drawing a line
 * @param point       CGPoint type, the captured point coordinates
 * @param pressure    Type float, the value of the pressure corresponding to the captured point
 * @param altitude    Type float, the value of the stylus slope corresponding to the captured point
 * @param online      Whether to render online. If YES, render will be visible
 */
- (void)drawingWithBeginPoint:(CGPoint)point
                     pressure:(float)pressure
                     altitude:(float)altitude
                       online:(BOOL)online;
- (void)drawingWithBeginPoint:(CGPoint)point;
- (void)drawingWithBeginPoint:(CGPoint)point
                       online:(BOOL)online;
- (void)drawingWithBeginPoint:(CGPoint)point
                     pressure:(float)pressure
                       online:(BOOL)online;

/**
 * Responds to the TouchMove draw event
 * @param point       CGPoint type, the captured point coordinates
 * @param pressure    Type float, the value of the pressure corresponding to the captured point
 * @param altitude    Type float, the value of the stylus slope corresponding to the captured point
 * @param online      Whether to render online. If YES, render will be visible
 */
- (void)drawingWithMoveToPoint:(CGPoint)point
                      pressure:(float)pressure
                      altitude:(float)altitude
                        online:(BOOL)online;
- (void)drawingWithMoveToPoint:(CGPoint)point;
- (void)drawingWithMoveToPoint:(CGPoint)point
                        online:(BOOL)online;
- (void)drawingWithMoveToPoint:(CGPoint)point
                      pressure:(float)pressure
                        online:(BOOL)online;

/**
 * Responds to the TouchEnd draw event
 * @param point       CGPoint type, the captured point coordinates
 * @param pressure    Type float, the value of the pressure corresponding to the captured point
 * @param altitude    Type float, the value of the stylus slope corresponding to the captured point
 * @param online      Whether to render online. If YES, render will be visible
 */
- (void)drawingWithEndPoint:(CGPoint)point
                   pressure:(float)pressure
                   altitude:(float)altitude
                     online:(BOOL)online;
- (void)drawingWithEndPoint:(CGPoint)point;
- (void)drawingWithEndPoint:(CGPoint)point
                     online:(BOOL)online;
- (void)drawingWithEndPoint:(CGPoint)point
                   pressure:(float)pressure
                     online:(BOOL)online;

@end


#pragma mark - Image
@interface KMDrawView (Image)

/// Get Image

/**
 * @return Gets the drawn picture
 */
- (UIImage*)image;

/**
 * Gets the image of the specified area
 *
 * @param rect Set the area of the image to be fetched
 * @return Gets a picture of the specified area
 * @since Available in iOS 4.3 and later.
 */
- (UIImage*)imageWithRect:(CGRect)rect;

/**
 * Gets a picture of the specified area
 *
 * @param rect Set the area of the image to be fetched
 * @return Gets a picture of the specified area
 * @since Available in iOS 4.3 and later.
 */
- (CGImageRef)newCGImageWithRect:(CGRect)rect;

/**
 * Get the specified area picture data, get the specified area picture data, RGBA type
 * @param data Input Specifies the address of the data to be read
 * @param rect Set the area where the image data is to be obtained
 * @since Available in iOS 4.3 and later.
 */
- (void)readData:(void*)data rect:(CGRect)rect;
- (void)readData:(void*)data bufferRect:(CGRect)rect;


/// Post (set up) pictures

/**
 * Use Cover mode to map the original image
 *
 * @param image The picture to be mapped will do nothing if the picture is empty.
 * @param rect The location and area to be draw
 * @since Available in iOS 4.3 and later.
 */
- (void)drawImage:(UIImage*)image inRect:(CGRect)rect;

/**
 * Image data is used in Cover mode to map the original image
 *
 * @param imageData The data of the picture to be mapped is RGBA bytes data from 'CGContextRef', if the data is empty, nothing will be done.
 * @param dataSize The dimensions (width, height) of the picture to be mapped.
 * @param rect The location and area to be mapped
 * @note Regardless of other factors, 'drawData:dataSize:rect:' is more efficient than 'drawImage:rect:' for images of the same size. For example, the embedded 'ImageUndoManager' adopts data nearly 20 times faster than 'UIImage'.
 * @since Available in iOS 4.3 and later.
 */
- (void)drawData:(unsigned char*)imageData dataSize:(CGSize)dataSize inRect:(CGRect)rect;

/**
 * Image is used in Cover mode to paste a rotating image on top of the original image
 *
 * @param image The image to be mapped will do nothing if image is empty.
 * @param size The size of the area to be mapped.
 * @param center The center of the map to be mapped.
 * @param radian Picture rotation Angle. If the Angle is 0, the effect is the same as' drawImage:rect: '.
 * @param archoPoint Image rotation center position
 * @since Available in iOS 4.3 and later.
 */
- (void)drawImage:(UIImage *)image inSize:(CGSize)size atCenter:(CGPoint)center radian:(float)radian;
- (void)drawImage:(UIImage *)image inSize:(CGSize)size atCenter:(CGPoint)center radian:(float)radian anchorPoint:(CGPoint)archoPoint;

/**
 * A rotating Image is pasted on the original image by using image data in Cover mode
 *
 * @param imageData The data of the picture to be mapped is RGBA bytes data from 'CGContextRef', if the data is empty, nothing will be done.
 * @param dataSize The dimensions (width, height) of the picture to be mapped.
 * @param size The size of the area to be mapped.
 * @param center The center of the map to be mapped.
 * @param radianPicture rotation Angle. If the Angle is 0, the effect is the same as' drawImage:rect: '.
 * @since Available in iOS 4.3 and later.
 */
- (void)drawData:(unsigned char*)imageData dataSize:(CGSize)dataSize inSize:(CGSize)size atCenter:(CGPoint)center radian:(float)radian;

/**
 * Replace the original image with the replace method
 *
 * @param image The picture to be mapped will do nothing if the picture is empty.
 * @param rect The location and area to be replaced
 * @since Available in iOS 4.3 and later.
 */
- (void)setImage:(UIImage*)image inRect:(CGRect)rect;
- (void)setImage:(UIImage*)image inBufferRect:(CGRect)bufferRect;

/**
 * Replaces the Image for the specified area with the image data in the Replace mode
 *
 * @param imageData The data of the picture to be mapped is RGBA bytes data from 'CGContextRef', if the data is empty, nothing will be done.
 * @param dataSize The dimensions (width, height) of the picture to be mapped.
 * @param rect The location and area to be mapped
 * @since Available in iOS 4.3 and later.
 */
- (void)setData:(unsigned char*)imageData dataSize:(CGSize)dataSize inRect:(CGRect)rect;
- (void)setData:(unsigned char*)imageData
       dataSize:(CGSize)dataSize
         inRect:(CGRect)rect
         isUndo:(BOOL)undo;

/**
 * Replace the Image inside the original rotating rectangle area with the replace method
 *
 * @param image The image to be mapped will do nothing if image is empty.
 * @param size The size of the area to be mapped.
 * @param center The center of the map to be mapped.
 * @param radian Picture rotation Angle. If the Angle is 0, the effect is the same as' setImage:rect: '.
 * @since Available in iOS 4.3 and later.
 */
- (void)setImage:(UIImage *)image inSize:(CGSize)size atCenter:(CGPoint)center radian:(float)radian;

/**
 * Replace the Image data in the rotated rectangular region with replace
 *
 * @param imageData The data of the picture to be mapped is RGBA bytes data from 'CGContextRef', if the data is empty, nothing will be done.
 * @param dataSize The dimensions (width, height) of the picture to be mapped.
 * @param size The size of the area to be mapped.
 * @param center The center of the map to be mapped.
 * @param radian Picture rotation Angle. If the Angle is 0, the effect is the same as setData:dataSize:rect: '。
 * @since Available in iOS 4.3 and later.
 */
- (void)setData:(unsigned char *)imageData dataSize:(CGSize)dataSize inSize:(CGSize)size atCenter:(CGPoint)center radian:(float)radian;

@end

#pragma mark - UndoManager
@interface KMDrawView (UndoManager)

/**
 * cache current image status
 */
- (NSData*)markAction;

/**
 * The latest picture of Mark
 */
- (UIImage*)currentImage;

/**
 * Detects whether you can Undo
 * @return If Undo can be used, YES is returned, otherwise NO is returned
 * @since Available in iOS 4.3 and later.
 */
- (BOOL)canUndo;

/**
 * Undo action
 *
 * @return undo image
 * @since Available in iOS 4.3 and later.
 */
- (NSData*)undo;

/**
 * Check whether Redo is available
 * @return If Redo is allowed, YES is returned. If NO is returned
 * @since Available in iOS 4.3 and later.
 */
- (BOOL)canRedo;

/**
 * Redo action
 *
 * @return redo image
 * @since Available in iOS 4.3 and later.
 */
- (NSData*)redo;

/**
 * Reset Undo Manager
 * @return the current image
 * @since Available in iOS 4.3 and later.
 */
- (NSData*)resetUndoManager;

- (NSData*)loadUndoManager;

@end


#if EnableRecogition
#pragma mark - Recogition
@interface KMDrawView (Recogition)

- (void)freeShapeMemory:(OutputShape)shape;

- (BOOL)drawShape:(OutputShape)shape;

@end
#endif


#pragma mark - DataSave
@interface KMDrawView (DataSave)

@end


#pragma mark - Radius Adjust
@interface KMDrawView (Radius)

- (float)inRadiusForRadius:(float)radius;

- (float)radiusForInRadius:(float)inRadius;

@end

@interface KMDrawView (BrushSetting)

- (void)resetParams;

- (BOOL)resetWithParams:(NSArray*)params
                version:(int32_t)version;

- (BOOL)resetWithKBRPath:(NSString*)kbrPath;

@end

#pragma mark - KMDrawViewDelegate
@protocol KMDrawViewDelegate <NSObject>
@optional
/// Touch point control
//Begin point modification
- (CGPoint)drawView:(KMDrawView *)drawView shouldDrawBegin:(CGPoint)point;
//Move point correction
- (CGPoint)drawView:(KMDrawView *)drawView shouldDrawMove:(CGPoint)point;
//End point correction
- (CGPoint)drawView:(KMDrawView *)drawView shouldDrawEnd:(CGPoint)point;

/// Touch point feedback
- (void)drawView:(KMDrawView *)drawView willDrawBegin:(CGPoint)point;
- (void)drawView:(KMDrawView *)drawView didDrawBegin:(CGPoint)point;

- (void)drawView:(KMDrawView *)drawView willDrawMove:(CGPoint)point;
- (void)drawView:(KMDrawView *)drawView didDrawMove:(CGPoint)point;

- (void)drawView:(KMDrawView *)drawView willDrawEnd:(CGPoint)point;
- (void)drawView:(KMDrawView *)drawView didDrawEnd:(CGPoint)point;

/// Undo/Redo status feedback
- (void)drawView:(KMDrawView *)drawView didUpdateUndoStatus:(BOOL)enable;
- (void)drawView:(KMDrawView *)drawView didUpdateRedoStatus:(BOOL)enable;

@end
