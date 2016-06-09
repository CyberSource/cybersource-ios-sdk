//
//  InAppSDKEncryptedPaymentValidator.h
//  InAppSDK
//
//  Created by Erik Krietsch and Angela Dyrda on 6/9/16.
//

#import <Foundation/Foundation.h>

@interface InAppSDKEncryptedPaymentValidator : NSObject

+ (BOOL) isValidEncryptedPaymentData: (InAppSDKEncryptedPaymentData*) encryptedPaymentData;

@end
