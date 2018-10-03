//
//  InAppSDKCybsResponseNodeReplyMessage.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNode.h"

@interface InAppSDKCybsResponseNodeReplyMessage : InAppSDKCybsResponseNode

// Direct nodes - must have names exactly the same as nodes returned from CyberSource server

//! decision node
@property (nonatomic, strong) NSString * decision;
//! merchantReferenceCode node
@property (nonatomic, strong) NSString * merchantReferenceCode;
//! reasonCode node
@property (nonatomic, strong) NSString * reasonCode;
//! requestID node
@property (nonatomic, strong) NSString * requestID;
//! requestToken node
@property (nonatomic, strong) NSString * requestToken;
//! reconciliationID node
@property (nonatomic, strong) NSString * reconciliationID;
//! missingField node
@property (nonatomic, strong) NSString * missingField;
//! invalidField node
@property (nonatomic, strong) NSString * invalidField;
//! data node
@property (nonatomic, strong) NSString * data;
//! requestDateTime node
@property (nonatomic, strong) NSString * requestDateTime;

@end
