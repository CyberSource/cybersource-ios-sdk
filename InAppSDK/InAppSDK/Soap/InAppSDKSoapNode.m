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
#import "InAppSDKEncryptedPaymentData.h"

@implementation InAppSDKSoapNode

+ (InAppSDKSoapStructure *) createEnvelope
{
    return [self createEnvelopeUsePasswordDigest: NO];
}

+ (InAppSDKSoapStructure *) createEnvelopeUsePasswordDigest: (BOOL) shouldUsePasswordDigest
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
  
  [envelope addChild:[InAppSDKSoapNode createHeaderUsePasswordDigest: shouldUsePasswordDigest]];
  
  return envelope;
}

+ (InAppSDKSoapStructure *) createHeader
{
    
    return [self createHeaderUsePasswordDigest: NO];
}

+ (InAppSDKSoapStructure *) createHeaderUsePasswordDigest: (BOOL) shouldUsePasswordDigest
{
  
  InAppSDKSoapStructure * header = [InAppSDKSoapStructure createElementWithName:@"Header"
                                                                  withNamespace:[InAppSDKSoapNamespace envelopeNamespace]];
  
  [header addChild:[InAppSDKSoapNode createSecurityUsePasswordDigest: shouldUsePasswordDigest]];
  
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

+ (InAppSDKSoapStructure *) createSecurity {
  return [self createSecurityUsePasswordDigest: NO];
}

+ (InAppSDKSoapStructure *) createSecurityUsePasswordDigest: (BOOL) shouldUsePasswordDigest
{
    
    InAppSDKSoapStructure * security = [InAppSDKSoapStructure createElementWithName:@"Security"
                                                                withNamespace:[InAppSDKSoapNamespace securityNamespace]];
    
    
    [security addParameter:[InAppSDKSoapStructure createElementWithName:[InAppSDKSoapNamespace securityNamespace]
                                                              withValue:[InAppSDKSoapNamespace securityNamespaceDefinition]
                                                          withNamespace:[InAppSDKSoapNamespace xmlnsNamespace]]];
    
    [security addParameter:[InAppSDKSoapStructure createElementWithName:@"mustUnderstand"
                                                           withValue:@"1"
                                                       withNamespace:[InAppSDKSoapNamespace envelopeNamespace]]];
    
  [security addChild:[InAppSDKSoapNode createUsernameTokenUsePasswordDigest: shouldUsePasswordDigest]];
    
    return security;
}

+ (InAppSDKSoapStructure *) createUsernameToken {
  return [self createUsernameTokenUsePasswordDigest: NO];
}

+ (InAppSDKSoapStructure *) createUsernameTokenUsePasswordDigest: (BOOL) shouldUsePasswordDigest
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

  if (shouldUsePasswordDigest) {
      [usernameToken addChild:[InAppSDKSoapNode createPasswordWithPasswordType:@"PasswordDigest" withPassword:[InAppSDKInternal sharedInstance].password]];
  } else {
      [usernameToken addChild: [InAppSDKSoapStructure createElementWithName:@"Password"
                                                                withValue:[InAppSDKInternal sharedInstance].password
                                                            withNamespace:[InAppSDKSoapNamespace securityNamespace]]];
  }
  
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

+ (InAppSDKSoapStructure *) createApplePayPaymentSolution {
  InAppSDKSoapStructure * paymentSolution = [InAppSDKSoapStructure createElementWithName:@"paymentSolution"
                                                                               withValue:@"001" withNamespace:[InAppSDKSoapNamespace transactionNamespace]];
  return paymentSolution;
}

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

    if ([anAddress.street1 length])
    {
      [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"street1"
                                                          withValue:anAddress.street1
                                                      withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }

    if ([anAddress.city length])
    {
      [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"city"
                                                          withValue:anAddress.city
                                                      withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    if ([anAddress.state length])
    {
      [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"state"
                                                          withValue:anAddress.state
                                                      withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    if ([anAddress.postalCode length])
    {
      [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"postalCode"
                                                          withValue:anAddress.postalCode
                                                      withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    if ([anAddress.country length])
    {
      [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"country"
                                                          withValue:anAddress.country
                                                      withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }
    if ([anAddress.email length])
    {
      [billTo addChild:[InAppSDKSoapStructure createElementWithName:@"email"
                                                          withValue:anAddress.email
                                                      withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
    }

    return billTo;
    
}

+ (InAppSDKSoapStructure *) createEncryptedPaymentWithPayment:(InAppSDKEncryptedPaymentData*) payment
{

  if (payment == nil)
  {
    // payment must not be nil
    return nil;
  }

  InAppSDKSoapStructure *paymentElement = [InAppSDKSoapStructure createElementWithName:@"encryptedPayment"
                                                               withNamespace:[InAppSDKSoapNamespace transactionNamespace]];

  InAppSDKEncryptedPaymentData *keyedInPaymentData = (InAppSDKEncryptedPaymentData *)payment;


  if ([keyedInPaymentData.descriptor length])
  {
    [paymentElement addChild:[InAppSDKSoapStructure createElementWithName:@"descriptor"
                                                                withValue:keyedInPaymentData.descriptor
                                                            withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
  }

  if ([keyedInPaymentData.data length])
  {
    [paymentElement addChild:[InAppSDKSoapStructure createElementWithName:@"data"
                                                      withValue:keyedInPaymentData.data
                                                  withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
  }

  if ([keyedInPaymentData.encoding length])
  {
    [paymentElement addChild:[InAppSDKSoapStructure createElementWithName:@"encoding"
                                                      withValue:keyedInPaymentData.encoding
                                                  withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
  }

  return paymentElement;
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

+ (InAppSDKSoapStructure *) createPurchaseTotalsWithAmount: (NSDecimalNumber *) totalAmount
{
  if (totalAmount == nil) {
    return nil;
  }

  InAppSDKSoapStructure *purchaseTotals = [InAppSDKSoapStructure createElementWithName:@"purchaseTotals"
                                                                         withNamespace:[InAppSDKSoapNamespace transactionNamespace]];
  [purchaseTotals addChild:[InAppSDKSoapStructure createElementWithName:@"currency"
                                                              withValue:@"USD"
                                                          withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
  [purchaseTotals addChild:[InAppSDKSoapStructure createElementWithName:@"grandTotalAmount"
                                                              withValue:totalAmount.stringValue
                                                          withNamespace:[InAppSDKSoapNamespace transactionNamespace]]];
  return purchaseTotals;

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
    if (aTransaction.billTo) {
        [requestMessage addChild:[InAppSDKSoapNode createBillToWithAddress:aTransaction.billTo]];
    }

    [requestMessage addChild:[InAppSDKSoapNode createCardWithCard:aTransaction.cardData]];

    [requestMessage addChild:[InAppSDKSoapNode createEncryptPaymentDataService]];
  
    return requestMessage;
}

+ (InAppSDKSoapStructure *) createApplePayAuthorizationServiceRequestMessageWithTransaction:(InAppSDKTransactionObject *)aTransaction;
{

    InAppSDKSoapStructure * requestMessage = [InAppSDKSoapNode createRequestMessageWithTransaction:aTransaction];

    if (requestMessage == nil)
    {
        return nil;
    }
    // Add billTo if available.
    if (aTransaction.billTo) {
        [requestMessage addChild:[InAppSDKSoapNode createBillToWithAddress:aTransaction.billTo]];
    }

    [requestMessage addChild:[InAppSDKSoapNode createPurchaseTotalsWithAmount:aTransaction.totalAmount]];

    // add encrypted payment data
    [requestMessage addChild:[InAppSDKSoapNode createEncryptedPaymentWithPayment:aTransaction.encryptedPaymentData]];

    [requestMessage addChild:[InAppSDKSoapNode createAuthorizationDataService]];
    [requestMessage addChild:[InAppSDKSoapNode createApplePayPaymentSolution]];
    return requestMessage;
}

+ (InAppSDKSoapStructure *) createEncryptPaymentDataService
{
    
    InAppSDKSoapStructure * encryptPaymentDataService = [InAppSDKSoapStructure createElementWithName:@"encryptPaymentDataService"
                                                                            withNamespace:[InAppSDKSoapNamespace transactionNamespace]];
    
    [encryptPaymentDataService addParameter:[InAppSDKSoapNode createRunTrueParameter]];
    
    
    return encryptPaymentDataService;
    
}

+ (InAppSDKSoapStructure *) createAuthorizationDataService
{

  InAppSDKSoapStructure * authorizationService = [InAppSDKSoapStructure createElementWithName:@"ccAuthService"
                                                                                withNamespace:[InAppSDKSoapNamespace transactionNamespace]];

  [authorizationService addParameter:[InAppSDKSoapNode createRunTrueParameter]];


  return authorizationService;

}

+ (InAppSDKSoapStructure *) createRunTrueParameter
{
    return [InAppSDKSoapStructure createElementWithName:@"run" withValue:@"true"];
}


@end
