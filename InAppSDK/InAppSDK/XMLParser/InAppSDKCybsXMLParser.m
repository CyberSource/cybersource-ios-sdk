//
//  InAppSDKCybsXMLParser.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsXMLParser.h"
#import "InAppSDKCybsResponseNodeReplyMessage.h"
#import "InAppSDKCybsResponseNodeBody.h"

@interface InAppSDKCybsXMLParser()

@property (nonatomic, strong) InAppSDKCybsResponseNodeReplyMessage * cybsReplyMessage;
@property (nonatomic, strong) InAppSDKCybsResponseNodeBody * cybsBody;
@property (nonatomic, strong) InAppSDKCybsResponseNode * cybsNode;
@property (nonatomic, weak) NSError * parsingError;

@end

@implementation InAppSDKCybsXMLParser

- (id) initParserWithCybsBody:(InAppSDKCybsResponseNodeBody *)aBody error:(NSError **)anError
{
    
    self = [super init];
    if (self) {
        if (aBody == nil)
        {
            return nil;
        }
        self.cybsBody = aBody;
        _parsingError = *anError;

    }
    return self;
    
}

- (NSString *) skipNamespace:(NSString *)elementName
{
    
    NSString * nodeName = nil;
    NSRange rangeOfColon = [elementName rangeOfString:@":"];
    
    if (rangeOfColon.location != NSNotFound)
    {
        if ([elementName length] > rangeOfColon.location)
        {
            nodeName = [elementName substringFromIndex:(rangeOfColon.location + 1)];
        }
    }
    else
    {
        nodeName = elementName;
    }
    return nodeName;
}

#pragma mark - NSXMLParserDelegate -

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.cybsNode = nil;
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.cybsNode = nil;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    NSString * nodeName = [self skipNamespace:elementName];
    
    if ([nodeName isEqualToString:self.cybsBody.startingNodeName])
    {
        // parse starting point is defined by ReplayMessage node
        self.cybsNode = self.cybsBody;
    }
    
    if (self.cybsNode)
    {
        self.cybsNode = [self.cybsNode startingNode:nodeName previousNode:self.cybsNode];
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    NSString * nodeName = [self skipNamespace:elementName];
    self.cybsNode = [self.cybsNode endingNode:nodeName previousNode:self.cybsNode];
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if (self.cybsNode)
    {
        [self.cybsNode updateWithValue:string];
    }
   
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    self.parsingError = parseError;
}

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError
{
    self.parsingError = validationError;
}

@end
