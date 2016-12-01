//
//  InAppSDKCardFieldsValidator.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 11/17/15.
//  Copyright © 2015 CyberSource, a Visa Company. All rights reserved.
//

// minimum and maximum length of card number from http://en.wikipedia.org/wiki/Bank_card_number
static const int kInAppSDKCardNumberCharacterCountMin = 12;
static const int kInAppSDKCardNumberCharacterCountMax = 19;
static const int kInAppSDKCardExpirationMonthMin = 1;
static const int kInAppSDKCardExpirationMonthMax = 12;
static const int kInAppSDKCardExpirationYearMax = 99;
static const int kInAppSDKSecurityCodeCharacterCountMin = 3;
static const int kInAppSDKSecurityCodeCharacterCountMax = 4;
static const int kInAppSDKZipCodeCharacterCountMax = 5;

@interface InAppSDKCardFieldsValidator : NSObject

+ (int) cardExpirationYearMin;

//! basic validation
+ (BOOL) validateCardNumberWithString:(NSString *)aCardNumber;
+ (BOOL) validateMonthWithString:(NSString*)aMonth;
+ (BOOL) validateYearWithString:(NSString*)aYear;
+ (BOOL) validateSecurityCodeWithString:(NSString *)aSecurityCode;
+ (BOOL) validateZipCodeWithString:(NSString *)aZipCode;

//! advance validation
+ (BOOL) validateExpirationDateWithMonthString:(NSString *)aMonth andYearString:(NSString *)aYear;
+ (BOOL) validateCardWithLuhnAlgorithm:(NSString*)cardNumber;
+ (BOOL) isValidCardData:(InAppSDKCardData*)cardData;
@end
