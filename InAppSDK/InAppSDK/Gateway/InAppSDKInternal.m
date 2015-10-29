//
//  InAppSDKInternal.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/16/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKInternal.h"

@implementation InAppSDKInternal

#pragma mark - Singleton -

__strong static InAppSDKInternal * _sharedInstance = nil;

+ (InAppSDKInternal *)sharedInstance
{
    static dispatch_once_t predicate = 0;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[InAppSDKInternal alloc] init];
    });
    
    return _sharedInstance;
}

+ (id) alloc
{
    @synchronized ([InAppSDKInternal class])
    {
        if (_sharedInstance == nil)
        {
            _sharedInstance = [super alloc];
            return _sharedInstance;
        }
    }
    return nil;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        _merchantId = nil;
        _password = nil;
        _userName = nil;
    }
    return self;
}

- (void) resetInternal
{
    self.userName = nil;
    self.password = nil;
    self.merchantId = nil;
}


- (NSString *)userName
{
    return _userName;
}

- (NSString *)password
{
    return _password;
}

- (NSString *)merchantId
{
    return _merchantId;
}

@end
