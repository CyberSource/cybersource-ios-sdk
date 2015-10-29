//
//  InAppSDKTransactionObject.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//
#import "InAppSDKCardData.h"
#import "InAppSDKMerchant.h"

#import "InAppSDKTransactionObject.h"

@implementation InAppSDKTransactionObject

- (id) init
{
    self = [super init];
    if(self)
    {
        _merchant = nil;
        _cardData = nil;
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
    
    return copiedTransaction;
}



@end
