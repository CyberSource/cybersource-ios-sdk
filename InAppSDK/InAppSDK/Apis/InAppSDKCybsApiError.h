//
//  InAppSDKCybsApiError.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKGatewayError.h"
#import "InAppSDKCybsResponseNodeBody.h"


static const NSInteger kGatewaySuccess = 100;
static const NSInteger kPartiallyApproved = 110;

//!This enumeration represents different types of the Authorization errors.
typedef enum {
    INAPPSDK_CYBS_API_ERROR_TYPE_NOT_DEFINED                                   = 0,
    INAPPSDK_CYBS_API_ERROR_TYPE_MISSING_FIELDS                                = 101,
    INAPPSDK_CYBS_API_ERROR_TYPE_FIELDS_CONTAINS_INVALID_DATA                  = 102,
    INAPPSDK_CYBS_API_ERROR_TYPE_ONLY_PARTIAL_APPROVED                         = 110,
    INAPPSDK_CYBS_API_ERROR_TYPE_GENERAL_SYSTEM_FAILURE                        = 150,
    INAPPSDK_CYBS_API_ERROR_TYPE_SERVER_TIMEOUT                                = 151,
    INAPPSDK_CYBS_API_ERROR_TYPE_SERVICE_DID_NOT_FINISH                        = 152,
    INAPPSDK_CYBS_API_ERROR_TYPE_DID_NOT_PASS_AVS                              = 200,
    INAPPSDK_CYBS_API_ERROR_TYPE_ISSUING_BANK_HAS_QUESTIONS                    = 201,
    INAPPSDK_CYBS_API_ERROR_TYPE_EXPIRED_CARD                                  = 202,
    INAPPSDK_CYBS_API_ERROR_TYPE_GENERAL_DECLINE                               = 203,
    INAPPSDK_CYBS_API_ERROR_TYPE_INSUFFICIENT_FUNDS                            = 204,
    INAPPSDK_CYBS_API_ERROR_TYPE_STOLEN_OR_LOST_CARD                           = 205,
    INAPPSDK_CYBS_API_ERROR_TYPE_ISSUING_BANK_UNAVAILABLE                      = 207,
    INAPPSDK_CYBS_API_ERROR_TYPE_INACTIVE_CARD                                 = 208,
    INAPPSDK_CYBS_API_ERROR_TYPE_CID_DID_NOT_MATCH                             = 209,
    INAPPSDK_CYBS_API_ERROR_TYPE_CREDIT_LIMIT                                  = 210,
    INAPPSDK_CYBS_API_ERROR_TYPE_INVALID_CVN                                   = 211,
    INAPPSDK_CYBS_API_ERROR_TYPE_NEGATIVE_FILE                                 = 221,
    INAPPSDK_CYBS_API_ERROR_TYPE_DID_NOT_PASS_CVN_CHECK                        = 230,
    INAPPSDK_CYBS_API_ERROR_TYPE_INVALID_ACCOUNT_NUMBER                        = 231,
    INAPPSDK_CYBS_API_ERROR_TYPE_CARD_TYPE_NOT_EXPECTED                        = 232,
    INAPPSDK_CYBS_API_ERROR_TYPE_GENERAL_DECLINE_BY_PROCESSOR                  = 233,
    INAPPSDK_CYBS_API_ERROR_TYPE_PROBLEM_WITH_INFORMATION                      = 234,
    INAPPSDK_CYBS_API_ERROR_TYPE_CAPTURE_AMOUNT_EXCEEDS                        = 235,
    INAPPSDK_CYBS_API_ERROR_TYPE_PROCESSOR_FAILURE                             = 236,
    INAPPSDK_CYBS_API_ERROR_TYPE_ALREADY_REVERSED                              = 237,
    INAPPSDK_CYBS_API_ERROR_TYPE_ALREADY_CAPTURED                              = 238,
    INAPPSDK_CYBS_API_ERROR_TYPE_TRANSACTION_AMOUNT_MUST_MATCH_PREVIOUS_AMOUNT = 239,
    INAPPSDK_CYBS_API_ERROR_TYPE_CARD_TYPE_INVALID                             = 240,
    INAPPSDK_CYBS_API_ERROR_TYPE_REQUEST_ID_INVALID                            = 241,
    INAPPSDK_CYBS_API_ERROR_TYPE_NO_CORRESPONDING                              = 242,
    INAPPSDK_CYBS_API_ERROR_TYPE_TRANSACTION_SETTLED_OR_REVERSED               = 243,
    INAPPSDK_CYBS_API_ERROR_TYPE_NOT_VOIDABLE                                  = 246,
    INAPPSDK_CYBS_API_ERROR_TYPE_REQUEST_FOR_CAPTURE_THAT_WAS_VOIDED           = 247,
    INAPPSDK_CYBS_API_ERROR_TYPE_TIMEOUT_AT_PAYMENT_PROCESSOR                  = 250,
    INAPPSDK_CYBS_API_ERROR_TYPE_STAND_ALONE_CREDITS_NOT_ALLOWED               = 254,
    INAPPSDK_CYBS_API_ERROR_TYPE_NETWORK_CONNECTION                            = 998,
    
} InAppSDKCybsAPIErrorType;


@interface InAppSDKCybsApiError : InAppSDKGatewayError

+ (InAppSDKCybsApiError *) createFromResponse:(InAppSDKCybsResponseNodeBody *)aResponse;

@end
