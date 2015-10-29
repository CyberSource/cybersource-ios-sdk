//
//  InAppSDKGatewayProtocol.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#ifndef InAppSDK_InAppSDKGatewayProtocol_h
#define InAppSDK_InAppSDKGatewayProtocol_h

//!Representation of a type of the CyberSource API.
/*!
 This enumeration represents different types of CyberSource APIs.
 */
typedef enum
{
    INAPPSDK_GATEWAY_API_TYPE_INIT = 0,               /*!< Init */
    INAPPSDK_GATEWAY_API_TYPE_ENCRYPT,                /*!< Encrypt */
    
} InAppSDKGatewayApiType;

@class InAppSDKGatewayResponse;
@class InAppSDKError;

@protocol InAppSDKGatewayDelegate <NSObject>

@optional

//! provides feedback from finished encryptionn request
/*!
 \param paramResponseData gateway data retrieved from server (contains information about transaction status)
 \param paramError an error if request failed
 */
- (void) encryptPaymentDataServiceFinishedWithGatewayResponse:(InAppSDKGatewayResponse *)paramResponseData
                                     withError:(InAppSDKError *)paramError;
@end

#endif
