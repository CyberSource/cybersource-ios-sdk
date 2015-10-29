//
//  InAppSDKKeyChainStore.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKKeyChainStore.h"

@implementation InAppSDKKeyChainStore

+ (NSData *) getSecureDataForKey:(NSString*)key
{
    // Retrieve a value from the keychain
    CFTypeRef attributes;
    
    NSArray *keys = [[NSArray alloc] initWithObjects:(__bridge NSString *)kSecClass,
                     (__bridge NSString *)kSecAttrAccount,
                     (__bridge NSString *)kSecReturnAttributes,
                     (__bridge id)kSecAttrAccessible,
                     nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:(__bridge NSString *)kSecClassGenericPassword,
                        key,
                        kCFBooleanTrue,
                        (__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                        nil];
    NSDictionary *query = [[NSDictionary alloc] initWithObjects:objects
                                                        forKeys:keys];
    
    // Check if the value exist
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                          (CFTypeRef *) &attributes);
    NSData *data = nil;
    if (status == errSecSuccess)
    {
        NSDictionary *result = (__bridge_transfer NSDictionary*)attributes;
        // Value was found
        data = (NSData *)[result objectForKey:(__bridge NSString *)kSecAttrGeneric];
    }
    return data;
}

+ (BOOL) storeSecureData:(NSData*)data forKey:(NSString*)key
{
    OSStatus status = noErr;
    // Get the existing value for the key
    NSData *existingValue = [self getSecureDataForKey:key];
    
    // Check if a value already exists for this key
    if (existingValue != nil)
    {
        // Value already exists, so update it
        NSArray *keys = [[NSArray alloc] initWithObjects:(__bridge NSString *)kSecClass,
                         (__bridge NSString *) kSecAttrAccount,
                         (__bridge id)kSecAttrAccessible,
                         nil];
        NSArray *objects = [[NSArray alloc] initWithObjects:(__bridge NSString *)kSecClassGenericPassword,
                            key,
                            (__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                            nil];
        NSDictionary *query = [[NSDictionary alloc] initWithObjects:objects
                                                            forKeys:keys];
        status = SecItemUpdate((__bridge CFDictionaryRef) query,
                               (__bridge CFDictionaryRef) [NSDictionary dictionaryWithObject:data
                                                                                      forKey:(__bridge NSString *)kSecAttrGeneric]);
    }
    else
    {
        // Value does not exist, so add it
        NSArray *keys = [[NSArray alloc] initWithObjects:(__bridge NSString *)kSecClass,
                         (__bridge NSString *)kSecAttrAccount,
                         (__bridge NSString *)kSecAttrGeneric,
                         (__bridge id)kSecAttrAccessible,
                         nil];
        NSArray *objects = [[NSArray alloc] initWithObjects:(__bridge NSString *)kSecClassGenericPassword,
                            key,
                            data,
                            (__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                            nil];
        NSDictionary *query = [[NSDictionary alloc] initWithObjects:objects
                                                            forKeys:keys];
        status = SecItemAdd((__bridge CFDictionaryRef) query, NULL);
    }
    
    // Check if the value was stored
    return (status == errSecSuccess);
}

+ (void) deleteKeychainValue:(NSString *)key
{
    NSData *existingValue = [self getSecureDataForKey:key];
    
    if (existingValue != nil)
    {
        NSArray *keys = [[NSArray alloc] initWithObjects:(__bridge NSString *)kSecClass,
                         (__bridge NSString *) kSecAttrAccount,
                         (__bridge id)kSecAttrAccessible,
                         nil];
        NSArray *objects = [[NSArray alloc] initWithObjects:(__bridge NSString *)kSecClassGenericPassword,
                            key,
                            (__bridge id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                            nil];
        NSDictionary *query = [[NSDictionary alloc] initWithObjects:objects
                                                            forKeys:keys];
        
        SecItemDelete((__bridge CFDictionaryRef)query);
    }
}


@end
