//
//  InAppSDKCybsResponseNodeDetail.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNodeDetail.h"

@implementation InAppSDKCybsResponseNodeDetail

static NSString * const kInAppSDCybsNodeDetail = @"detail";

- (id) init
{
    self = [super init];
    if (self)
    {
        self.startingNodeName = kInAppSDCybsNodeDetail;
    }
    return self;
}

#pragma mark - Indirect children -

- (InAppSDKCybsResponseNodeFaultDetails *)nodeFaultDetails
{
    if (_nodeFaultDetails == nil)
    {
        [self setNodeFaultDetails:[[InAppSDKCybsResponseNodeFaultDetails alloc] initWithParentNode:self]];
    }
    return _nodeFaultDetails;
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
            modelForNode = [self.nodeFaultDetails startingNode:aNode previousNode:modelForNode];
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
            modelForNode = [self.nodeFaultDetails endingNode:aNode previousNode:aPreviousNode];
        }
    }
    
    return modelForNode;
}


@end
