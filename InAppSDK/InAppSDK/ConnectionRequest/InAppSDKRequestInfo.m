//
//  InAppSDKRequestInfo.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKRequestInfo.h"

@implementation InAppSDKRequestInfo

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        _repeatUntilSuccess = NO;
    }
    
    return self;
}

@end
