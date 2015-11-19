//
//  InAppSDKSettings.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

/**
 * The LIVE or TEST server
 *
 */
typedef enum InAppSDKEnvironment
{
    INAPPSDK_ENV_LIVE,
    INAPPSDK_ENV_TEST,
    
} INAPPSDK_ENVIRONMENT;

@interface InAppSDKSettings : NSObject <NSCoding>

/*!
 Live or Test server
 */
@property (nonatomic, assign) INAPPSDK_ENVIRONMENT inAppSDKEnvironment;

//! Returns singleton InAppSDKSettings object
/*!
 Returns singleton InAppSDKSettings object
 Object is restored from keychain
 */
+ (InAppSDKSettings *) sharedInstance;

//! Set Server URL which would take precedence over the SDK provided server URL.
-(void)setServerURL:(NSString *) serverURL;

//! Timeout Interval in secs. Default 110.
@property (nonatomic, assign) NSTimeInterval timeOut;

//! Turn ON / OFF very basic Request and Response Logging for trouble shooting. Default OFF.
@property (nonatomic, assign) BOOL enableLog;

//! Save settings to keychain
/*!
 Save settings to keychain
 Return result of operation
 */
- (BOOL) saveSettings;

//! Remove settings from keychain
+ (void) removeSettings;

@end
