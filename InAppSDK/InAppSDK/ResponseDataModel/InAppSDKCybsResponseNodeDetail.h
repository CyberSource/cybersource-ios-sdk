//
//  InAppSDKCybsResponseNodeDetail.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNode.h"
#import "InAppSDKCybsResponseNodeFaultDetails.h"

@interface InAppSDKCybsResponseNodeDetail : InAppSDKCybsResponseNode

// Indirect nodes - its names must be different to CyberSource nodes' names

//! Represents the object for the \c faultDetails node
@property (nonatomic, strong) InAppSDKCybsResponseNodeFaultDetails * nodeFaultDetails;

@end
