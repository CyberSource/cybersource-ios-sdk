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
typedef enum CYBSEnvironment
{
    ENV_LIVE,
    ENV_TEST,
    
} CYBS_ENVIRONMENT;

@interface InAppSDKSettings : NSObject <NSCoding>

/*!
 Live or Test server
 */
@property (nonatomic, assign) CYBS_ENVIRONMENT cybsEnvironment;

//! Returns singleton InAppSDKSettings object
/*!
 Returns singleton InAppSDKSettings object
 Object is restored from keychain
 */
+ (InAppSDKSettings *) sharedInstance;

//! Save settings to keychain
/*!
 Save settings to keychain
 Return result of operation
 */
- (BOOL) saveSettings;

//! Remove settings from keychain
+ (void) removeSettings;

@end
