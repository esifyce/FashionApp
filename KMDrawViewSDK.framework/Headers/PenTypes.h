//
//  PenTypes.h
//  KMEAGLViewDeveloperDemo
//
//  Created by zhudongyong on 13-4-7.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#ifndef KMEAGLViewDeveloperDemo_PenTypes_h
#define KMEAGLViewDeveloperDemo_PenTypes_h

#import "KMDrawViewTypes.h"

#ifndef KMPLog

#if DEBUG
#define KMPLog(...) NSLog(__VA_ARGS__)
#else
#define KMPLog(...) {}
#endif

#endif

/** pentype
 The three added stylus are adoint's jot stylus,HEX3's jaja stylus, and Ten One Design's pogo connect stylus
 adoint's jot stylus needs to be connected to a Bluetooth and Jot touch by Adonit device to enter the correct PIN code.
 */
typedef enum {
    TouchPenTypeNone    = 0,
#if kEnableJotPen
    TouchPenTypeJot     = 1,
#endif//kEnableJotPen
#if kEnablePogoPen
    TouchPenTypePogo    = 1 << 1,
#endif//kEnablePogoPen
#if kEnableJajaPen
    TouchPenTypeJaja    = 1 << 2,
#endif//kEnableJajaPen
#if kEnableWacomPen
    TouchPenTypeWacom   = 1 << 3,
#endif//kEnableWacomPen
    TouchPenTypeAll     = 0xffff,
}TouchPenType;
#define NumberOfTouchPenType    4

#define kNameTouchPenJot    @"Jot"    //adoint's jot stylus
#define kNameTouchPenPogo   @"Pogo"   //Ten One Design's pogo connect stylus
#define kNameTouchPenJaja   @"Jaja"   //The HEX3 jaja stylus
#define kNameTouchPenWacom  @"Wacom"   //Wacom's Wacom stylus

/**
 * Number of buttons for the stylus
 */
typedef enum { // Possible button numbers for devices with lots of buttons
    TouchPenButton1 = 0, // first, and usually the only button
	TouchPenButton2,     // a second button, and so on
	TouchPenButton3,
	TouchPenButton4,
	TouchPenButton5,
	TouchPenButton6,
    TouchPenButton7,
    TouchPenButton8
}TouchPenButton;

typedef enum {
    PenActionTypeKeyDown,
    PenActionTypeKeyUp,
    PenActionTypeKeyLongPressed
}PenActionType;

#define kDeviationValue     (0.01)
#define kPressMaxLevel      (2048.0)

#endif
