//
//  InAppSDKCybsResponseNodeFaultDetails.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNode.h"

@interface InAppSDKCybsResponseNodeFaultDetails : InAppSDKCybsResponseNode

// Direct nodes - must have names exactly the same as nodes returned from CyberSource server

//! request id node
@property (nonatomic, strong) NSString * requestID;

@end
