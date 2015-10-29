//
//  InAppSDKSoapStructure.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKSoapStructure.h"

@interface InAppSDKSoapStructure()

@property (nonatomic, strong) NSString *nodeNamespace;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, strong) NSMutableArray *parameters;

@end

@implementation InAppSDKSoapStructure


- (id) init
{
    self = [super init];
    if (self) {
        _nodeNamespace = nil;
        _value = nil;
        _name = nil;
        _children = nil;
        _parameters = nil;
    }
    return self;
}

#pragma mark - Creating Nodes -

+ (InAppSDKSoapStructure *) createElementWithName:(NSString *)paramName
                                     withValue:(NSString *)paramValue
{
    InAppSDKSoapStructure *newItem = [InAppSDKSoapStructure createElementWithName:paramName];
    if ((newItem != nil) &&
        ([paramValue length] != 0))
    {
        newItem.value = paramValue;
    }
    return newItem;
}

+ (InAppSDKSoapStructure *) createElementWithName:(NSString *)paramName
                                     withValue:(NSString *)paramValue
                                 withNamespace:(NSString *)paramNamespace
{
    InAppSDKSoapStructure *newItem = [InAppSDKSoapStructure createElementWithName:paramName withValue:paramValue];
    if ((newItem != nil) &&
        ([paramNamespace length] != 0))
    {
        newItem.nodeNamespace = paramNamespace;
    }
    return newItem;
}

+ (InAppSDKSoapStructure *) createElementWithName:(NSString *)paramName
{
    if ([paramName length] == 0)
    {
        return nil;
    }
    InAppSDKSoapStructure *newItem = [[InAppSDKSoapStructure alloc] init];
    if (newItem != nil)
    {
        newItem.name = paramName;
    }
    return newItem;
}

+ (InAppSDKSoapStructure *) createElementWithName:(NSString *)paramName
                                 withNamespace:(NSString *)paramNamespace
{
    InAppSDKSoapStructure *newItem = [InAppSDKSoapStructure createElementWithName:paramName];
    if ((newItem != nil) &&
        ([paramNamespace length] != 0))
    {
        newItem.nodeNamespace = paramNamespace;
    }
    return newItem;
}

#pragma mark - Supplementing Nodes -

- (void) addParameter:(InAppSDKSoapStructure *)paramValue
{
    if (paramValue != nil)
    {
        if (self.parameters == nil)
        {
            self.parameters = [NSMutableArray array];
        }
        [self.parameters addObject:paramValue];
    }
}

- (void) addChild:(InAppSDKSoapStructure *)paramChild
{
    if (paramChild != nil)
    {
        if (self.children == nil)
        {
            self.children = [NSMutableArray array];
        }
        [self.children addObject:paramChild];
    }
}

#pragma mark - Creating XML structure -

- (NSString *) generateSoapXmlStructure
{
    
    // </>
    NSString *newXML = @"<";
    if (self.nodeNamespace)
    {
        newXML = [newXML stringByAppendingFormat:@"%@:", self.nodeNamespace];
    }
    newXML = [newXML stringByAppendingFormat:@"%@", self.name];
    
    // parameters
    if (self.parameters)
    {
        for (InAppSDKSoapStructure *parameter in self.parameters)
        {
            newXML = [newXML stringByAppendingFormat:@" %@", [parameter generateSoapXmlParameter]];
        }
    }
    newXML = [newXML stringByAppendingString:@">"];
    
    // values
    if (self.value)
    {
        newXML = [newXML stringByAppendingFormat:@"%@", self.value];
    }
    
    // children
    if (self.children)
    {
        newXML = [newXML stringByAppendingString:@"\n"];
        
        if ([self.name isEqualToString:@"nvpRequest"])
        {
            for (InAppSDKSoapStructure *child in self.children)
            {
                newXML = [newXML stringByAppendingFormat:@"%@\n", [child generateNVPRequestSoapValuePairs]];
            }
        }
        else
        {
            for (InAppSDKSoapStructure *child in self.children)
            {
                newXML = [newXML stringByAppendingFormat:@"%@\n", [child generateSoapXmlStructure]];
            }
        }
    }
    
    // </>
    newXML = [newXML stringByAppendingString:@"</"];
    if (self.nodeNamespace)
    {
        newXML = [newXML stringByAppendingFormat:@"%@:", self.nodeNamespace];
    }
    newXML = [newXML stringByAppendingFormat:@"%@>", self.name];
    
    return newXML;
}

- (NSString *) generateNVPSoapXmlStructure
{
    
    // </>
    NSString *newXML = @"<";
    if (self.nodeNamespace)
    {
        newXML = [newXML stringByAppendingFormat:@"%@:", self.nodeNamespace];
    }
    newXML = [newXML stringByAppendingFormat:@"%@", self.name];
    
    // parameters
    if (self.parameters)
    {
        for (InAppSDKSoapStructure *parameter in self.parameters)
        {
            newXML = [newXML stringByAppendingFormat:@" %@", [parameter generateSoapXmlParameter]];
        }
    }
    newXML = [newXML stringByAppendingString:@">"];
    
    // values
    if (self.value)
    {
        newXML = [newXML stringByAppendingFormat:@"%@", self.value];
    }
    
    // children
    if (self.children)
    {
        newXML = [newXML stringByAppendingString:@"\n"];
        for (InAppSDKSoapStructure *child in self.children) {
            newXML = [newXML stringByAppendingFormat:@"%@\n", [child generateSoapXmlStructure]];
        }
    }
    
    // </>
    newXML = [newXML stringByAppendingString:@"</"];
    if (self.nodeNamespace)
    {
        newXML = [newXML stringByAppendingFormat:@"%@:", self.nodeNamespace];
    }
    newXML = [newXML stringByAppendingFormat:@"%@>", self.name];
    
    return newXML;
}

- (NSString *) generateNVPRequestSoapValuePairs
{
    
    NSString *newXML = @"";
    newXML = [newXML stringByAppendingFormat:@"%@", self.name];
    newXML = [newXML stringByAppendingString:@"="];
    
    // values
    if (self.value)
    {
        newXML = [newXML stringByAppendingFormat:@"%@", self.value];
    }
    
    return newXML;
}


- (NSString *) generateSoapXmlParameter
{
    NSString *parameter = [NSString string];
    if (self.nodeNamespace)
    {
        parameter = [parameter stringByAppendingFormat:@"%@:", self.nodeNamespace];
    }
    return [parameter stringByAppendingFormat:@"%@=\"%@\"", self.name, self.value];
}

#pragma mark - Setters validation -

- (void) setName:(NSString *)paramName
{
    _name = [self validateParam:paramName];
}

- (void) setNodeNamespace:(NSString *)paramNamespace
{
    _nodeNamespace = [self validateParam:paramNamespace];
}

- (void) setValue:(NSString *)paramValue
{
    _value = [self validateParam:paramValue];
}

#pragma mark - Helper methods -

- (NSString *) validateParam:(NSString *)paramValue
{
    if (([paramValue isKindOfClass:[NSString class]] == NO) ||
        ([paramValue length] == 0))
    {
        return nil;
    }
    return [paramValue copy];
}


@end
