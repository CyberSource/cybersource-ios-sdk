//
//  InAppSDKMerchant.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//


@interface InAppSDKMerchant : NSObject <NSCopying>

//! Merchant id
@property (nonatomic, copy) NSString *merchantID;
//! Client application user
@property (nonatomic, copy) NSString *merchantReferenceCode;

//! Contains finger print Password Digest also called FingerPrint.
/*!
 \ The password Digest aka FingerPrint needs to provided for each request.
 \ This must be obtained from merchant server Ideally.
 */
@property (nonatomic, copy) NSString *passwordDigest;

//! UserName
@property (nonatomic, copy) NSString *userName;

@end
