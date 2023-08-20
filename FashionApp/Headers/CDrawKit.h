//
//  CDrawKit.h
//  KMDrawViewDemo
//
//  Created by zenghong on 7/12/22.
//  Copyright © 2022 kdanmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KMDrawView.h"
#import "KMBrushManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDrawKit : NSObject

/**
 * The shared CDrawKit instance.
 *
 * @discussion This is the default instance used in controller instances.
 */
+ (instancetype)sharedInstance;

/**
 * Activate CDrawKit with your license key and secret.
 *
 * @discussion https://www.kdanmobile.com/en/drawing-sdk
 */
+ (void)setLicenseKey:(NSString *)licenseKey secret:(NSString *)licenseSecret;

/**
 * Activate CDrawKit with your license key.
 *
 * @discussion Variant that allows to set options.
 * These can also later be changed via subscripting access.
 * https://www.kdanmobile.com/en/drawing-sdk
 */
+ (void)setLicenseKey:(NSString *)licenseKey secret:(NSString *)licenseSecret options:(NSDictionary<NSString *, id> *)options;

/**
 * Returns the full CDrawKit product version string. (e.g. "CDrawKit 1.0.1 for iOS (101)")
 */
@property(atomic,readonly) NSString *versionString;

/**
 * Returns just the framework version. (e.g. 1.0.1)
 */
@property(atomic,readonly) NSString *versionNumber;

/**
 * The internal build number. Increments with every version.
 */
@property(atomic,readonly) NSUInteger buildNumber;


@end

NS_ASSUME_NONNULL_END
