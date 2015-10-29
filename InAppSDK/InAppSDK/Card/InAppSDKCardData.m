//
//  InAppSDKCardData.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCardData.h"

@implementation InAppSDKCardData

- (id) init
{
    self = [super init];
    
    if (self)
    {
        _accountNumber = nil;
        _expirationMonth = nil;
        _expirationYear = nil;
        _cvNumber = nil;
    }
    
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    InAppSDKCardData *copiedKeyedInCardData = [[InAppSDKCardData alloc] init];
    
    
    if (self.accountNumber)
    {
        copiedKeyedInCardData.accountNumber = self.accountNumber;
    }
    
    if (self.expirationMonth)
    {
        copiedKeyedInCardData.expirationMonth = self.expirationMonth;
    }
    
    if (self.expirationYear)
    {
        copiedKeyedInCardData.expirationYear = self.expirationYear;
    }
    
    if (self.cvNumber)
    {
        copiedKeyedInCardData.cvNumber = self.cvNumber;
    }
    
    return copiedKeyedInCardData;
}


@end
