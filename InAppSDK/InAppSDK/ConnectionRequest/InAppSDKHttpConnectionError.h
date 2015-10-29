//
//  InAppSDKHttpConnectionError.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKError.h"

typedef enum
{
    INAPPSDK_HTTP_ERROR_TYPE_NOT_DEFINED = 0,
    INAPPSDK_HTTP_ERROR_TYPE_OK = 200,
    INAPPSDK_HTTP_ERROR_TYPE_CREATED = 201,
    INAPPSDK_HTTP_ERROR_TYPE_ACCEPTED = 202,
    INAPPSDK_HTTP_ERROR_TYPE_BAD_REQUEST = 400,
    INAPPSDK_HTTP_ERROR_TYPE_UNAUTHORIZED = 401,
    INAPPSDK_HTTP_ERROR_TYPE_FORBIDDEN = 403,
    INAPPSDK_HTTP_ERROR_TYPE_NOT_FOUND = 404,
    INAPPSDK_HTTP_ERROR_TYPE_SERVER = 500
    
} InAppSDKHTTPErrorType;


@interface InAppSDKHttpConnectionError : InAppSDKError

@end
