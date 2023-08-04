//
//  ESShaderTools.h
//  KMDrawViewDemo
//
//  Created by dongyongzhu on 16/2/25.
//  Copyright © 2016年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESShaderTools : NSObject

/**
 * @discussion Load the shader code from the MainBundle filename
 * @param name The file name of the shader
 * @return the code of the shader
 */
+ (NSString *)readFile:(NSString *)name;

/**
 * @discussion Load the shader code from the path
 * @param path The file path of the shader
 * @return the code of the shader
 */
+ (NSString *)readFileWithPath:(NSString*)path;

@end
