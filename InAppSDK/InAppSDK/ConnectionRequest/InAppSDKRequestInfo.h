//
//  InAppSDKRequestInfo.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

@interface InAppSDKRequestInfo : NSObject

//! The request object, @see InAppSDKRequest
@property (nonatomic, strong) NSURLRequest * request;
//! The delegate with implemented @see InAppSDKClientServerDelegate protocol, where connection feedback will be sent
@property (nonatomic, weak) id<InAppSDKClientServerDelegate> delegate;
//! The connection created with \c request
@property (nonatomic, strong) NSURLConnection * connection;
//! The request type defined in @see InAppSDKGatewayApiType
@property (nonatomic, assign) InAppSDKGatewayApiType requestType;
//! This flag deterimines if request should be repeated
@property (nonatomic) BOOL repeatUntilSuccess;

@end
