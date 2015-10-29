//
//  InAppSDKCybsResponseNodeFault.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNode.h"
#import "InAppSDKCybsResponseNodeDetail.h"

//! CyberSource parser of XML node
/*! Specific class for the Fault node.
 */

@interface InAppSDKCybsResponseNodeFault : InAppSDKCybsResponseNode

// Direct nodes - must have names exactly the same as nodes returned from CyberSource server

//! fault code node
@property (nonatomic, strong) NSString * faultcode;
//! fault string node
@property (nonatomic, strong) NSString * faultstring;

// Indirect nodes - its names must be different to CyberSource nodes' names

//! Represents the object for the \c detail node
@property (nonatomic, strong) InAppSDKCybsResponseNodeDetail * nodeDetail;

@end
