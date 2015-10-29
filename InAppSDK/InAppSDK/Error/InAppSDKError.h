//
//  InAppSDKError.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

//!This enumeration represents different types of the general errors.
typedef enum
{
    INAPPSDK_ERROR_TYPE_UNKNOWN                   = 0
    
} InAppSDKErrorType;

@interface InAppSDKError : NSError

//! The extended message of the error
@property (nonatomic, copy) NSString *extraMessage;

//! Creates the error with the code
/*!
 \param paramCode the code.
 \return created @see InAppSDKError object or \c nil if failed to create.
 */
+ (id) errorWithCode:(NSInteger)paramCode;

//! Get additional information about error code
+ (NSDictionary *) userInfoWithErrorCode:(NSInteger)paramCode;

//! Creates summarised description string from the original \c paramError
/*! Output takes the following form:
 "Original error domain: <>, code: <>, description: <>"
 */
+ (NSString *) stringWithError:(NSError *)paramError;


@end
