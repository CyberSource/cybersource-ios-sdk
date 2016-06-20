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
        _street1 = [NSString string];
        _city = [NSString string];
        _state = [NSString string];
        _postalCode = [NSString string];
        _country = [NSString string];
        _email = [NSString string];
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
    
    if (self.street1)
    {
      copiedAddress.street1 = self.street1;
    }

    if (self.city)
    {
      copiedAddress.city = self.city;
    }

    if (self.state)
    {
      copiedAddress.state = self.state;
    }

    if (self.postalCode)
    {
      copiedAddress.postalCode = self.postalCode;
    }

    if (self.country)
    {
      copiedAddress.country = self.country;
    }

    if (self.email)
    {
        copiedAddress.email = self.email;
    }

    return copiedAddress;
}



@end
