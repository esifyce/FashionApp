//
//  ImageRenderFSHs.h
//  KMDrawViewDemo
//
//  Created by dongyongzhu on 15/12/21.
//  Copyright © 2015年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#define String(x) #x
#define ShaderString(text) @ String(text)

#define AvailableShaderString(ShaderString, DefaultShaderString) (ShaderString?ShaderString:DefaultShaderString)

#define AdjustShaderString(string)  [string stringByReplacingOccurrencesOfString:@"_Bool" withString:@"bool"]

@interface ImageRenderFSH : NSObject

+ (NSString *)behindFSHString;
+ (NSString *)brightnessFSHString;
+ (NSString *)eraseFSHString;
+ (NSString *)multiplyFSHString;
+ (NSString *)normalFSHString;
+ (NSString *)replaceFSHString;;
+ (NSString *)resetFSHString;
+ (NSString *)tarnishFSHString;

@end
