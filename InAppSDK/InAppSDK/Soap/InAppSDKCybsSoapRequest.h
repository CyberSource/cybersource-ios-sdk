//
//  InAppSDKCybsSoapRequest.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

@class InAppSDKSoapStructure;

//! InAppSDKCybsSoapRequest is a subclass of @see NSMutableURLRequest
/*! Enables the creation of a CyberSource specific request.
 */
@interface InAppSDKCybsSoapRequest : NSMutableURLRequest

//! Creates CyberSource specific request
/*! This method composes a SOAP request that inclues \c aRequestMessage in the body.
 \param aRequestMessage A request message that is included in the request body.
 \return The \c InAppSDKCybsSoapRequest object
 */
+ (InAppSDKCybsSoapRequest *) createCardRequestWithSoapMessage:(InAppSDKSoapStructure *)aRequestMessage;

//! Creates CyberSource specific request
/*! This method composes a SOAP request that inclues \c aRequestMessage in the body.
 \param aRequestMessage A request message that is included in the request body.
 \return The \c InAppSDKCybsSoapRequest object
 */
+ (InAppSDKCybsSoapRequest *) createApplePayRequestWithSoapMessage:(InAppSDKSoapStructure *)aRequestMessage;


@end
