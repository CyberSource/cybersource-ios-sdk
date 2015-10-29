//
//  InAppSDKCybsResponseNodeBody.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNode.h"
#import "InAppSDKCybsResponseNodeReplyMessage.h"
#import "InAppSDKCybsResponseNodeFault.h"


@interface InAppSDKCybsResponseNodeBody : InAppSDKCybsResponseNode

// Indirect nodes - its names must be different to CyberSource nodes' names

//! Represents the object for the \c ReplayMessage node
@property (nonatomic, strong) InAppSDKCybsResponseNodeReplyMessage * nodeReplayMessage;

//! Represents the object for the \c Fault node
@property (nonatomic, strong) InAppSDKCybsResponseNodeFault * nodeFault;

@end
