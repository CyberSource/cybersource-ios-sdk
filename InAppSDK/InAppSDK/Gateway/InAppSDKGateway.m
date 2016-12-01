//
//  InAppSDKGateway.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKGateway.h"
#import "InAppSDKGatewayCore.h"

@implementation InAppSDKGateway

__strong static InAppSDKGateway * _sharedInstance = nil;

+ (InAppSDKGateway *)sharedInstance
{
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[InAppSDKGateway alloc] init];
    });
    
    return _sharedInstance;
}

+ (id) alloc
{
    @synchronized ([InAppSDKGateway class])
    {
        if (_sharedInstance == nil)
        {
            _sharedInstance = [super alloc];
            return _sharedInstance;
        }
    }
    return nil;
}

-(BOOL) performPaymentDataEncryption:(InAppSDKTransactionObject *)aTransactoinObject withDelegate:(id<InAppSDKGatewayDelegate>)aDelegate
{
    if (aTransactoinObject == nil ||
        aTransactoinObject.cardData == nil ||
        aTransactoinObject.merchant == nil ||
        /*aTransactoinObject.billTo == nil || - Optional */
        aDelegate == nil)
    {
        return NO;
    }
    else
    {
    return [[InAppSDKGatewayCore sharedInstance] performPaymentDataEncryption:aTransactoinObject withDelegate:aDelegate];
    }
}

- (BOOL) performApplePayAuthorization:(InAppSDKTransactionObject *)aTransactoinObject withDelegate:(id<InAppSDKGatewayDelegate>)aDelegate
{
  if (aTransactoinObject == nil ||
      aTransactoinObject.encryptedPaymentData == nil ||
      aTransactoinObject.merchant == nil ||
      aDelegate == nil)
  {
    return NO;
  }
  else
  {
    return [[InAppSDKGatewayCore sharedInstance] performApplePayAuthorization:aTransactoinObject withDelegate:aDelegate];
  }
}

@end
