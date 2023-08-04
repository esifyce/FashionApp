//
//  TextureTypes.h
//  KMDrawViewDemo
//
//  Created by zhudongyong on 14-4-17.
//  Copyright (c) 2014年 kdanmobile. All rights reserved.
//

#ifndef KMDrawViewDemo_TextureTypes_h
#define KMDrawViewDemo_TextureTypes_h

typedef NS_ENUM(int32_t, TextureType) {
    TextureTypeNormal,      //Normal texture, control parameter: radius
    TextureTypeCircle,      //Round texture, control parameters: radius, hardness
    TextureTypeRing,        //Ring texture, control parameters: radius, hardness, width
    TextureTypeRectangle,   //Rectangle texture, control parameters: radius, hardness, aspect ratio
    TextureTypeCount,
};


#endif
