//
//  InAppSDKGatewayError.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKGatewayError.h"

@implementation InAppSDKGatewayError

static NSString * const kInAppSDKGatewayError = @"InAppSDKGatewayError";


+ (id) errorWithCode:(NSInteger)paramCode
{
    NSDictionary *userInfo = [InAppSDKGatewayError userInfoWithErrorCode:paramCode];
    return [[InAppSDKGatewayError alloc] initWithDomain:kInAppSDKGatewayError code:paramCode userInfo:userInfo];
}

+ (NSDictionary *) userInfoWithErrorCode:(NSInteger)paramCode
{
    NSString *errorDescription = nil;
    NSString *errorReason = [NSString string];
    
    switch (paramCode)
    {
        case INAPPSDK_GATEWAY_ERROR_MISSING_FIELDS:
        {
            errorDescription = @"The request is missing one or more required fields.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_FIELDS_CONTAINS_INVALID_DATA:
        {
            errorDescription = @"One or more fields in the request contains invalid data.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_ONLY_PARTIAL_APPROVED:
        {
            errorDescription = @"Only a partial amount was approved.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_GENERAL_SYSTEM_FAILURE:
        {
            errorDescription = @"General system failure.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_SERVER_TIMEOUT:
        {
            errorDescription = @"The request was received but there was a server timeout. This error does not include timeouts between the client and the server.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_SERVICE_DID_NOT_FINISH:
        {
            errorDescription = @"The request was received, but a service did not finish running in time.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_DID_NOT_PASS_AVS:
        {
            errorDescription = @"The authorization request was approved by the issuing bank but declined by gateway because it did not pass the Address Verification System (AVS) check.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_ISSUING_BANK_HAS_QUESTIONS:
        {
            errorDescription = @"The issuing bank has questions about the request. You do not receive an authorization code programmatically, but you might receive one verbally by calling the processor.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_EXPIRED_CARD:
        {
            errorDescription = @"Expired card. You might also receive this if the expiration date you provided does not match the date the issuing bank has on file.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_GENERAL_DECLINE:
        {
            errorDescription = @"General decline of the card. No other information was provided by the issuing bank.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_INSUFFICIENT_FUNDS:
        {
            errorDescription = @"Insufficient funds in the account.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_STOLEN_OR_LOST_CARD:
        {
            errorDescription = @"Stolen or lost card.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_ISSUING_BANK_UNAVAILABLE:
        {
            errorDescription = @"Issuing bank unavailable.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_INACTIVE_CARD:
        {
            errorDescription = @"Inactive card or card not authorized for card-not-present transactions.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_CID_DID_NOT_MATCH:
        {
            errorDescription = @"Card Identification Digits (CID) did not match.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_CREDIT_LIMIT:
        {
            errorDescription = @"The card has reached the credit limit.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_INVALID_CVN:
        {
            errorDescription = @"Invalid CVN.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_NEGATIVE_FILE:
        {
            errorDescription = @"The customer matched an entry on the processor’s negative file.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_DID_NOT_PASS_CVN_CHECK:
        {
            errorDescription = @"The card has reached the credit limit.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_INVALID_ACCOUNT_NUMBER:
        {
            errorDescription = @"Invalid account number.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_CARD_TYPE_NOT_EXPECTED:
        {
            errorDescription = @"The card type is not accepted by the payment processor.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_GENERAL_DECLINE_BY_PROCESSOR:
        {
            errorDescription = @"General decline by the processor.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_PROBLEM_WITH_INFORMATION:
        {
            errorDescription = @"There is a problem with the information in your account.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_CAPTURE_AMOUNT_EXCEEDS:
        {
            errorDescription = @"The requested capture amount exceeds the originally authorized amount.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_PROCESSOR_FAILURE:
        {
            errorDescription = @"Processor failure.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_ALREADY_REVERSED:
        {
            errorDescription = @"The authorization has already been reversed.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_ALREADY_CAPTURED:
        {
            errorDescription = @"The authorization has already been captured.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_TRANSACTION_AMOUNT_MUST_MATCH_PREVIOUS_AMOUNT:
        {
            errorDescription = @"The requested transaction amount must match the previous transaction amount.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_CARD_TYPE_INVALID:
        {
            errorDescription = @"The card type sent is invalid or does not correlate with the credit card number.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_REQUEST_ID_INVALID:
        {
            errorDescription = @"The request ID is invalid.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_NO_CORRESPONDING:
        {
            errorDescription = @"You requested a capture, but there is no corresponding, unused authorization record. Occurs if there was not a previously successful authorization request or if the previously successful authorization has already been used by another capture request.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_TRANSACTION_SETTLED_OR_REVERSED:
        {
            errorDescription = @"The transaction has already been settled or reversed.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_NOT_VOIDABLE:
        {
            errorDescription = @"The capture or credit is not voidable because the capture or credit information has already been submitted to your processor or You requested a void for a type of transaction that cannot be voided.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_REQUEST_FOR_CAPTURE_THAT_WAS_VOIDED:
        {
            errorDescription = @"You requested a credit for a capture that was previously voided.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_TIMEOUT_AT_PAYMENT_PROCESSOR:
        {
            errorDescription = @"The request was received, but there was a timeout at the payment processor.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_STAND_ALONE_CREDITS_NOT_ALLOWED:
        {
            errorDescription = @"Stand-alone credits are not allowed.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_NETWORK_CONNECTION:
        {
            errorDescription = @"Network connection problem.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_INVALID_TOKEN:
        {
            errorDescription = @"Access Token authentication failed.";
            break;
        }
        case INAPPSDK_GATEWAY_ERROR_TYPE_UNKNOWN:
        default:
        {
            errorDescription = @"Unknown error.";
            errorReason = [NSString stringWithFormat:@"Unknown gateway error code:%ld", (long)paramCode];
            break;
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            errorDescription, NSLocalizedDescriptionKey,
            errorReason, NSLocalizedFailureReasonErrorKey, nil];
}

+ (BOOL) isGatewayErrorCode:(NSInteger)paramErrorCode
{
    BOOL result = NO;
    if ((paramErrorCode >= INAPPSDK_GATEWAY_ERROR_TYPE_UNKNOWN))
    {
        result = YES;
    }
    return result;
}

@end
