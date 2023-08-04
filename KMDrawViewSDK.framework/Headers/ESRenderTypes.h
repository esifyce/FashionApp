//
//  ESRenderTypes.h
//  KMDrawViewDemo
//
//  Created by zhudongyong on 14-3-15.
//  Copyright (c) 2014年 kdanmobile. All rights reserved.
//

#ifndef KMDrawViewDemo_ESRenderTypes_h
#define KMDrawViewDemo_ESRenderTypes_h

#import <Foundation/Foundation.h>
#if !TARGET_OS_IOS
#import <Cocoa/Cocoa.h>
#endif

#if !TARGET_OS_IOS

typedef struct {
    GLfloat x,y;
} Vector2;

typedef struct {
    GLfloat x,y,z,w;
} Vector4;

typedef struct {
    Vector4 position;
    Vector2 textureCoord;
}LineBuffer;

typedef struct {
    Vector4 position;
    Vector2 textureCoord;
    Vector2 bgCoord;
}SmudgeBuffer;
#endif

typedef enum {
    ESBrushTypeNormal           = 0x0000,   //Default Brush
//    ESBrushTypePencil           = 0x0001,   //Pencil Tool
//    ESBrushTypeColorReplace     = 0x0002,   //Color substitution tool
    ESBrushTypeSmudge           = 0x0003,    //Smudge tool
    ESBrushTypeLeaf             = 0x0004,   //Willow leaf pen
}ESBrushType;

typedef enum {
    ESLineProcessTypeNone       = 0x0000,
    ESLineProcessTypeLineWidth  = 0x0001,
    ESLineProcessTypeFlow       = 0x0002,
    ESLineProcessTypeAll        = ESLineProcessTypeLineWidth | ESLineProcessTypeFlow,
}ESLineProcessType;

typedef enum {
    ESLayerBlendTypeUnknow              = 0x0000,//Use Redifine
    //-------------------------
    //Normal Blend mode
    ESLayerBlendTypeNormal              = 0x0001,//C = D * (1 - As) + S
    //Replace Blend Mode
    ESLayerBlendTypeReplace             = 0x0002,//C = S
    //Dissolution Blend Mode
    ESLayerBlendTypeDissolution         = 0x0003,//
    //Behind Blend Mode
    ESLayerBlendTypeBehind              = 0x0004,//C = S * (1 - Ad) + D
    //Erase Blend Mode
    ESLayerBlendTypeErase               = 0x0005,//C = D * (1 - As)
    
    //-------------------------
    //Tarnish Blend Mode
    ESLayerBlendTypeTarnish             = 0x0006,//C = MIN(S, D)
    //Brightness Blend Mode
    ESLayerBlendTypeBrightness          = 0x0007,//C = MAX(S, D)
    //Multiply Blend Mode
    ESLayerBlendTypeMultiply            = 0x0008,//C = S * D
    //Reset Blend Mode
    ESLayerBlendTypeReset               = 0x0009,//C = D
}ESLayerBlendType;


#if TARGET_OS_IOS
#pragma mark - Shaders
//Base Line Render Shaders
extern NSString *const kBaseRenderVertexShaderString;
extern NSString *const kBaseRenderFrangmentShaderString1;
extern NSString *const kBaseRenderFrangmentShaderString2;

//Line Render Shaders
extern NSString *const kLineRenderNormalVertexShaderString;
extern NSString *const kLineRenderNormalFrangmentShaderString;

//Smudge Render Shaders
extern NSString *const kSmudgeRenderSmudgeVertexShaderString;
extern NSString *const kSmudgeRenderSmudgeFrangmentShaderString;

//Image Render Shaders
extern NSString *const kImageRenderVertexShaderString;
#endif

#endif
