//
//  KMDrawViewVersion.h
//  KMEAGLViewDemo
//
//  Created by zhudongyong on 13-9-23.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#ifndef KMDrawViewVersion_h
#define KMDrawViewVersion_h

/** Init Version
 */
#define kMDrawViewVersion_1_0_0     @"1.0.0"

/** 
 Modify
 1. Adjust the structure of drawing modules
 2. Adjust the structure of the daub
 3. Fixed stuck iPad Air
 4. Efficiency is greatly improved
 */
#define kMDrawViewVersion_1_1_0     @"1.1.0"

/** 
 Modify
 1. Adjust the smudge function structure
 2. Greatly improve the efficiency of the smear function
 3. Add dimension variable texture to support fine line anti-aliasing
 */
#define KMDrawViewVersion_1_1_1     @"1.1.1"

/** Modify 2014.12.11 by zhudongyong
 1. Upgrade the Pogo SDK to 2.0
 2. Independent setting of the stylus is supported
 */
#define KMDrawViewVersion_1_2_1     @"1.2.1"

/** Modify by zhudongyong at 2015.01.09
 1. Fixed the problem of creating multiple KmdrawViews and releasing one of them first causing data loss when other KmdrawViews are Undo.
 */
#define KMDrawViewVersion_1_2_2     @"1.2.2"

/** Modify by zhudongyong at 2015.01.16
 1. Fixed KMDrawView occasionally crashing when drawing on iOS 8
 */
#define KMDrawViewVersion_1_2_3     @"1.2.3"

/** Modify by zhudongyong at 2015.8.1
 1. Fixed series Crash caused by KMDrawView data initialization failure
 */
#define KMDrawViewVersion_1_2_4     @"1.2.4"

/** Modify by zhudongyong at 2015.10.31
 1. Hardware pressure support for drawing module iPhone 6S & iPhone 6S Plus;
 2. Contact radius support of drawing module;
 3. Correction of rendering Crash in drawing module;
 4. Drawing module is compatible with iOS 9;
 */
#define KMDrawViewVersion_1_3_0     @"1.3.0"

/** Modify by zhudongyong at 2016.03.10
 1. Apple Pencil slope support for drawing module
 2. Drawing module shader supports external Settings
 3. The brush part supports shader Settings
 */
#define KMDrawViewVersion_1_4_0     @"1.4.0"

/** Modify by zhudongyong at 2016.04.14
 1. Upgrade the drawing module Adonit SDK to V3.1
 2. Compatibility problem of drawing module's self-customized layer rendering shader
 */
#define KMDrawViewVersion_1_4_1     @"1.4.1"

/** Modify by zhudongyong at 2016.06.13
 1. Upgrade the Adonit SDK to V3.1
 2. Correction of fragment shader algorithm
 3. Point information export in image rendering process
 */
#define KMDrawViewVersion_1_4_2     @"1.4.2"

/** Modify by zhudongyong at 2016.06.13
 1. Upgrade the Wacom SDK to V2.1.2
 */
#define KMDrawViewVersion_1_4_3     @"1.4.3"

/** Modify by zhudongyong at 2017.10.18
 1.Mac SDK support;
 2.Image shader adds identification identifier
 */
#define KMDrawViewVersion_1_5_0     @"1.5.0"

/** Modify by zhudongyong at 2017.11.28
 1. Smudge related shader optimization
 */
#define KMDrawViewVersion_1_5_1     @"1.5.1"

/** Modify by zhudongyong at 2018.03.12
 1. Optimize the scaling part of the drawing module
 */
#define KMDrawViewVersion_1_5_2     @"1.5.2"


#define KMDrawViewVersion_1_5_3     @"1.5.3"

#define kMDrawViewLatestVersion     KMDrawViewVersion_1_5_3

#endif
