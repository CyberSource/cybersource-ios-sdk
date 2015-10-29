//
//  InAppSDKError.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKError.h"

static NSString * const kInAppSDKError = @"InAppSDKError";

@implementation InAppSDKError

+ (id) errorWithCode:(NSInteger)paramCode
{
    NSDictionary *userInfo = [InAppSDKError userInfoWithErrorCode:paramCode];
    return [[InAppSDKError alloc] initWithDomain:kInAppSDKError code:paramCode userInfo:userInfo];
}

+ (NSDictionary *) userInfoWithErrorCode:(NSInteger)paramCode
{
    NSString *errorDescription = nil;
    NSString *errorReason = nil;
    
    switch (paramCode)
    {
        case INAPPSDK_ERROR_TYPE_UNKNOWN:
        default:
        {
            errorDescription = @"Unknown error";
            errorReason = [NSString stringWithFormat:@"Unknown error code:%ld", (long)paramCode];
            break;
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            errorDescription, NSLocalizedDescriptionKey,
            errorReason, NSLocalizedFailureReasonErrorKey, nil];
}

- (NSString *) localizedDescription
{
    NSString *description = [self.userInfo objectForKey:NSLocalizedDescriptionKey];
    if ([self.extraMessage length])
    {
        description = [description stringByAppendingFormat:@" (%@)", self.extraMessage];
    }
    
    return description;
}

+ (NSString *) stringWithError:(NSError *)paramError
{
    return [NSString stringWithFormat:@"Original error domain: %@, code: %ld, description: %@",
            paramError.domain, (long)paramError.code, paramError.localizedDescription];
}


@end
