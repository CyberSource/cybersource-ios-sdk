//
//  InAppSDKCybsApiError.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCybsApiError.h"

@implementation InAppSDKCybsApiError

+ (InAppSDKCybsApiError *) createFromResponse:(InAppSDKCybsResponseNodeBody *)aResponse
{
    
    NSInteger reasonCYBSCode = [aResponse.nodeReplayMessage.reasonCode integerValue];
    NSInteger sdkCode = [InAppSDKCybsApiError translateToSDKCode:reasonCYBSCode];
    
    if (sdkCode == reasonCYBSCode)
    {
        if ([aResponse.nodeFault.faultcode isEqualToString:@"TokenInvalid"])
        {
            sdkCode = INAPPSDK_GATEWAY_ERROR_INVALID_TOKEN;
        }
    }
    
    InAppSDKCybsApiError *responseError = [InAppSDKGatewayError errorWithCode:sdkCode];
    
    if ([aResponse.nodeFault.faultstring length])
    {
        [responseError setExtraMessage:aResponse.nodeFault.faultstring];
    }
    else if (aResponse.nodeFault.faultcode != nil)
    {
        [responseError setExtraMessage:[NSString stringWithFormat:@"Fault code: %@",aResponse.nodeFault.faultcode]];
    }
    else if ([aResponse.nodeReplayMessage.invalidField length])
    {
        [responseError setExtraMessage:aResponse.nodeReplayMessage.invalidField];
    }
    else if ([aResponse.nodeReplayMessage.missingField length])
    {
        [responseError setExtraMessage:aResponse.nodeReplayMessage.missingField];
    }
    
    return responseError;
}

+ (NSInteger) translateToSDKCode:(NSInteger)cybsCode
{
    
    NSInteger sdkErrorCode = cybsCode;
    
    switch (cybsCode)
    {
        case INAPPSDK_CYBS_API_ERROR_TYPE_MISSING_FIELDS:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_MISSING_FIELDS;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_FIELDS_CONTAINS_INVALID_DATA:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_FIELDS_CONTAINS_INVALID_DATA;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_ONLY_PARTIAL_APPROVED:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_ONLY_PARTIAL_APPROVED;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_GENERAL_SYSTEM_FAILURE:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_GENERAL_SYSTEM_FAILURE;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_SERVER_TIMEOUT:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_SERVER_TIMEOUT;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_SERVICE_DID_NOT_FINISH :
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_SERVICE_DID_NOT_FINISH ;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_DID_NOT_PASS_AVS:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_DID_NOT_PASS_AVS;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_ISSUING_BANK_HAS_QUESTIONS:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_ISSUING_BANK_HAS_QUESTIONS;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_EXPIRED_CARD:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_EXPIRED_CARD;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_GENERAL_DECLINE:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_GENERAL_DECLINE;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_INSUFFICIENT_FUNDS:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_INSUFFICIENT_FUNDS;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_STOLEN_OR_LOST_CARD:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_STOLEN_OR_LOST_CARD;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_ISSUING_BANK_UNAVAILABLE:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_ISSUING_BANK_UNAVAILABLE;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_INACTIVE_CARD:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_INACTIVE_CARD;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_CID_DID_NOT_MATCH:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_CID_DID_NOT_MATCH;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_CREDIT_LIMIT:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_CREDIT_LIMIT;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_INVALID_CVN:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_INVALID_CVN;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_NEGATIVE_FILE:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_NEGATIVE_FILE;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_DID_NOT_PASS_CVN_CHECK:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_DID_NOT_PASS_CVN_CHECK;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_INVALID_ACCOUNT_NUMBER:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_INVALID_ACCOUNT_NUMBER;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_CARD_TYPE_NOT_EXPECTED:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_CARD_TYPE_NOT_EXPECTED;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_GENERAL_DECLINE_BY_PROCESSOR:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_GENERAL_DECLINE_BY_PROCESSOR;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_PROBLEM_WITH_INFORMATION:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_PROBLEM_WITH_INFORMATION;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_CAPTURE_AMOUNT_EXCEEDS:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_CAPTURE_AMOUNT_EXCEEDS;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_PROCESSOR_FAILURE:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_PROCESSOR_FAILURE;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_ALREADY_REVERSED:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_ALREADY_REVERSED;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_ALREADY_CAPTURED:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_ALREADY_CAPTURED;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_TRANSACTION_AMOUNT_MUST_MATCH_PREVIOUS_AMOUNT:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_TRANSACTION_AMOUNT_MUST_MATCH_PREVIOUS_AMOUNT;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_CARD_TYPE_INVALID:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_CARD_TYPE_INVALID;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_REQUEST_ID_INVALID:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_REQUEST_ID_INVALID;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_NO_CORRESPONDING:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_NO_CORRESPONDING;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_TRANSACTION_SETTLED_OR_REVERSED:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_TRANSACTION_SETTLED_OR_REVERSED;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_NOT_VOIDABLE :
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_NOT_VOIDABLE ;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_REQUEST_FOR_CAPTURE_THAT_WAS_VOIDED :
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_REQUEST_FOR_CAPTURE_THAT_WAS_VOIDED ;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_TIMEOUT_AT_PAYMENT_PROCESSOR :
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_TIMEOUT_AT_PAYMENT_PROCESSOR ;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_STAND_ALONE_CREDITS_NOT_ALLOWED:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_STAND_ALONE_CREDITS_NOT_ALLOWED;
            break;
        case INAPPSDK_CYBS_API_ERROR_TYPE_NETWORK_CONNECTION:
            sdkErrorCode = INAPPSDK_GATEWAY_ERROR_NETWORK_CONNECTION;
            break;
            
        default:
            sdkErrorCode = cybsCode;
            break;
    }
    
    return sdkErrorCode;
}


@end
