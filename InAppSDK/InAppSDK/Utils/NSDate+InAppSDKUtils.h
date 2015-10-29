//
//  NSDate+InAppSDKUtils.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (InAppSDKUtils)

+ (NSDate *) today0am;
+ (NSDate *) yesterday0am;
+ (NSDate *) beginningOfWeek;
+ (NSDate *) beginningOfPreviousWeek;
+ (NSDate *) last7Days;
+ (NSDate *) last14Days;

- (NSString *) milliseconds;
- (NSString *) dateAndTime;
- (NSString *) dateString;
- (NSString *) timeString;

+ (NSDate *) dateWithMilliseconds:(NSDecimalNumber *)paramMilliseconds;
+ (NSDate *) dateWithString:(NSString *)paramString;


@end
