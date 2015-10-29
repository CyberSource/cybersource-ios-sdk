//
//  InAppSDKSoapNamespace.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKSoapNamespace.h"

@implementation InAppSDKSoapNamespace



+ (NSString *) transactionNamespace
{
    static NSString * transactionNsp = @"ns3";
    return transactionNsp;
}

+ (NSString *) transactionNamespaceDefinition
{
    static NSString * transactionDef = @"urn:schemas-cybersource-com:transaction-data-1.120";
    return transactionDef;
}

+ (NSString *) nvpTransactionNamespaceDefinition
{
    static NSString * transactionDef = @"urn:schemas-cybersource-com:transaction-data-1.106";
    return transactionDef;
}

+ (NSString *) envelopeNamespace
{
    static NSString * envelopNsp = @"soapenv";
    return envelopNsp;
}

+ (NSString *) envelopeNamespaceDefinition
{
    static NSString * envelopDef = @"http://schemas.xmlsoap.org/soap/envelope/";
    return envelopDef;
}

+ (NSString *) securityNamespace
{
    static NSString * securityNsp = @"wsse";
    return securityNsp;
}

+ (NSString *) securityNamespaceDefinition
{
    static NSString * securityDef = @"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
    return securityDef;
}

+ (NSString *) xmlnsNamespace
{
    static NSString * xmlnsNsp = @"xmlns";
    return xmlnsNsp;
}

+ (NSString *) urnNamespace {
    static NSString * urnNsp = @"urn";
    return urnNsp;
}

+ (NSString *) xsdNamespace
{
    static NSString * envelopNsp = @"xsd";
    return envelopNsp;
}

+ (NSString *) envelopeW3Definition
{
    static NSString * envelopDef = @"http://wwww.w3.org/2001/XMLSchema";
    return envelopDef;
}

+ (NSString *) xsiNamespace
{
    static NSString * envelopNsp = @"xsi";
    return envelopNsp;
}


+ (NSString *) envelopeW3InstanceDefinition
{
    static NSString * envelopDef = @"http://wwww.w3.org/2001/XMLSchema-instance";
    return envelopDef;
}


+ (NSString *) wsuNamespace
{
    static NSString * envelopNsp = @"xsi";
    return envelopNsp;
}


+ (NSString *) userNameDefinition
{
    static NSString * userNameDef = @"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
    return userNameDef;
}


@end
