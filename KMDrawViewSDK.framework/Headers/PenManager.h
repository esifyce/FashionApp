//
//  PenManager.h
//  KMEAGLViewDeveloperDemo
//
//  Created by zhudongyong on 13-4-7.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#else
#import <AppKit/AppKit.h>
#endif

#import "KMDrawViewTypes.h"

#import "PenTypes.h"


extern NSString     *PenTypeKey;
extern NSString     *PenNameKey;
extern NSString     *PenObjectKey;

extern NSString *const StylusManagerDiscoveryAttemptedButBluetoothOffNotification;

@protocol PenManagerResignDataSource;
@protocol PenManagerTouchEventDelegate;
@protocol PenManagerConnectDelegate;
@protocol PenManagerActionDelegate;

@class T1PogoPen;
@interface PenManager : NSObject
@property (nonatomic, retain, readonly) NSArray                 *connectPens;
@property (nonatomic, retain, readonly) NSArray                 *connectPenNames;
@property (nonatomic, retain, readonly) NSMutableDictionary     *usedPen;
@property (nonatomic, readonly) BOOL                    penConnect;
@property (nonatomic, readonly) BOOL                    gestureEnable;

@property (nonatomic, readonly) BOOL                    isBluetoothValid;
//
//#if kEnableJotPen
//@property (nonatomic, retain) AdonitDrawingAideOverlayView    *rulerOverlayView;
//#endif

@property (nonatomic, weak) id<PenManagerConnectDelegate> connectDelegate;
@property (nonatomic, weak) id<PenManagerActionDelegate>  actionDelegate;
@property (nonatomic, weak) id<PenManagerResignDataSource>dataSource;
@property (nonatomic, weak) id<PenManagerTouchEventDelegate> touchEventDelegate;

+ (PenManager *)defaultManager;

//Initialize the digital pen SDK
- (void)startPenWithType:(TouchPenType)type;
- (void)stopPenWithType:(TouchPenType)type;
- (void)stopPenWithType:(TouchPenType)type force:(BOOL)force;

//Discover
- (void)discoverDeviceForPenType:(TouchPenType)type;

- (void)stopDiscover;
- (void)stopDiscoverForPenType:(TouchPenType)type;


- (NSArray*)pensForType:(TouchPenType)type;

- (NSMutableDictionary*)penForName:(NSString*)name type:(TouchPenType)type;

- (TouchPenType)typeForPen:(NSMutableDictionary*)pen;

#if kEnablePogoPen
- (void)pickColor:(UIColor *)color;     //Pogo pen light color Settings
#endif//kEnablePogoPen

- (BOOL)usePen:(NSDictionary*)pen withRegisterView:(UIView*)view;

- (BOOL)usePenAtIndex:(NSUInteger)index withRegisterView:(UIView*)view;

- (BOOL)usePenWithName:(NSString*)pen type:(TouchPenType)type withRegisterView:(UIView*)view;

- (void)denialPenWithName:(NSString*)pen type:(TouchPenType)type;

- (void)denialPen:(NSDictionary*)pen;

- (void)denialUsedPen;

- (BOOL)isPenForTouch:(id)touch;

- (float)pressureForUITouch:(id)touch;
- (void)resetDefaultPressure;

@end

@interface PenManager (Pen)

- (NSString*)penNameOfPen:(NSDictionary*)pen;

- (TouchPenType)penTypeOfPen:(NSDictionary*)pen;

- (id)penObjectOfPen:(NSDictionary*)pen;

@end


@protocol PenManagerResignDataSource <NSObject>

- (UIView*)penManager:(PenManager*)manager resignForPenType:(TouchPenType)type;

@end

@protocol PenManagerConnectDelegate <NSObject>
@optional
- (void)penManager:(PenManager*)manager didFindNewPen:(NSDictionary*)pen;

- (void)penManager:(PenManager *)manager didUsePen:(NSDictionary *)pen;

- (void)penManager:(PenManager *)manager didDenialPen:(NSDictionary *)pen;

- (void)penManager:(PenManager *)manager didDisconnectPen:(NSDictionary*)pen;

@end


@protocol PenManagerActionDelegate <NSObject>
@optional
- (void)penManager:(PenManager *)manager didReceiveActionButtonIndex:(TouchPenButton)index actionType:(PenActionType)actionType;

//In Jot mode, gestures are disabled at the beginning and enabled at the end
- (void)penManager:(PenManager *)manager didBeginDrawingWithType:(TouchPenType)type;

- (void)penManager:(PenManager *)manager didFinishedDrawingWithType:(TouchPenType)type;

//Pogo mode, enable gestures, otherwise disable gestures
- (void)penManager:(PenManager *)manager didUpdateGestureEnable:(BOOL)enable;

@end


@protocol PenManagerTouchEventDelegate <NSObject>
@optional
- (void)touchesBegan:(UITouch *)touch;

- (void)touchesMoved:(UITouch *)touch;

- (void)touchesEnded:(UITouch *)touch;

- (void)touchesCancelled:(UITouch *)touch;

@end


@interface UITouch (Pen)

- (BOOL)isPenTouch;

- (float)penPressure;

- (CGPoint)adjustLocationInView:(UIView *)view;

- (float)penAltitudeAngle;

@end

#if kEnableJotPen
@interface NSObject (Pen)

- (BOOL)isPenTouch;

- (float)penPressure;

- (CGPoint)adjustLocationInView:(UIView *)view;

- (float)penAltitudeAngle;

@end
#endif//kEnableJotPen
