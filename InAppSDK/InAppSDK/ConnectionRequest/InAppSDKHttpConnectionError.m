//
//  InAppSDKHttpConnectionError.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKHttpConnectionError.h"

static NSString * const kInAppSDKHttpError = @"InAppSDKError";


@implementation InAppSDKHttpConnectionError

+ (id) errorWithCode:(NSInteger)paramCode
{
    
    if ((paramCode == INAPPSDK_HTTP_ERROR_TYPE_OK) ||
        (paramCode == INAPPSDK_HTTP_ERROR_TYPE_ACCEPTED) ||
        (paramCode == INAPPSDK_HTTP_ERROR_TYPE_CREATED) ||
        (paramCode == INAPPSDK_HTTP_ERROR_TYPE_SERVER))
    {
        // server responded - parse response
        return nil;
    }
    else
    {
        NSDictionary *userInfo = [InAppSDKHttpConnectionError userInfoWithErrorCode:paramCode];
        return [[InAppSDKError alloc] initWithDomain:kInAppSDKHttpError code:paramCode userInfo:userInfo];
    }
}

+ (NSDictionary *) userInfoWithErrorCode:(NSInteger)paramCode
{
    NSString *errorDescription = nil;
    NSString *errorReason = nil;
    
    switch (paramCode)
    {
        case INAPPSDK_HTTP_ERROR_TYPE_BAD_REQUEST:
        {
            errorDescription = @"Bad request";
            errorReason = [NSString stringWithFormat:@"Bad syntax:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_UNAUTHORIZED:
        {
            errorDescription = @"Unauthorized";
            errorReason = [NSString stringWithFormat:@"Access unauthorized:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_FORBIDDEN:
        {
            errorDescription = @"Forbidden";
            errorReason = [NSString stringWithFormat:@"Access forbidden:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_NOT_FOUND:
        {
            errorDescription = @"Not found";
            errorReason = [NSString stringWithFormat:@"The requested resource could not be found:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_BADURL:
        {
            errorDescription = @"Bad URL";
            errorReason = [NSString stringWithFormat:@"BadURL:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_TIMEOUT:
        {
            errorDescription = @"Timeout happened, try again";
            errorReason = [NSString stringWithFormat:@"Timeout:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_UNSUPPORTEDURL:
        {
            errorDescription = @"Un Supported URL";
            errorReason = [NSString stringWithFormat:@"Un Supported URL:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_CANNOTFINDHOST:
        {
            errorDescription = @"Cannot find Host";
            errorReason = [NSString stringWithFormat:@"Cannot find Host:%ld", (long)paramCode];
            break;
        }
            
        case INAPPSDK_HTTP_ERROR_TYPE_CANNOTCONNECTTOHOST:
        {
            errorDescription = @"Cannot connect to Host";
            errorReason = [NSString stringWithFormat:@"Cannot connect to Host:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_NETWORKCONNECTIONLOST:
        {
            errorDescription = @"Network Connection Lost";
            errorReason = [NSString stringWithFormat:@"Network Connection Lost:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_DNSLOOKUPFAILED:
        {
            errorDescription = @"DNS Lookup failed";
            errorReason = [NSString stringWithFormat:@"DNS Lookup failed:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_HTTPTOOMANYREDIRECTS:
        {
            errorDescription = @"HTTP Too Many Redirects";
            errorReason = [NSString stringWithFormat:@"HTTP Too Many Redirects:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_RESOURCEUNAVAILABLE:
        {
            errorDescription = @"Resource Unavailable";
            errorReason = [NSString stringWithFormat:@"Resource Unavailable:%ld", (long)paramCode];
            break;
        }
        case INAPPSDK_HTTP_ERROR_TYPE_NOTCONNECTEDTOINTERNET:
        {
            errorDescription = @"Not Connected to Internet, Enable the Internet Connection and Try again";
            errorReason = [NSString stringWithFormat:@"Not Connected to Internet:%ld", (long)paramCode];
            break;
        }
     
        default:
        {
            errorDescription = @"Unknown error";
            errorReason = [NSString stringWithFormat:@"Http error:%ld", (long)paramCode];
            break;
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            errorDescription, NSLocalizedDescriptionKey,
            errorReason, NSLocalizedFailureReasonErrorKey, nil];
}



@end
