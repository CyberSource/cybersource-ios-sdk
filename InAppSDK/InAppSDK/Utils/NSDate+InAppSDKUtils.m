//
//  NSDate+InAppSDKUtils.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "NSDate+InAppSDKUtils.h"
#import <UIKit/UIKit.h>

@implementation NSDate (InAppSDKUtils)

static NSInteger const kDay = 24;
static NSInteger const kWeek = 7;


+ (NSDate *) today0am
{
    return [[NSDate gregorianCalendar] dateFromComponents:[NSDate componentsWithDate:[NSDate date]
                                                                                hour:0]];
}

+ (NSDate *) yesterday0am
{
    return [[NSDate gregorianCalendar] dateFromComponents:[NSDate componentsWithDate:[NSDate date]
                                                                                hour:-kDay]];
}

+ (NSDate *) beginningOfWeek
{
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekdayOrdinal fromDate:now];
    return [calendar dateFromComponents:[NSDate componentsWithDate:now
                                                              hour:-(kDay * ([weekdayComponents weekday] - 1))]];
}

+ (NSDate *) beginningOfPreviousWeek
{
    NSCalendar *calendar = [NSDate gregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekdayOrdinal fromDate:now];
    return [calendar dateFromComponents:[NSDate componentsWithDate:now
                                                              hour:-((kDay * ([weekdayComponents weekday] - 1)) + (kDay * kWeek))]];
}

+ (NSDate *) last7Days
{
    return [[NSDate gregorianCalendar] dateFromComponents:[NSDate componentsWithDate:[NSDate date]
                                                                                hour:-(kDay * kWeek)]];
}

+ (NSDate *) last14Days
{
    return [[NSDate gregorianCalendar] dateFromComponents:[NSDate componentsWithDate:[NSDate date]
                                                                                hour:-((kDay * kWeek) * 2)]];
}

+ (NSCalendar *) gregorianCalendar
{
    static dispatch_once_t pred = 0;
    __strong static NSCalendar * _resultCalendar = nil;
    dispatch_once(&pred, ^{
        _resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    });
    return _resultCalendar;
}

+ (NSDateComponents *) componentsWithDate:(NSDate *)paramDate hour:(NSInteger)paramHour
{
    NSDateComponents *components = [[NSDate gregorianCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                 fromDate:paramDate];
    [components setTimeZone:[NSTimeZone localTimeZone]];
    [components setHour:paramHour];
    [components setMinute:0];
    [components setSecond:[[NSTimeZone localTimeZone] secondsFromGMT]];
    return components;
}

- (NSString *) milliseconds
{
    return [NSString stringWithFormat:@"%.0f", ([self timeIntervalSince1970] * 1000)];
}

- (NSDateFormatter *) dateFormatter
{
    NSDateFormatter *resultFormatter = [[NSDateFormatter alloc] init];
    resultFormatter.timeZone = [NSTimeZone localTimeZone];
    return resultFormatter;
}

- (NSString *) timeString
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [dateFormatter stringFromDate:self];
}

- (NSString *) dateString
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:self];
}

- (NSString *) dateAndTime
{
    return [NSString stringWithFormat:@"%@ %@", [self dateString], [self timeString]];
}

+ (NSDate *) dateWithString:(NSString *)paramString
{
    if ([paramString length] == 0)
    {
        return nil;
    }
    
    // expecting following format 2013-07-12T07:47:14Z
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    NSDate *date = nil;
    NSInteger currentSystemVersionNumber = ([[[UIDevice currentDevice] systemVersion] characterAtIndex:0] - '0');
    if (currentSystemVersionNumber >= 6) {
        date = [dateFormatter dateFromString:paramString];
    } else {
        date = [dateFormatter dateFromString:[paramString stringByReplacingOccurrencesOfString:@"Z" withString:@"+0000"]];
    }
    return date;
}

+ (NSDate *) dateWithMilliseconds:(NSDecimalNumber *)paramMilliseconds {
    return [NSDate dateWithTimeIntervalSince1970:[[paramMilliseconds decimalNumberByMultiplyingByPowerOf10:-3]
                                                  doubleValue]];
}

@end
