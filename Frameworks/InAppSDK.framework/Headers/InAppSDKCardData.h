//
//  InAppSDKCardData.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//


@interface InAppSDKCardData : NSObject

//! A card's account number
@property (nonatomic, copy) NSString *accountNumber;
//! A card's expiration month
/*! The expiration month should have a format of MM. For example '02' for February
 */
@property (nonatomic, copy) NSString *expirationMonth;
//! A card's expiration year
/*! The expiration year should have a format of YYYY. For example '2013' for the year
 */
@property (nonatomic, copy) NSString *expirationYear;

//! A card verification number
@property (nonatomic, copy) NSString *cvNumber;

@end
