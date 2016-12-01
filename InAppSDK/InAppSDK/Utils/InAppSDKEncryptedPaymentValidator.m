//
//  InAppSDKEncryptedPaymentValidator.m
//  InAppSDK
//
//  Created by Erik Krietsch and Angela Dyrda on 6/9/16.
//

#import "InAppSDKEncryptedPaymentValidator.h"
#import "InAppSDKEncryptedPaymentData.h"

@implementation InAppSDKEncryptedPaymentValidator

+ (BOOL) isValidEncryptedPaymentData: (InAppSDKEncryptedPaymentData*) encryptedPaymentData {
  if (!encryptedPaymentData) { return NO; }
  return (
            [encryptedPaymentData.data length] > 0 &&
            [encryptedPaymentData.descriptor length] > 0 &&
            [encryptedPaymentData.encoding length] > 0
          );
}

@end
