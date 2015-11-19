//
//  InAppSDKSoapNode.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKSoapNode.h"
#import "InAppSDKSoapStructure.h"
#import "InAppSDKSoapNode.h"
#import "InAppSDKSoapNamespace.h"
#import "InAppSDKCardData.h"
#import "InAppSDKInternal.h"
#import "InAppSDKMerchant.h"
#import "InAppSDKAddress.h"

@implementation InAppSDKSoapNode

+ (InAppSDKSoapStructure *) createEnvelope
{
    
    InAppSDKSoapStructure * envelope = [InAppSDKSoapStructure createElementWithName:@"Envelope"
                                                                withNamespace:[InAppSDKSoapNamespace envelopeNamespace]];
    
    [envelope addParameter:[InAppSDKSoapStructure createElementWithName:[InAppSDKSoapNamespace envelopeNamespace]
                                                           withValue:[InAppSDKSoapNamespace envelopeNamespaceDefinition]
                                                       withNamespace:[InAppSDKSoapNamespace xmlnsNamespace]]];
    
    [envelope addParameter:[InAppSDKSoapStructure createElementWithName:[InAppSDKSoapNamespace xsdNamespace]
                                                              withValue:[InAppSDKSoapNamespace envelopeW3Definition]
                                                          withNamespace:[InAppSDKSoapNamespace xmlnsNamespace]]];
    
    [envelope addParameter:[InAppSDKSoapStructure createElementWithName:[InAppSDKSoapNamespace xsiNamespace]
                                                              withValue:[InAppSDKSoapNamespace envelopeW3InstanceDefinition]
                                                          withNamespace:[InAppSDKSoapNamespace xmlnsNamespace]]];
    
    [envelope addChild:[InAppSDKSoapNode createHeader]];
    
    return envelope;
}

+ (InAppSDKSoapStructure *) createHeader
{
    
    InAppSDKSoapStructure * header = [InAppSDKSoapStructure createElementWithName:@"Header"
                                                              withNamespace:[InAppSDKSoapNamespace envelopeNamespace]];
    
    [header addChild:[InAppSDKSoapNode createSecurity]];
    
    return header;
}

+ (InAppSDKSoapStructure *) createBodyWithRequestMessage:(InAppSDKSoapStructure *)aRequestMessage
{
    
    InAppSDKSoapStructure * body = [InAppSDKSoapStructure createElementWithName:@"Body"
                                                            withNamespace:[InAppSDKSoapNamespace envelopeNamespace]];
    // If aRequestMessage is NULL body node will be empty
    [body addChild:aRequestMessage];
    return body;
}

#pragma mark - CyberSource Security nodes -

+ (InAppSDKSoapStructure *) createSecurity
{
    
    InAppSDKSoapStructure * security = [InAppSDKSoapStructure createElementWithName:@"Security"
                                                                withNamespace:[InAppSDKSoapNamespace securityNamespace]];
    
    
    [security addParameter:[InAppSDKSoapStructure createElementWithName:[InAppSDKSoapNamespace securityNamespace]
                                                              withValue:[InAppSDKSoapNamespace securityNamespaceDefinition]
                                                          withNamespace:[InAppSDKSoapNamespace xmlnsNamespace]]];
    
    [security addParameter:[InAppSDKSoapStructure createElementWithName:@"mustUnderstand"
                                                           withValue:@"1"
                                                       withNamespace:[InAppSDKSoapNamespace envelopeNamespace]]];
    
    [security addChild:[InAppSDKSoapNode createUsernameToken]];
    
    return security;
}


+ (InAppSDKSoapStructure *) createUsernameToken
{
    
    InAppSDKSoapStructure * usernameToken = [InAppSDKSoapStructure createElementWithName:@"UsernameToken"
                                                                     withNamespace:[InAppSDKSoapNamespace securityNamespace]];
    

    [usernameToken addParameter:[InAppSDKSoapStructure createElementWithName:[InAppSDKSoapNamespace wsuNamespace]
                                                              withValue:[InAppSDKSoapNamespace userNameDefinition]
                                                          withNamespace:[InAppSDKSoapNamespace xmlnsNamespace]]];
    
    [usernameToken addParameter:[InAppSDKSoapStructure createElementWithName:@"Id"
                                                              withValue:@"UsernameToken-1"
                                                          withNamespace:[InAppSDKSoapNamespace wsuNamespace]]];
    
    
    [usernameToken addChild:[InAppSDKSoapStructure createElementWithName:@"Username"
                                                            withValue:[[InAppSDKInternal sharedInstance] merchantId]
                                                        withNamespace:[InAppSDKSoapNamespace securityNamespace]]];
    
   
    [usernameToken addChild:[InAppSDKSoapNode createPasswordWithPasswordType:@"PasswordDigest" withPassword:[InAppSDKInternal sharedInstance].password]];
    
    return usernameToken;
}


+ (InAppSDKSoapStructure *) createPasswordWithPasswordType: (NSString*)passwordType withPassword:(NSString *) paramPassword
{
    
    
    InAppSDKSoapStructure * password = [InAppSDKSoapStructure createElementWithName:@"Password"
                                                                    withValue:paramPassword
                                                                withNamespace:[InAppSDKSoapNamespace securityNamespace]];
    
    [password addParameter:[InAppSDKSoapStructure createElementWithName:@"Type"
                                                           withValue:passwordType]];
    
    return password;
}

