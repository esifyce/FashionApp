//
//  TesturesTool.h
//  KMDrawViewDemo
//
//  Created by zhudongyong on 14-4-17.
//  Copyright (c) 2014年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TextureTypes.h"
#import "KMDrawView.h"


#define kTextureMinSize     3

@interface TexturesTool : NSObject
@property (nonatomic) TextureType   textureType;
@property (nonatomic) float         hardness;
@property (nonatomic) float         textureControlValue;

@property (nonatomic, retain) UIImage       *image;

- (UIImage*)textureImageWithSize:(int)size;

- (Byte*)textureDataWithSize:(int)size;

@end

