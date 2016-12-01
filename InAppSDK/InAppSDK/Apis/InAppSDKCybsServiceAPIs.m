//
//  InAppSDKCybsServiceAPIs.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsServiceAPIs.h"
#import "InAppSDKSoapStructure.h"
#import "InAppSDKSoapNode.h"
#import "InAppSDKRequestInfo.h"
#import "InAppSDKCybsSoapRequest.h"
#import "InAppSDKGatewayProtocol.h"
#import "InAppSDKConnection.h"


@implementation InAppSDKCybsServiceAPIs

+ (BOOL) requestEncryptPaymentDataService:(InAppSDKTransactionObject *)aTransaction withDelegate:(id)aDelegate
{
    
    if (aDelegate == nil)
    {
        // will not proceed with request if there is no delegate to handle to respond
        return NO;
    }
    
    InAppSDKSoapStructure * requestMessage = [InAppSDKSoapNode createEncryptPaymentDataServiceRequestMessageWithTransaction:aTransaction];
    
    if (requestMessage == nil)
    {
        // request message failed to be created
        return NO;
    }
    
    // create request
    InAppSDKRequestInfo * newRequestInfo = [[InAppSDKRequestInfo alloc] init];
    newRequestInfo.delegate = aDelegate;
    newRequestInfo.request = [InAppSDKCybsSoapRequest createCardRequestWithSoapMessage:requestMessage];
    newRequestInfo.requestType = INAPPSDK_GATEWAY_API_TYPE_ENCRYPT;
    if (newRequestInfo.request == nil)
    {
        // request failed to be created
        return NO;
    }
    
    // execute request
    [[InAppSDKConnection sharedInstance] makeRequest:newRequestInfo];
    
    return YES;
    
}

+ (BOOL) requestApplePayAuthorizationService:(InAppSDKTransactionObject *)aTransaction withDelegate:(id<InAppSDKClientServerDelegate>)aDelegate;
{

    if (aDelegate == nil)
    {
      // will not proceed with request if there is no delegate to handle to respond
      return NO;
    }

    InAppSDKSoapStructure * requestMessage = [InAppSDKSoapNode createApplePayAuthorizationServiceRequestMessageWithTransaction:aTransaction];

    if (requestMessage == nil)
    {
      // request message failed to be created
      return NO;
    }

    // create request
    InAppSDKRequestInfo * newRequestInfo = [[InAppSDKRequestInfo alloc] init];
    newRequestInfo.delegate = aDelegate;
    newRequestInfo.request = [InAppSDKCybsSoapRequest createApplePayRequestWithSoapMessage:requestMessage];
    newRequestInfo.requestType = INAPPSDK_GATEWAY_API_TYPE_ENCRYPT;
    if (newRequestInfo.request == nil)
    {
      // request failed to be created
      return NO;
    }

    // execute request
    [[InAppSDKConnection sharedInstance] makeRequest:newRequestInfo];

    return YES;

}


@end
