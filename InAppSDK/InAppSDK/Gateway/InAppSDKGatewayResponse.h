//
//  InAppSDKGatewayResponse.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKEncryptedPayment.h"

//!Representation of a type of the request status.
/*!
 This enumeration represents different types of CyberSource APIs.
 */
typedef enum
{
    INAPPSDK_GATEWAY_DECISION_TYPE_UNKNOWN = 0, /*!< Unknown */
    INAPPSDK_GATEWAY_DECISION_TYPE_ACCEPT,      /*!< Request accepted */
    INAPPSDK_GATEWAY_DECISION_TYPE_ERROR,       /*!< There was a system error. */
    INAPPSDK_GATEWAY_DECISION_TYPE_REJECT,      /*!< One or more of the service requests was declined. */
    INAPPSDK_GATEWAY_DECISION_TYPE_REVIEW,      /*!< Decision Manager flagged the order for review. */
    INAPPSDK_GATEWAY_DECISION_TYPE_FAILED       /*!< Request failed */
    
} InAppSDKGatewayResponseDecisionType;

@interface InAppSDKGatewayResponse : NSObject

//! the decision
@property (nonatomic, assign) InAppSDKGatewayResponseDecisionType decision;
//! the request ID
@property (nonatomic, strong) NSString *requestId;
//! the result code
@property (nonatomic, strong) NSString *resultCode;

//! Contains the encrypted payment data
@property (atomic, strong) InAppSDKEncryptedPayment *encryptedPayment;
//! the request type
@property (nonatomic, assign) InAppSDKGatewayApiType type;
//! Date
@property (nonatomic, strong) NSDate *date;

//! Return YES if gateway response was accepted by gateway
- (BOOL) isAccepted;

@end
