//
//  InAppSDKCybsServiceAPIs.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKTransactionObject.h"
#import "InAppSDKClientServerProtocol.h"

//! CyberSource Service APIs
/*! The CyberSource Gateway Serice APIs provides various services supported.
 */

@interface InAppSDKCybsServiceAPIs : NSObject

//! CyberSource Encrypt PaymentData Service API
/*! Enables the creationg of Encrypt PaymentData Service request with data defined in \c aTransaction @see InAppSDKTransactionObject
 Feedback is provided to \c aDelegate via @see InAppSDKClientServerDelegate protocol
 \param aTransaction the transaction object. It must not be nil. the following fields are required and must not be nil:
 \c aTransaction.merchant
 \c aTransaction.card
 \param aDelegate Delegate that conforms to @see InAppSDKClientServerDelegate protocol, which must not be nil.
 \return YES if request was successfully prepared. Otherwise NO.
 */
+ (BOOL) requestEncryptPaymentDataService:(InAppSDKTransactionObject *)aTransaction withDelegate:(id<InAppSDKClientServerDelegate>)aDelegate;

//! CyberSource Encrypt PaymentData Service API
/*! Enables creating an Apple Pay Authorization Service request with data defined in \c aTransaction @see InAppSDKTransactionObject
 Feedback is provided to \c aDelegate via @see InAppSDKClientServerDelegate protocol
 \param aTransaction the transaction object. It must not be nil. the following fields are required and must not be nil:
 \c aTransaction.merchant
 \c aTransaction.encryptedPaymentData
 \param aDelegate Delegate that conforms to @see InAppSDKClientServerDelegate protocol, which must not be nil.
 \return YES if request was successfully prepared. Otherwise NO.
 */
+ (BOOL) requestApplePayAuthorizationService:(InAppSDKTransactionObject *)aTransaction withDelegate:(id<InAppSDKClientServerDelegate>)aDelegate;

@end
