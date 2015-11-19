//
//  InAppSDKStringValidator.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 11/17/15.
//  Copyright © 2015 CyberSource, a Visa Company. All rights reserved.
//

@interface NSString (InAppSDKConstants)

+ (NSString *) space;
+ (NSString *) comma;
+ (NSString *) dot;
+ (NSString *) percent;
+ (NSString *) newLine;
+ (NSString *) carriageReturn;
+ (NSString *) qrCodeItemSeparator;
+ (NSString *) addressPartsSeparator;
+ (NSString *) stateAndZipCodeSeparator;
+ (NSString *) underline;
+ (NSString *) passwordDot;

@end

@interface InAppSDKStringValidator : NSObject

//! Method isEmpty:
/*! isEmpty checks if string in \c paramString is correct NSString object and is not empty.
 \param paramString The string to be examined
 \return YES if condition is true
 */
+ (BOOL) isEmpty:(NSString*)paramString;

//! Method isNumber:
/*! isNumber checks if string in \c paramString contains only number characters.
 \param paramString The string to be examined
 \return YES if condition is true
 */
+ (BOOL) isNumber:(NSString *)paramString;

//! Method isAlphanumeric:
/*! isAlphanumeric checks if string in \c paramString contains only alpha characters.
 \param paramString The string to be examined
 \return YES if condition is true
 */
+ (BOOL) isAlphanumeric:(NSString *)paramString;

@end
