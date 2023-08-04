//
//  KMBrushManager.h
//  GreatPainter
//
//  Created by kdanmobile13 on 13-1-29.
//  Copyright (c) 2013年 Liuyu. All rights reserved.
//

#ifndef KM_Brush_Manager
#define KM_Brush_Manager

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#import "UIColor+Mac.h"
#import "UIImage+Mac.h"
#endif//TARGET_OS_IOS

#import "KMDrawView.h"


#pragma mark - Data Parse
extern NSString *const kBrushNameKey;
extern NSString *const kBrushVersionKey;
extern NSString *const kBrushParamsKey;
extern NSString *const kBrushCreatorNameKey;
extern NSString *const kBrushCreatTimeKey;

extern NSString *const kBrushParamMethodValueKey;
extern NSString *const kBrushParamIDValueKey;
extern NSString *const kBrushParamPropertyValueKey;
extern NSString *const kBrushParamPropertyTypeKey;


#define ParamIDOfParam(param)               [[param valueForKey:kBrushParamIDValueKey] integerValue]
#define ParamMethodOfParam(param)           [param valueForKey:kBrushParamMethodValueKey]
#define ParamPropertyValueOfParam(param)    [param valueForKey:kBrushParamPropertyValueKey]
#define ParamTypeOfParam(param)             [[param valueForKey:kBrushParamPropertyTypeKey] integerValue]


@interface KMBrushManager : NSObject

/**
 * Gets the brush configuration of the DrawView
 * @param drawView Specifies the drawing control for which the parameters are to be saved
 * @return Parameter list
 */
+ (NSArray*)paramsOfDrawView:(KMDrawView*)drawView;

//Save the current brush parameters of the drawing control
/**
 * Save brush
 * @param drawView    Specifies the drawing control for which the parameters are to be saved
 * @param brushName   The name of the brush
 * @param path        Brush saving path
 */
+ (void)saveParamsWithDrawView:(KMDrawView*)drawView
                      withName:(NSString*)brushName
                        inPath:(NSString*)path;

//Set parameters, kbrPath is the kbr (KdanMobile Brush Resource) brush file path
/**
 * Sets the drawing control parameter to the last set of brush parameters in the kbr file
 * @param drawView    Drawing control to be set
 * @param kbrPath     kbr (KdanMobile Brush Resource) Brush file path
 * @return Returns NO if the parameter setting failed because the drawing control does not exist or the brush file does not exist (or failed to read), otherwise returns YES
 * @note The default value of the brush configuration parameter in 'kbrPath', then the default value of the corresponding parameter of the drawing control is used
 */
+ (BOOL)resetDrawView:(KMDrawView*)drawView
          withKBRFile:(NSString*)kbrPath;

//To set the brush parameters, the default item in the 'params' parameter, uses the default value of the corresponding parameter of the drawing control
/**
 * Sets the drawing control parameter to the last set of brush parameters in the kbr file*
 * @param drawView    Drawing control to be set
 * @param params      kbr (KdanMobile Brush Resource) Brush configuration parameters
 * @param version     Parameter version
 * @return Returns NO if the parameter setting failed because the drawing control does not exist or the brush file does not exist (or failed to read), otherwise returns YES
 * @note Default item in the 'params' parameter, the default value of the corresponding parameter of the drawing control is used
 */
+ (BOOL)resetDrawView:(KMDrawView *)drawView
           withParams:(NSArray*)params
              version:(int32_t)version;

//Save Params
/**
 * Save brush
 * @param params      Brush parameter dictionary
 * @param brushName   The name of the brush
 * @param path        Brush saving path
 */
+ (void)saveParams:(NSArray*)params
           version:(int32_t)version
          withName:(NSString*)brushName
            inPath:(NSString*)path;

//Save Params
/**
 * Save brush
 * @param params        Brush parameter dictionary
 * @param brushName     The name of the brush
 * @param creatorName   The creator of the brush
 * @param creatTime     The creation time of the brush
 * @param path          Brush saving path
 */
+ (void)saveParams:(NSArray*)params
           version:(int32_t)version
          withName:(NSString*)brushName
   withCreatorName:(NSString*)creatorName
     withCreatTime:(NSString*)creatTime
            inPath:(NSString*)path;

//Brush information read
/**
 * Read the kbr (KdanMobile Brush Resource) file brush parameters corresponding to 'kbrPath'
 * @param kbrPath   Specifies the kbr (KdanMobile Brush Resource) brush parameter file to read the brush
 * @return 'kbrPath' brush file all brushes, format as follows
 *  ***************************************************************
 *  brushes<NSArray> - item 1<NSDictionary> -- brushName<NSString:kBrushNameKey>
 *                   |                      |
 *                   |                      -- params<NSArray:kBrushParamsKey> - item 1<NSDictionary> - idValue<NSNumber:kBrushParamIDValueKey>
 *                   |                                                         |                      |
 *                   |                                                         |                      - propertyValue<id:kBrushParamPropertyValueKey>
 *                   |                                                         |                      |
 *                   |                                                         |                      - propertyType<NSNumber:kBrushParamPropertyTypeKey>
 *                   |                                                         .                      |
 *                   |                                                         .                      - MethodValue<NSString:kBrushParamMethodValueKey>
 *                   - item 2 ...                                              .
 *                   .                                                         - item n<NSDictionary>
 *                   .
 *                   .item 3<NSDictionary> -- creatorName<NSString:kBrushCreatorNameKey>
 *                   .
 *                   .item 4<NSDictionary> -- creatTime<NSString:kBrushCreatTimeKey>
 *                   .
 *                   - item n
 *  ***************************************************************
 */
+ (NSArray*)brushesWithKBRPath:(NSString*)kbrPath
                       version:(int32_t*)version;

//Param Value
/**
 */
+ (NSDictionary*)paramWithID:(NSUInteger)idValue
                      method:(NSString*)methodValue
               propertyValue:(id)propertyValue
                propertyType:(NSUInteger)type;

@end

#endif//KM_Brush_Manager
