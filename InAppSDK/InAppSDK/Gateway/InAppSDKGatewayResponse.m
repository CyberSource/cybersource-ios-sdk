//
//  InAppSDKGatewayResponse.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKGatewayResponse.h"

@implementation InAppSDKGatewayResponse

- (id) init
{
    self = [super init];
    if (self)
    {
        _decision = INAPPSDK_GATEWAY_DECISION_TYPE_UNKNOWN;
        _requestId = nil;
        _resultCode = nil;
        _encryptedPayment = nil;
        _date = nil;
        _type = INAPPSDK_GATEWAY_API_TYPE_INIT;
        _rmsg = nil;
     }
    return self;
}


- (id) copyWithZone:(NSZone *)zone
{
    
    InAppSDKGatewayResponse *copiedGatewayResponse = [[InAppSDKGatewayResponse alloc] init];
    
    copiedGatewayResponse.decision = self.decision;
    
    if (self.requestId)
    {
        copiedGatewayResponse.requestId = [self.requestId copy];
    }
    if (self.resultCode)
    {
        copiedGatewayResponse.resultCode = [self.resultCode copy];
    }
    if (self.encryptedPayment)
    {
        copiedGatewayResponse.encryptedPayment = [self.encryptedPayment copy];
    }
    if (self.date)
    {
        copiedGatewayResponse.date = [self.date copy];
    }

    return copiedGatewayResponse;
}

- (BOOL) isAccepted
{
    return (self.decision == INAPPSDK_GATEWAY_DECISION_TYPE_ACCEPT);
}


@end
