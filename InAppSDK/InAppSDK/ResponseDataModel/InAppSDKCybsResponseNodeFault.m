//
//  InAppSDKCybsResponseNodeFault.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNodeFault.h"

@implementation InAppSDKCybsResponseNodeFault


static NSString * const kCybsNodeFault = @"Fault";

- (id) init {
    self = [super init];
    if (self) {
        self.startingNodeName = kCybsNodeFault;
    }
    return self;
}

#pragma mark - Indirect children -

- (InAppSDKCybsResponseNodeDetail *)nodeDetail
{
    if (_nodeDetail == nil)
    {
        [self setNodeDetail:[[InAppSDKCybsResponseNodeDetail alloc] initWithParentNode:self]];
    }
    return _nodeDetail;
}

- (void) setFaultcode:(NSString *)faultcode
{
    faultcode = [faultcode stringByReplacingOccurrencesOfString:@"wsse:" withString:[NSString string]];
    _faultcode = faultcode;
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
            modelForNode = [self.nodeDetail startingNode:aNode previousNode:modelForNode];
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
            modelForNode = [self.nodeDetail endingNode:aNode previousNode:aPreviousNode];
        }
    }
    
    return modelForNode;
}



@end
