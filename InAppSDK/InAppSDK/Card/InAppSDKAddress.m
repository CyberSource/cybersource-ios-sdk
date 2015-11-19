//
//  InAppSDKAddress.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 11/18/15.
//  Copyright © 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKAddress.h"

@implementation InAppSDKAddress

- (id) init
{
    self = [super init];
    
    if (self)
    {
        _firstName = [NSString string];
        _lastName = [NSString string];
        _postalCode = [NSString string];
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    InAppSDKAddress *copiedAddress = [[InAppSDKAddress alloc] init];
    
    if (self.firstName)
    {
        copiedAddress.firstName = self.firstName;
    }
    
    if (self.lastName)
    {
        copiedAddress.lastName = self.lastName;
    }
    
    
    if (self.postalCode)
    {
        copiedAddress.postalCode = self.postalCode;
    }

    
    return copiedAddress;
}



@end
