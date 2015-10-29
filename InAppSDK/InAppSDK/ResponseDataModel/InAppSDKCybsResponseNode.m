//
//  InAppSDKCybsResponseNode.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsResponseNode.h"
#import <objc/runtime.h>

@implementation InAppSDKCybsResponseNode

static NSString * const kAcceptedDebugObjectType = @"NSString";

- (id) initWithParentNode:(InAppSDKCybsResponseNode *)aParentNode
{
    self = [self init]; // Important to call init on self since it is used in inheritor class
    if (self)
    {
        self.parentNode = aParentNode;
    }
    return self;
}

- (void) updateWithValue:(NSString *)aValue
{
    if (self.currentNodeName)
    {
        NSString *nodeName = self.currentNodeName;
        if ([nodeName isEqualToString:@"description"])
        {
            nodeName = [NSString stringWithFormat:@"theDescription"];
        }
        if ([self respondsToSelector:NSSelectorFromString(nodeName)])
        {
            [self setValue:aValue forKey:nodeName];
        }
        else
        {
            // Not expected node
        }
    }
    
}

- (InAppSDKCybsResponseNode *) startingNode:(NSString *)aNode previousNode:(InAppSDKCybsResponseNode *)aPreviousNode
{
    
    self.currentNodeName = aNode;
    InAppSDKCybsResponseNode * modelForNode = aPreviousNode;
    
    if ([aNode isEqualToString:self.startingNodeName] ||
        [aPreviousNode isEqual:self])
    {
        modelForNode = self;
    }
    
    return modelForNode;
}

- (InAppSDKCybsResponseNode *) endingNode:(NSString *)aNode previousNode:(InAppSDKCybsResponseNode *)aPreviousNode
{
    
    self.currentNodeName = nil;
    InAppSDKCybsResponseNode * modelForNode = aPreviousNode;
    
    if ([aPreviousNode isEqual:self])
    {
        if ([aNode isEqualToString:self.startingNodeName])
        {
            modelForNode = self.parentNode;
        }
    }
    
    return modelForNode;
}

#pragma mark - Debug method -

/*! method returns string with all values returned from server
 */
- (NSString *) allFieldsDescription
{
    
    NSString * allFieldsDescription = [NSString string];
    
    unsigned int varCount;
    Ivar *vars = class_copyIvarList([self class], &varCount);
    
    for (int i = 0; i < varCount; i++)
    {
        Ivar var = vars[i];
        const char* name = ivar_getName(var);
        const char* typeEncoding = ivar_getTypeEncoding(var);
        NSString * fieldType = [NSString stringWithCString:typeEncoding encoding:NSASCIIStringEncoding];
        NSString * fieldName = [NSString stringWithCString:name encoding:NSASCIIStringEncoding];
        fieldName = [fieldName stringByReplacingOccurrencesOfString:@"_" withString:[NSString string]];
        
        if ([fieldType rangeOfString:kAcceptedDebugObjectType].location != NSNotFound)
        {
            if ([self respondsToSelector:NSSelectorFromString(fieldName)])
            {
                if ([self valueForKey:fieldName])
                {
                    allFieldsDescription = [allFieldsDescription stringByAppendingFormat:@"%@.%@ %@\n",
                                            self.startingNodeName,
                                            fieldName,
                                            [self valueForKey:fieldName]];
                }
            }
        }
        else
        {
            SEL fieldNameSelector = NSSelectorFromString(fieldName);
            id (*func)(id, SEL) = (void*)[self methodForSelector:fieldNameSelector];
            if (func)
            {
                id obj = func(self, fieldNameSelector);
                if ([obj respondsToSelector:@selector(allFieldsDescription)])
                {
                    allFieldsDescription = [allFieldsDescription stringByAppendingString:[obj allFieldsDescription]];
                }
            }
        }
        
    }
    free(vars);
    
    return allFieldsDescription;
}



@end
