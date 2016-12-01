//
//  InAppSDKCardFieldsValidator.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 11/17/15.
//  Copyright © 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKCardFieldsValidator.h"
#import "InAppSDKStringValidator.h"
#import "InAppSDKCardData.h"

@implementation InAppSDKCardFieldsValidator

+ (int) cardExpirationYearMin
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (int)[components year];
}


+ (BOOL) validateCardNumberWithString:(NSString *)aCardNumber
{
    BOOL result = NO;
    
    aCardNumber = [aCardNumber stringByReplacingOccurrencesOfString:[NSString space] withString:[NSString string]];
    if ([InAppSDKStringValidator isNumber:aCardNumber])
    {
        if ((aCardNumber.length >= kInAppSDKCardNumberCharacterCountMin) &&
            (aCardNumber.length <= kInAppSDKCardNumberCharacterCountMax))
        {
            result = YES;
        }
    }
    
    return result;
}

+ (BOOL) validateMonthWithString:(NSString*)aMonth
{
    BOOL result = NO;
    
    if ([InAppSDKStringValidator isNumber:aMonth])
    {
        NSInteger monthNumber = [aMonth integerValue];
        
        if ((monthNumber >= kInAppSDKCardExpirationMonthMin) &&
            (monthNumber <= kInAppSDKCardExpirationMonthMax))
        {
            result = YES;
        }
    }
    
    return result;
}

+ (BOOL) validateYearWithString:(NSString*)aYear
{
    BOOL result = NO;
    
    if([aYear length] != 2 || [aYear length] != 4 )
    {
        result = NO;
    }
    
    if ([aYear length] == 2)
    {
        if ([InAppSDKStringValidator isNumber:aYear])
        {
            NSInteger yearNumber = [aYear integerValue];
            
            if ((yearNumber >= [self cardExpirationYearMin]%100 &&
                 (yearNumber <= kInAppSDKCardExpirationYearMax)))
            {
                result = YES;
            }
        }
    }
    else if ([aYear length] == 4)
    {
        if ([InAppSDKStringValidator isNumber:aYear])
        {
            NSInteger yearNumber = [aYear integerValue];
            
            if ((yearNumber >= [self cardExpirationYearMin]))
            {
                result = YES;
            }
        }
    }
    else
    {
        result = NO;
    }
    
    
    return result;
}


+ (BOOL) validateSecurityCodeWithString:(NSString *)aSecurityCode
{
    BOOL result = NO;
    
    if ([InAppSDKStringValidator isNumber:aSecurityCode])
    {
        if ((aSecurityCode.length == kInAppSDKSecurityCodeCharacterCountMin)  ||
            (aSecurityCode.length == kInAppSDKSecurityCodeCharacterCountMax))
        {
            result = YES;
        }
    }
    
    return result;
}

+ (BOOL) validateZipCodeWithString:(NSString *)aZipCode
{
    BOOL result = NO;
    
    if ([InAppSDKStringValidator isNumber:aZipCode])
    {
        
        if (aZipCode.length == kInAppSDKZipCodeCharacterCountMax)
        {
            result = YES;
        }
    }
    
    return result;
}

//!--------------------------------------------- advance validation -----------------------------------

+ (BOOL) validateCardWithLuhnAlgorithm:(NSString*)cardNumber
{
    BOOL result = NO;
    
    cardNumber = [cardNumber stringByReplacingOccurrencesOfString:[NSString space] withString:[NSString string]];
    
    if ([cardNumber length])
    {
        NSUInteger elementsCount = [cardNumber length];
        
        NSUInteger arrayOfIntegers[elementsCount];
        
        for (NSInteger index = 0; index < elementsCount; index++)
        {
            NSString * singleCharacter = [NSString stringWithFormat:@"%C",[cardNumber characterAtIndex:index]];
            arrayOfIntegers[[cardNumber length] - 1 - index] = [singleCharacter intValue];
        }
        
        for (NSInteger index = 0; index < elementsCount; index++)
        {
            if (index % 2 != 0)
            {
                arrayOfIntegers[index] *= 2;
            }
        }
        
        int theSum = 0;
        for (NSInteger index = 0; index < elementsCount; index++)
        {
            if (arrayOfIntegers[index] > 9)
            {
                theSum += arrayOfIntegers[index] / 10;
                theSum += arrayOfIntegers[index] % 10;
            }
            else
            {
                theSum += arrayOfIntegers[index];
            }
        }
        
        if ((theSum != 0) && ((theSum % 10) == 0))
        {
            result = YES;
        }
    }
    
    return result;
}

+ (BOOL) validateExpirationDateWithMonthString:(NSString *)aMonth andYearString:(NSString *)aYear
{
    BOOL result = NO;
    
    if ([self validateMonthWithString:aMonth] && [self validateYearWithString:aYear])
    {
        //---  now date
        NSDate* nowDate = [NSDate date];
        
        //--- date expiration
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:1];
        [comps setMonth:[aMonth integerValue]];
        if([aYear length] == 2)
        {
           [comps setYear:2000+[aYear integerValue]];
        }
        else if([aYear length] == 4)
        {
            [comps setYear:[aYear integerValue]];
        }

        NSDate *expirationDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
        
        //--- next month after expiration
        NSDateComponents* monthComponents = [[NSDateComponents alloc] init];
        [monthComponents setMonth:1];
        NSDate* nextDayAfterExpirationDate = [[NSCalendar currentCalendar] dateByAddingComponents:monthComponents toDate:expirationDate options:0];
        
        NSTimeInterval timeIntervalSinceDate = [nextDayAfterExpirationDate timeIntervalSinceDate:nowDate];
        result = (timeIntervalSinceDate > 0);
    }
    
    return result;
}

+ (BOOL) isValidCardData:(InAppSDKCardData*)cardData {
  if (!cardData) { return NO; }
  return ([self validateCardWithLuhnAlgorithm:cardData.accountNumber] &&
         [self validateExpirationDateWithMonthString:cardData.expirationMonth andYearString:cardData.expirationYear]);
}


@end
