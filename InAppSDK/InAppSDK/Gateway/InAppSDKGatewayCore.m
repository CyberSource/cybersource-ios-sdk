//
//  InAppSDKGatewayCore.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKGatewayCore.h"
#import "InAppSDKTransactionObject.h"
#import "InAppSDKCybsServiceAPIs.h"
#import "InAppSDKHttpConnectionError.h"
#import "InAppSDKCybsResponseNodeBody.h"
#import "InAppSDKCybsXMLParser.h"
#import "InAppSDkCybsApiError.h"
#import "NSDate+InAppSDKUtils.h"
#import "InAppSDKInternal.h"
#import "InAppSDKMerchant.h"
#import "InAppSDKStringValidator.h"
#import "InAppSDKCardFieldsValidator.h"
#import "InAppSDKCardData.h"



@interface InAppSDKGatewayCore()

@property (nonatomic, strong) InAppSDKTransactionObject *currentTransaction;
@property (nonatomic, weak) id<InAppSDKGatewayDelegate> delegate;

@end


@implementation InAppSDKGatewayCore

#pragma mark - Singleton -

+ (InAppSDKGatewayCore *) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark - Interface methods -


- (BOOL) performPaymentDataEncryption:(InAppSDKTransactionObject *)paramTransaction withDelegate:(id<InAppSDKGatewayDelegate>)paramDelegate
{
    // Perform one request at a time
    if (([self isGWServiceInProgress]) || (paramTransaction == nil))
    {
        return NO;
    }
    
    if (![self verifyTransactionObject:paramTransaction withDelegate:paramDelegate])
    {
        return NO;
    }
    else
    {
        // Initialize the InAppSDKInternal with credetials.
       [InAppSDKInternal sharedInstance].merchantId = paramTransaction.merchant.merchantID;
       [InAppSDKInternal sharedInstance].password = paramTransaction.merchant.passwordDigest;
       [InAppSDKInternal sharedInstance].userName = paramTransaction.merchant.userName;
   
        
        BOOL encryptionRequested = [InAppSDKCybsServiceAPIs requestEncryptPaymentDataService:paramTransaction withDelegate: self];
        
        return encryptionRequested;
    }
}


- (BOOL) verifyTransactionObject:(InAppSDKTransactionObject *)paramTransaction withDelegate:(id<InAppSDKGatewayDelegate>)paramDelegate
{
    BOOL result = YES;
    
    if ((paramTransaction == nil) || (paramDelegate == nil))
    {
        result = NO;
    }
    else
    {
        if ([paramTransaction.merchant.merchantID length] == 0 ||
            [paramTransaction.merchant.passwordDigest length] == 0 ||
            ![InAppSDKCardFieldsValidator validateCardWithLuhnAlgorithm:paramTransaction.cardData.accountNumber] ||
            ![InAppSDKCardFieldsValidator validateExpirationDateWithMonthString:paramTransaction.cardData.expirationMonth andYearString:paramTransaction.cardData.expirationYear] ||
            ![InAppSDKCardFieldsValidator validateSecurityCodeWithString:paramTransaction.cardData.cvNumber]
            )

        {
            result = NO;
        }
        else
        {
           self.delegate = paramDelegate;
        }
    }
    return result;
}


#pragma mark - InAppSDKClientServerDelegate -

