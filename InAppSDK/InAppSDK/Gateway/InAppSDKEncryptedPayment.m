//
//  InAppSDKEncryptedPayment.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKEncryptedPayment.h"

@implementation InAppSDKEncryptedPayment

-(id) init
{
    
    self = [super init];
    
    if (self)
    {
        self.data = nil;

    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    InAppSDKEncryptedPayment *copy = [InAppSDKEncryptedPayment new];
    
    copy.data = self.data;
   
    return copy;
}
@end
