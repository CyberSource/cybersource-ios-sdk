//
//  InAppSDKGatewayCore.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

@class InAppSDKMerchant;
@class InAppSDKTransactionObject;

@interface InAppSDKGatewayCore : NSObject <InAppSDKClientServerDelegate>

//! Indicates if the payment is in progress. Only one payment can be made at a time
@property (nonatomic, assign, getter = isGWServiceInProgress) BOOL gwServiceInProgress;

//! A singleton shared handler
/*!
 \return The \c InAppSDKGatewayCore object
 */
+ (InAppSDKGatewayCore *) sharedInstance;

//! Provides the capability to issue an Authorization with \c paramTransaction parameter
/*! Only one request can be performed at the same time.
 \param paramTransaction Transaction data required to make a request. If \c paramTransaction is not complete the request will not be performed.
 \param paramDelegate delegate which conforms to @see InAppSDKGatewayDelegate protocol
 \return Returns \c YES if payment request is being performed and \c NO otherwise.
 */

- (BOOL) performPaymentDataEncryption:(InAppSDKTransactionObject *)aTransactoinObject withDelegate:(id<InAppSDKGatewayDelegate>)aDelegate;

//! Provides the capability to issue an Authorization with \c paramTransaction parameter
/*! Only one request can be performed at once.
 \param paramTransaction Transaction data required to make a request. If \c paramTransaction is not complete the request will not be performed.
 \param paramDelegate delegate which conforms to @see InAppSDKGatewayDelegate protocol
 \return Returns \c YES if payment request is being performed and \c NO otherwise.
 */

- (BOOL) performApplePayAuthorization:(InAppSDKTransactionObject *)aTransactoinObject withDelegate:(id<InAppSDKGatewayDelegate>)aDelegate;

@end
