//
//  InAppSDKInternal.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/16/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//


@interface InAppSDKInternal : NSObject

//! An user name
@property (nonatomic, strong) NSString * userName;
//! A password
@property (nonatomic, strong) NSString * password;
//! A merchant's id
@property (nonatomic, strong) NSString * merchantId;

//! singleton shared handler
/*!
 \return The \c InAppSDKInternal object
 */
+ (InAppSDKInternal *) sharedInstance;

//! reset Credentials
- (void) resetInternal;

@end
