//
//  InAppSDKSignatureGenerator.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/22/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKSignatureGenerator.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>


@implementation InAppSDKSignatureGenerator


- (id) init
{
    self = [super init];
    
    if (self)
    {
        
    }
    return self;
}

//-------WARNING!----------------
// This part of the code that generates the Signature is present here only to show as the sample.
// Signature generation should be done at the Merchant Server.

-(NSString*) generateSignatureWithMerchantId: (NSString *) merchantId
                     transactionSecretKey: (NSString *) transactionSecretKey
                    merchantReferenceCode: (NSString *) merchantReferenceCode
{
    NSDate* dateNow = [NSDate date];
    NSString* fingerprintDateString = [self formatFingerprintDate:dateNow];
    NSString* merchantTransKey = transactionSecretKey;
    
    NSString* fgComponents = [NSString stringWithFormat:@"%@%@%@%@",
                              [self  stringSha1:merchantTransKey],
                              merchantId,
                              merchantReferenceCode,
                              fingerprintDateString];
    
    //NSLog(@"FP Components Before Hash: %@",fgComponents);
    
    NSString* hashedFgComponents = [self stringHmacSha256:fgComponents];
    
    return [NSString stringWithFormat:@"%@#%@", hashedFgComponents, fingerprintDateString];
    
    //return @"YES";
}


- (NSString *) totalAmountFormatterWith: (NSDecimalNumber *) totalAmount
{
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    [formatter setMinimumFractionDigits:2];
    [formatter setDecimalSeparator:@"."];
    [formatter setGroupingSeparator:[NSString string]];
    return [formatter stringFromNumber:totalAmount];
}

-(NSString*) formatFingerprintDate: (NSDate*) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* tz = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    [dateFormatter setTimeZone:tz];
    
    return [dateFormatter stringFromDate:date];
}

- (NSString *)stringSha1:(NSString *)value
{
    const char *cstr = [value cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:value.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    // This is an iOS5-specific method.
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA1(data.bytes, (uint)data.length, digest);
    
    //NSLog(@"SHA1 Digest: %s",digest);
    
    return [self stringHexEncode:digest withLength:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)stringHmacSha256:(NSString *)value
{
    CCHmacContext ctx;
    const char* utf8ValueString = [value UTF8String];
    uint8_t hmacData[CC_SHA256_DIGEST_LENGTH];
    
    CCHmacInit(&ctx, kCCHmacAlgSHA256, utf8ValueString, strlen(utf8ValueString));
    CCHmacUpdate(&ctx, utf8ValueString, strlen(utf8ValueString));
    CCHmacFinal(&ctx, hmacData);
    
    //NSLog(@"HMAC SHA 256: %s", hmacData);
    
    return [self stringHexEncode:hmacData withLength:CC_SHA256_DIGEST_LENGTH];
}

-(NSString*) stringHexEncode: (uint8_t*) data withLength: (NSInteger) dataLength
{
    NSMutableString* output = [NSMutableString stringWithCapacity:dataLength * 2];
    
    // Parse through the CC_SHA256 results (stored inside of digest[]).
    for(int i = 0; i < dataLength; i++) {
        [output appendFormat:@"%02x", data[i]];
    }
    //NSLog(@"String HexEcode : %@", output);
    
    return output;
}

- (NSString*)base64forData:(NSData*)theData
{
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ;
}



@end
