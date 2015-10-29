//
//  InAppSDKCybsSoapRequest.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsSoapRequest.h"
#import "InAppSDKSoapStructure.h"
#import "InAppSDKSoapNode.h"
#import "InAppSDKSettingsPrivate.h"


const static float kInAppSDKCybsApiSoapTimeoutInterval = 30.0;

@implementation InAppSDKCybsSoapRequest

+ (InAppSDKCybsSoapRequest *) createRequestWithSoapMessage:(InAppSDKSoapStructure *)aRequestMessage
{

    NSString* requestURLString = [[InAppSDKSettings sharedInstance] getURLfor:CYBS_REQUEST_API_EP];
    
    InAppSDKCybsSoapRequest * newRequest = [InAppSDKCybsSoapRequest requestWithURL:[NSURL URLWithString:requestURLString]];
    [newRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [newRequest setTimeoutInterval:kInAppSDKCybsApiSoapTimeoutInterval];
    
    // prepare message
    NSString * soapXMLMessage = [InAppSDKCybsSoapRequest createSoapXmlMessageWithRequestMessage:aRequestMessage];
    
    // prepare request
    NSString *msgLength = [NSString stringWithFormat:@"%lud", (unsigned long)[soapXMLMessage length]];
    NSString *hostPort = [NSString stringWithFormat:@"%@:%d", [[newRequest URL] host], 443];
    [newRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [newRequest addValue:msgLength forHTTPHeaderField:@"Content-Lenght"];
    [newRequest addValue:hostPort forHTTPHeaderField:@"Host"];
    //[newRequest addValue:@"runTransaction" forHTTPHeaderField:@"SOAPAction"];
    [newRequest addValue:@"no-cache, no-store" forHTTPHeaderField:@"Cache-Control"];
    [newRequest setHTTPMethod:@"POST"];
    [newRequest setHTTPBody:[soapXMLMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSLog(@"...createRequestWithSoapMessage....newRequest %@", newRequest);
//    NSLog(@"...createRequestWithSoapMessage....allHTTPHeaderFields %@", newRequest.allHTTPHeaderFields);
    return newRequest;
}

+ (NSString *) createSoapXmlMessageWithRequestMessage:(InAppSDKSoapStructure *)aRequestMessage
{
    
    // start with xml version and encoding information
    NSString * soapXMLMessage = [InAppSDKCybsSoapRequest createSoapXmlStartPoint];
    
    // create envelope
    InAppSDKSoapStructure * messageEnvelop = [InAppSDKSoapNode createEnvelope];
    
    // add request message
    [messageEnvelop addChild:[InAppSDKSoapNode createBodyWithRequestMessage:aRequestMessage]];
    
    // add envelop to message
    soapXMLMessage = [soapXMLMessage stringByAppendingString:[messageEnvelop generateSoapXmlStructure]];
    
    NSLog(@"REQUEST XML: %@", soapXMLMessage);
    
    return soapXMLMessage;
}


+ (NSString *) createSoapXmlStartPoint
{
    return @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
}

@end
