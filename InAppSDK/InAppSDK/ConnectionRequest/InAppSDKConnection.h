//
//  InAppSDKConnection.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

@class InAppSDKRequestInfo;

@interface InAppSDKConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

//! A Singleton shared handler
/*!
 \return The \c InAppSDKConnection object
 */
+ (InAppSDKConnection *) sharedInstance;

//! This method enables the creation of a request to the CyberSourse server
/*! This method adds a new request to the request queue. The connection to the server is synchronous. The queue is managed as FIFO.
 \param aRequestInfo request object of @see InAppSDKConnection. It must not be nil
 */
- (void) makeRequest:(InAppSDKRequestInfo *)aRequestInfo;


@end
