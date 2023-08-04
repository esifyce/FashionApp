//
//  ESContextTypes.h
//  KMDrawViewDemo
//
//  Created by zhudongyong on 14-3-15.
//  Copyright (c) 2014年 kdanmobile. All rights reserved.
//

#ifndef KMDrawViewDemo_ESContextTypes_h
#define KMDrawViewDemo_ESContextTypes_h

typedef NS_ENUM(NSUInteger, ESBlendType) {
    ESBlendTypeErase,
    ESBlendTypeRenderLine,
    ESBlendTypeSetImage,
    ESBlendTypePasteImage
};

typedef NS_ENUM(NSUInteger, ESRenderLayerType) {
    ESRenderLayerTypeImage        = 0,
    ESRenderLayerTypeBaseLine     = 1,
    ESRenderLayerTypeSubLine      = 2,
    ESRenderLayerTypeSmudge       = 3,
    ESRenderLayerTypeCount
};

#endif
