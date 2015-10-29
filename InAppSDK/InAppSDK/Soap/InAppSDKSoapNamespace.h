//
//  InAppSDKSoapNamespace.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

//! CyberSource SOAP XML construction namespace definitions and names
/*!
 */

@interface InAppSDKSoapNamespace : NSObject

//! Namespace for the request message XML part in the transaction APIs
+ (NSString *) transactionNamespace;

//! Namespace definition URL for the request message XML part in the transaction APIs
+ (NSString *) transactionNamespaceDefinition;

//! Namespace definition URL for the NVP request message XML part in the transaction APIs
+ (NSString *) nvpTransactionNamespaceDefinition;

//! Namespace for the envelope XML part
+ (NSString *) envelopeNamespace;

//! Namespace definition URL for the envelope XML part
+ (NSString *) envelopeNamespaceDefinition;

//! Namespace for the security XML part
+ (NSString *) securityNamespace;

//! Namespace definition URL for the security XML part
+ (NSString *) securityNamespaceDefinition;

//! Namespace for the general XML part
+ (NSString *) xmlnsNamespace;

//! Namespace for URN
+ (NSString *) urnNamespace;

//! Namespace for XSD
+ (NSString *) xsdNamespace;

//! Namespace definition URL for the envelope XML part
+ (NSString *) envelopeW3Definition;

//! Namespace for XSI
+ (NSString *) xsiNamespace;

//! Namespace definition URL for the envelope XML part
+ (NSString *) envelopeW3InstanceDefinition;

//! Namespace for WSU
+ (NSString *) wsuNamespace;

//! Namespace definition URL for the UserName XML part
+ (NSString *) userNameDefinition;
@end
