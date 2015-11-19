//
//  InAppSDKStringValidator.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 11/17/15.
//  Copyright © 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKStringValidator.h"

@implementation NSString (InAppSDKConstants)

+ (NSString *) space
{
    return @" ";
}

+ (NSString *) comma
{
    return @",";
}

+ (NSString *) dot
{
    return @".";
}

+ (NSString *) percent
{
    return @"%";
}

+ (NSString *) newLine
{
    return @"\n";
}

+ (NSString *) carriageReturn
{
    return @"\r";
}

+ (NSString *) qrCodeItemSeparator
{
    return @"<|>";
}

+ (NSString *) addressPartsSeparator
{
    return @", ";
}

+ (NSString *) stateAndZipCodeSeparator
{
    return [self space];
}

+ (NSString *) underline
{
    return @"_";
}

+ (NSString *) passwordDot
{
    static const unichar kUnichar = 0x00B7;
    return [[NSString alloc] initWithCharacters:&kUnichar length:1];
}

@end


@implementation InAppSDKStringValidator

+ (BOOL) isEmpty:(NSString*)paramString
{
    BOOL result = NO;
    if ((paramString == nil) || [paramString isKindOfClass:[NSNull class]])
    {
        result = YES;
    }
    else
    {
        NSString *tempString = [paramString stringByReplacingOccurrencesOfString:[NSString space] withString:[NSString string]];
        if (![tempString length])
        {
            result = YES;
        }
    }
    return result;
}

+ (BOOL) isNumber:(NSString *)paramString
{
    BOOL result = YES;
    if ([paramString length] == 0)
    {
        result = NO;
    }
    else
    {
        NSString *trimmedString = [paramString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        if ([trimmedString length])
        {
            result = NO;
        }
    }
    return result;
}

+ (BOOL) isAlphanumeric:(NSString *)paramString
{
    BOOL result = YES;
    if ([paramString length] == 0)
    {
        result = NO;
    }
    else
    {
        if ([InAppSDKStringValidator isNumber:paramString])
        {
            result = NO;
        }
        else
        {
            NSString *trimmedString = [paramString stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]];
            if ([trimmedString length])
            {
                result = NO;
            }
        }
    }
    return result;
}


@end
