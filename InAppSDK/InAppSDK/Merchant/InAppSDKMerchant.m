//
//  InAppSDKMerchant.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKMerchant.h"

@implementation InAppSDKMerchant

const int kInAppSDKMechantIdLengthMin = 1;
const int kInAppSDKMechantIdLengthMax = 30;

- (id) init
{
    self = [super init];
    
    if (self)
    {
        _merchantID = nil;
        _merchantReferenceCode = [NSString stringWithFormat:@"iOS_InAppSDK%.0f", ([[NSDate date] timeIntervalSince1970] * 1000)];
        _passwordDigest = nil;
        _userName = nil;
    }
    return self;
}

- (void) setMerchantID:(NSString *)paramMerchantID
{
    // TODO: allow only valid merchantID, set nil otherwise e.g string with 30 characters
    if (([paramMerchantID length] >= kInAppSDKMechantIdLengthMin) &&
        ([paramMerchantID length] <= kInAppSDKMechantIdLengthMax))
    {
        _merchantID = paramMerchantID;
    }
    else
    {
        _merchantID = nil;
    }
}

- (void) setMerchantReferenceCode:(NSString *)paramMerchantReferenceCode
{
    // TODO: allow only valid merchantID, set nil otherwise e.g string with 30 characters
    if (paramMerchantReferenceCode != nil)
    {
        _merchantReferenceCode = paramMerchantReferenceCode;
    }
    else
    {
        _merchantReferenceCode = nil;
    }
}

- (void) setPasswordDigest:(NSString *)paramPasswordDigest
{
    // TODO: allow only valid merchantID, set nil otherwise e.g string with 30 characters
    if (paramPasswordDigest != nil && [paramPasswordDigest length] > 0 )
    {
        _passwordDigest = paramPasswordDigest;
    }
    else
    {
        _passwordDigest = nil;
    }
}

- (void) setUserName:(NSString *)paramUserName
{
    // TODO: allow only valid merchantID, set nil otherwise e.g string with 30 characters
    if (paramUserName != nil && [paramUserName length] > 0 && [paramUserName length] <= 30 )
    {
        _userName = paramUserName;
    }
    else
    {
        _userName = nil;
    }
}

- (id) copyWithZone:(NSZone *)zone
{
    
    InAppSDKMerchant *copiedMerchant = [[InAppSDKMerchant alloc] init];
    
    if (self.merchantID)
    {
        copiedMerchant.merchantID = self.merchantID;
    }
    
    if (self.merchantReferenceCode)
    {
        copiedMerchant.merchantReferenceCode = self.merchantReferenceCode;
    }
    
    if (self.passwordDigest)
    {
        copiedMerchant.passwordDigest = self.passwordDigest;
    }
    
    if (self.userName)
    {
        copiedMerchant.userName = self.userName;
    }
    
    return copiedMerchant;
}


@end
