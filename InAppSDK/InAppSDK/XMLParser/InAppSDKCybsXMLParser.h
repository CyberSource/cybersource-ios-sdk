//
//  InAppSDKCybsXMLParser.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

@class InAppSDKCybsResponseNodeBody;

//! The CyberSource XML Parser.
/*! It provides the ability to parse responses that are received from the server.
 */

@interface InAppSDKCybsXMLParser : NSObject <NSXMLParserDelegate>

//! Parser initialization method
/*!
 \param aBody An empty @see InAppSDKCybsResponseNodeBody object that is filled with parsed data.
 \param anError Reference to an error object
 \return Object of @see InAppSDKCybsXMLParser class
 */
- (id) initParserWithCybsBody:(InAppSDKCybsResponseNodeBody *)aBody error:(NSError **)anError;

@end
