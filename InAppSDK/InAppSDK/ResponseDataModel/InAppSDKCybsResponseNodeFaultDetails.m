//
//  InAppSDKCybsResponseNodeFaultDetails.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNodeFaultDetails.h"

@implementation InAppSDKCybsResponseNodeFaultDetails

static NSString * const kInAppSDKCybsNodeFaultDetails = @"faultDetails";

- (id) init
{
    self = [super init];
    if (self)
    {
        self.startingNodeName = kInAppSDKCybsNodeFaultDetails;
    }
    return self;
}

@end