#pragma mark - CyberSource common node

+ (InAppSDKSoapStructure *) createBillToWithAddress:(InAppSDKAddress *)anAddress
{
    
    if (!anAddress)
    {
        return nil;
    }
    
    InAppSDKSoapStructure * billTo = [InAppSDKSoapStructure createElementWithName:@"billTo"
                                                              withNamespace:[InAppSDKSoapNamespace transactionNamespace]];
    
    if ([anAddress.firstName length])
    {
        [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"firstName"
                                                         withValue:anAddress.firstName
                                                     withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    
    if ([anAddress.lastName length])
    {
        [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"lastName"
                                                         withValue:anAddress.lastName
                                                     withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    
    
    if ([anAddress.postalCode length])
    {
        [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"postalCode"
                                                         withValue:anAddress.postalCode
                                                     withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    
    
    return billTo;
    
}

+ (InAppSDKSoapStructure *) createCardWithCard:(InAppSDKCardData*)paramCard
{
    
    if (paramCard == nil)
    {
        // aCard must not be nil
        return nil;
    }
    
    InAppSDKSoapStructure *card = [InAppSDKSoapStructure createElementWithName:@"card"
                                                           withNamespace:[InAppSDKSoapNamespace transactionNamespace]];

    InAppSDKCardData *keyedInCardData = (InAppSDKCardData *)paramCard;
    
    if ([keyedInCardData.accountNumber length])
    {
        [card addChild:[InAppSDKSoapStructure createElementWithName:@"accountNumber"
                                                       withValue:keyedInCardData.accountNumber
                                                   withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    
    if ([keyedInCardData.expirationMonth length])
    {
        [card addChild:[InAppSDKSoapStructure createElementWithName:@"expirationMonth"
                                                       withValue:keyedInCardData.expirationMonth
                                                   withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    
    if ([keyedInCardData.expirationYear length])
    {
        [card addChild:[InAppSDKSoapStructure createElementWithName:@"expirationYear"
                                                       withValue:keyedInCardData.expirationYear
                                                   withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    
    if ([keyedInCardData.cvNumber length])
    {
        [card addChild:[InAppSDKSoapStructure createElementWithName:@"cvNumber"
                                                       withValue:keyedInCardData.cvNumber
                                                   withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }

    
    
    return card;
}


+ (InAppSDKSoapStructure *) createRequestMessageWithTransaction:(InAppSDKTransactionObject *)aTransaction
{
    
    InAppSDKSoapStructure * requestMessage = [InAppSDKSoapStructure createElementWithName:@"requestMessage"
                                                                      withNamespace:[InAppSDKSoapNamespace transactionNamespace]];
    
    [requestMessage addParameter:[InAppSDKSoapStructure createElementWithName:[InAppSDKSoapNamespace transactionNamespace]
                                                              withValue:[InAppSDKSoapNamespace transactionNamespaceDefinition]
                                                          withNamespace:[InAppSDKSoapNamespace xmlnsNamespace]]];
    

    [requestMessage addChild:[InAppSDKSoapStructure createElementWithName:@"merchantID"
                                                                 withValue:[InAppSDKInternal sharedInstance].merchantId
                                                             withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    
    if ([aTransaction.merchant.merchantReferenceCode length])
    {
        [requestMessage addChild:[InAppSDKSoapStructure createElementWithName:@"merchantReferenceCode"
                                                                 withValue:aTransaction.merchant.merchantReferenceCode
                                                             withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    
    [requestMessage addChild:[InAppSDKSoapStructure createElementWithName:@"clientLibrary"
                                                                                     withValue:@"InAppSDK iOS v1.0.0"
                                                         withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    return requestMessage;
}

+ (InAppSDKSoapStructure *) createEncryptPaymentDataServiceRequestMessageWithTransaction:(InAppSDKTransactionObject *)aTransaction
{
    
    InAppSDKSoapStructure * requestMessage = [InAppSDKSoapNode createRequestMessageWithTransaction:aTransaction];
    
    if (requestMessage == nil)
    {
        return nil;
    }
    // Add billTo if available.
    if (aTransaction.billTo)
        [requestMessage addChild:[InAppSDKSoapNode createBillToWithAddress:aTransaction.billTo]];
    
    // add card data
    [requestMessage addChild:[InAppSDKSoapNode createCardWithCard:aTransaction.cardData]];
    
    [requestMessage addChild:[InAppSDKSoapNode createEncryptPaymentDataService]];
  
    return requestMessage;
}

+ (InAppSDKSoapStructure *) createEncryptPaymentDataService
{
    
    InAppSDKSoapStructure * authorizationService = [InAppSDKSoapStructure createElementWithName:@"encryptPaymentDataService"
                                                                            withNamespace:[InAppSDKSoapNamespace transactionNamespace]];
    
    [authorizationService addParameter:[InAppSDKSoapNode createRunTrueParameter]];
    
    
    return authorizationService;
    
}

+ (InAppSDKSoapStructure *) createRunTrueParameter
{
    return [InAppSDKSoapStructure createElementWithName:@"run" withValue:@"true"];
}


@end
