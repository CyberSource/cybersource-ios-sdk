//
//  InAppSDKCybsResponseNodeReplyMessage.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNodeReplyMessage.h"

@implementation InAppSDKCybsResponseNodeReplyMessage

static NSString * const kCybsNodeReplyMessage = @"replyMessage";

- (id) init
{
    self = [super init];
    if (self)
    {
        self.startingNodeName = kCybsNodeReplyMessage;
        _decision = nil;
        _merchantReferenceCode = nil;
        _reasonCode = nil;
        _requestID = nil;
        _requestToken = nil;
        _reconciliationID = nil;
        _missingField = nil;
        _invalidField = nil;
        _data = nil;
    }
    return self;
}

@end