-(void) requestWithId:(InAppSDKGatewayApiType)paramRequestType finishedWithData:(id)paramData withError:(InAppSDKError *)paramError
{
    if (([(NSData *)paramData length] == 0) &&
        (paramError.code == INAPPSDK_HTTP_ERROR_TYPE_NOT_DEFINED))
    {
        return;
    }
    
   
    InAppSDKGatewayResponse *gatewayResponse = [[InAppSDKGatewayResponse alloc] init];
    gatewayResponse.type = paramRequestType;
    
    InAppSDKError *paymentError = paramError;
    InAppSDKCybsResponseNodeBody *response = nil;
    
    if (paramData != nil)
    {
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:paramData];
        response = [[InAppSDKCybsResponseNodeBody alloc] init];
        InAppSDKCybsXMLParser * xmlCYBSParser = [[InAppSDKCybsXMLParser alloc] initParserWithCybsBody:response error:&paymentError];
        
        if ((xmlCYBSParser != nil) && (paymentError == nil))
        {
            // this class will handle the events
            [xmlParser setDelegate:xmlCYBSParser];
            [xmlParser setShouldResolveExternalEntities:NO];
            // now parse the document
            BOOL parserStatus = [xmlParser parse];
            
            if (parserStatus && (response != nil))
            {
               
                if ([response.nodeReplayMessage.decision isEqualToString:kCybsResponseNodeAccept])
                {
                    gatewayResponse.decision = INAPPSDK_GATEWAY_DECISION_TYPE_ACCEPT;
                    InAppSDKEncryptedPayment * encryptedPaymentData = [[InAppSDKEncryptedPayment alloc]init];
                    encryptedPaymentData.data = response.nodeReplayMessage.encrypted_payment_data;
                    gatewayResponse.encryptedPayment = encryptedPaymentData;
                    gatewayResponse.rmsg = response.nodeReplayMessage.encrypt_payment_data_rmsg;
                }
                else if ([response.nodeReplayMessage.decision isEqualToString:kCybsResponseNodeError])
                {
                    gatewayResponse.decision = INAPPSDK_GATEWAY_DECISION_TYPE_ERROR;
                    gatewayResponse.rmsg = response.nodeReplayMessage.encrypt_payment_data_rmsg;
                    paymentError = [InAppSDKCybsApiError createFromResponse:response];
                }
                else if ([response.nodeReplayMessage.decision isEqualToString:kCybsResponseNodeReject])
                {
                    gatewayResponse.decision = INAPPSDK_GATEWAY_DECISION_TYPE_REJECT;
                    paymentError = [InAppSDKCybsApiError createFromResponse:response];
                }
                else if ([response.nodeReplayMessage.decision isEqualToString:kCybsResponseNodeReview])
                {
                    gatewayResponse.decision = INAPPSDK_GATEWAY_DECISION_TYPE_REVIEW;
                }
                else if (response.nodeFault != nil)
                {
                    gatewayResponse.decision = INAPPSDK_GATEWAY_DECISION_TYPE_FAILED;
                    paymentError = [InAppSDKCybsApiError createFromResponse:response];
                }
                
                //Generic
                gatewayResponse.resultCode = response.nodeReplayMessage.reasonCode;
                gatewayResponse.requestId = response.nodeReplayMessage.requestID;

            }
            else
            {
                // should we provide more information?
            }
        }
    }
    [self performFeedbackWithGatewayResponse:gatewayResponse withError:paymentError];
}


- (void) processWithRequestType:(InAppSDKGatewayApiType)paramRequestType
                        message:(InAppSDKCybsResponseNodeReplyMessage*)paramMessage
                       response:(InAppSDKGatewayResponse *)paramGatewayResponse
{
    switch (paramRequestType)
    {
        case INAPPSDK_GATEWAY_API_TYPE_ENCRYPT:
        {
            [self PerformEncryptionPaymentDataServiceWithResponse:paramMessage withGatewayResponse:paramGatewayResponse];
            break;
        }
         default:
        {
            break;
        }
    }
}

- (void) PerformEncryptionPaymentDataServiceWithResponse:(InAppSDKCybsResponseNodeReplyMessage *)aResponse
                      withGatewayResponse:(InAppSDKGatewayResponse *)aGatewayResponse
{

}

- (void) updateGatewayResponse:(InAppSDKGatewayResponse *)aGatewayResponse withDateTime:(NSString *)timeOfGatewayeRequest
{
    // set date and time in gateway response converted to localtime since gateway responds with UTC timezone
    aGatewayResponse.date = [NSDate dateWithString:timeOfGatewayeRequest];
}


#pragma mark - performing feedback -

- (void) performFeedbackWithGatewayResponse:(InAppSDKGatewayResponse *)paramGatewayResponse withError:(InAppSDKError *)paramError
{
    
    if (self.currentTransaction.transactionType == INAPPSDK_GATEWAY_API_TYPE_ENCRYPT)
    {
        
        if (paramGatewayResponse.type == INAPPSDK_GATEWAY_API_TYPE_ENCRYPT)
        {
            
        }
    }
    
    self.currentTransaction = nil;
    
    switch (paramGatewayResponse.type)
    {
        case INAPPSDK_GATEWAY_API_TYPE_ENCRYPT:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(encryptPaymentDataServiceFinishedWithGatewayResponse:withError:)])
            {
                [self.delegate encryptPaymentDataServiceFinishedWithGatewayResponse:paramGatewayResponse withError:paramError];
            }
            break;
        }
         default:
            break;
    }
}


@end
