//
//  InAppSDKClientServerProtocol.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#ifndef InAppSDK_InAppSDKClientServerProtocol_h
#define InAppSDK_InAppSDKClientServerProtocol_h

//! The client the server gateway communication protocol
/*! Enables the retrieval of feedback from the communication between the client and the server.
 */
@protocol InAppSDKClientServerDelegate <NSObject>

@required
//! Provides feedback from a completed request.
/*!
 \param paramRequestType Request ID defined as @see InAppSDKGatewayApiType
 \param paramData Data received from the server
 \param paramError An error if the request fails
 */
- (void) requestWithId:(InAppSDKGatewayApiType)paramRequestType
      finishedWithData:(id)paramData
             withError:(InAppSDKError *)paramError;

@end

#endif
