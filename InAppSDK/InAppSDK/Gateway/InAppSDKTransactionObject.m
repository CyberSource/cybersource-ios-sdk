//
//  InAppSDKTransactionObject.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//
#import "InAppSDKCardData.h"
#import "InAppSDKMerchant.h"
#import "InAppSDKEncryptedPaymentData.h"
#import "InAppSDKTransactionObject.h"

@implementation InAppSDKTransactionObject

- (id) init
{
    self = [super init];
    if(self)
    {
        _merchant = nil;
        _cardData = nil;
        _billTo = nil;
        _encryptedPaymentData = nil;
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    
    InAppSDKTransactionObject *copiedTransaction = [[InAppSDKTransactionObject alloc] init];
   
    if (self.merchant)
    {
        copiedTransaction.merchant = self.merchant;
    }
    
    if (self.cardData)
    {
        copiedTransaction.cardData = [self.cardData copy];
    }

    if (self.encryptedPaymentData)
    {
        copiedTransaction.encryptedPaymentData = [self.encryptedPaymentData copy];
    }

    if (self.billTo)
    {
        copiedTransaction.billTo = self.billTo;
    }
    
    return copiedTransaction;
}



@end
