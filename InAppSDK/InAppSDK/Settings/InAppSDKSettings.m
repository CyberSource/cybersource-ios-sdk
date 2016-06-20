//
//  InAppSDKSettings.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKSettings.h"
#import "InAppSDKSettingsPrivate.h"
#import "InAppSDKKeyChainStore.h"

static NSString * const kInAppSDKSettingsKey = @"InAppSDKSettingsKey";

@implementation InAppSDKSettings
{
    NSString * preferredURL;
}

+ (InAppSDKSettings *) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        NSData *settingsData = [InAppSDKKeyChainStore getSecureDataForKey:kInAppSDKSettingsKey];
        if (settingsData != nil)
        {
            _sharedObject = [NSKeyedUnarchiver unarchiveObjectWithData:settingsData];
        }
        if (_sharedObject == nil)
        {
            _sharedObject = [[InAppSDKSettings alloc] init];
        }
    });
    return _sharedObject;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _inAppSDKEnvironment = INAPPSDK_ENV_TEST;
        preferredURL = nil;
        _timeOut = 110;
        _enableLog = FALSE;
        
    }
    return self;
}

-(void)setServerURL:(NSString *) serverURL
{
    if (serverURL != nil)
    {
        preferredURL = serverURL;
    }
}

- (BOOL) saveSettings
{
    // The following NSData object may be stored in the Keychain
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    if (data == nil)
    {
        return NO;
    }
    return [InAppSDKKeyChainStore storeSecureData:data forKey:kInAppSDKSettingsKey];
}

+ (void) removeSettings
{
    // remove data from keychain
    [InAppSDKKeyChainStore deleteKeychainValue:kInAppSDKSettingsKey];
}



- (id) initWithCoder:(NSCoder *)paramDecoder
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)paramEncoder
{
    
}

-(NSString *)getURLfor:(CYBS_END_POINTS)endPointType
{
    NSString * returnURL = nil;
    
    if ([preferredURL length])
    {
        return returnURL = preferredURL;
    }
    else
    {
        if(_inAppSDKEnvironment == INAPPSDK_ENV_LIVE)
        {
            switch (endPointType)
            {
                case CYBS_AUTH_API_EP:
                    returnURL = @"https://auth.ic3.com/apiauth/v1/oauth/";
                    break;
                case CYBS_SEARCH_API_EP:
                    returnURL = @"https://mobile.ic3.com/payment";
                    break;
                case CYBS_CARD_REQUEST_API_EP:
                    returnURL = @"https://mobile.ic3.com/mpos/transactionProcessor/";
                    break;
                case CYBS_HELP_API_EP:
                    returnURL = @"https://www.authorize.net/support/iosuserguide.pdf";
                    break;
                case CYBS_FORGET_PASSWORD_API_EP:
                    returnURL = @"https://ebc.cybersource.com/ebc/login/ForgotPassword.do";
                    break;
                case CYBS_APPLE_PAY_REQUEST_API_EP:
                  returnURL = @"https://ics2wsa.ic3.com/commerce/1.x/transactionProcessor";
                default:
                    break;
            }
            
        }
        else if( _inAppSDKEnvironment == INAPPSDK_ENV_TEST)
        {
            switch (endPointType)
            {
                case CYBS_AUTH_API_EP:
                    returnURL = @"https://authtest.ic3.com/apiauth/v1/oauth/";
                    break;
                case CYBS_SEARCH_API_EP:
                    returnURL = @"https://mobiletest.ic3.com/payment";
                    break;
                case CYBS_CARD_REQUEST_API_EP:
                    returnURL = @"https://mobiletest.ic3.com/mpos/transactionProcessor/";
                    break;
                case CYBS_HELP_API_EP:
                    returnURL = @"https://www.authorize.net/support/iosuserguide.pdf";
                    break;
                case CYBS_FORGET_PASSWORD_API_EP:
                    returnURL = @"https://ebc.cybersource.com/ebc/login/ForgotPassword.do";
                    break;
                case CYBS_APPLE_PAY_REQUEST_API_EP:
                    returnURL = @"https://ics2wstesta.ic3.com/commerce/1.x/transactionProcessor";
                default:
                    break;
            }
        }
    }
    
    return returnURL;
}


@end
