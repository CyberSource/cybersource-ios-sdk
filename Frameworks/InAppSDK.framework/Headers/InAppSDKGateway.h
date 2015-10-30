//
//  InAppSDKGateway.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKGatewayProtocol.h"
#import "InAppSDKTransactionObject.h"

@interface InAppSDKGateway : NSObject

//! singleton shared handler
/*!
 \return The \c InAppSDKGateway object
 */
+ (InAppSDKGateway *) sharedInstance;


//! Provides the capability to encrypt the Payment Data.
/*! Only one request can be performed at the same time.
 \param aDelegate delegate which conforms to @see InAppSDKGatewayDelegate protocol
 \return Returns \c YES if payment request is being performed and \c NO otherwise.
 */
- (BOOL) performPaymentDataEncryption:(InAppSDKTransactionObject *)aTransactoinObject withDelegate:(id<InAppSDKGatewayDelegate>)aDelegate;

@end
