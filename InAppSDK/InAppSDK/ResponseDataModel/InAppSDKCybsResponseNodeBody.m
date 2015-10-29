//
//  InAppSDKCybsResponseNodeBody.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNodeBody.h"


@implementation InAppSDKCybsResponseNodeBody

static NSString * const kInAppSDKCybsNodeBody = @"Body";

- (id) init
{
    self = [super init];
    if (self)
    {
        self.startingNodeName = kInAppSDKCybsNodeBody;
    }
    return self;
}

#pragma mark - Indirect children -

- (InAppSDKCybsResponseNodeReplyMessage *) nodeReplayMessage
{
    if (_nodeReplayMessage == nil)
    {
        [self setNodeReplayMessage:[[InAppSDKCybsResponseNodeReplyMessage alloc] initWithParentNode:self]];
    }
    return _nodeReplayMessage;
}

- (InAppSDKCybsResponseNodeFault *) nodeFault
{
    if (_nodeFault == nil)
    {
        [self setNodeFault:[[InAppSDKCybsResponseNodeFault alloc] initWithParentNode:self]];
    }
    return _nodeFault;
}

#pragma mark - Overriding InAppSDKCybsResponseNode -

- (InAppSDKCybsResponseNode *) startingNode:(NSString *)aNode previousNode:(InAppSDKCybsResponseNode *)aPreviousNode
{
    
    self.currentNodeName = aNode;
    InAppSDKCybsResponseNode * modelForNode = aPreviousNode;
    
    if ([aNode isEqualToString:self.startingNodeName])
    {
        modelForNode = self;
    }
    else if ([aPreviousNode isEqual:self])
    {
        if (![self respondsToSelector:NSSelectorFromString(aNode)])
        { // eliminate direct fields
            modelForNode = [self.nodeReplayMessage startingNode:aNode previousNode:modelForNode];
            modelForNode = [self.nodeFault startingNode:aNode previousNode:modelForNode];
        }
    }
    
    return modelForNode;
}

- (InAppSDKCybsResponseNode *) endingNode:(NSString *)aNode previousNode:(InAppSDKCybsResponseNode *)aPreviousNode
{
    
    self.currentNodeName = nil;
    InAppSDKCybsResponseNode * modelForNode = aPreviousNode;
    
    if ([aPreviousNode isEqual:self])
    {
        if ([aNode isEqualToString:self.startingNodeName])
        {
            modelForNode = nil;
        }
    }
    else
    {
        if (![self respondsToSelector:NSSelectorFromString(aNode)])
        { // eliminate direct fields
            modelForNode = [self.nodeReplayMessage endingNode:aNode previousNode:aPreviousNode];
            modelForNode = [self.nodeFault endingNode:aNode previousNode:aPreviousNode];
        }
    }
    
    return modelForNode;
}

@end
