//
//  InAppSDKEncryptedPaymentData.m
//  InAppSDK
//
//  Created by Erik Krietsch and Angela Dyrda on 6/8/16.
//

#import "InAppSDKEncryptedPaymentData.h"

@implementation InAppSDKEncryptedPaymentData

- (id) init
{
  self = [super init];

  if (self)
  {
    _data = nil;
    _descriptor = @"RklEPUNPTU1PTi5BUFBMRS5JTkFQUC5QQVlNRU5U";
    _encoding = @"Base64";
  }

  return self;
}

- (id) copyWithZone:(NSZone *)zone
{
  InAppSDKEncryptedPaymentData *copiedKeyedInEncryptedPaymentData = [[InAppSDKEncryptedPaymentData alloc] init];


  if (self.data)
  {
    copiedKeyedInEncryptedPaymentData.data = self.data;
  }

  if (self.descriptor)
  {
    copiedKeyedInEncryptedPaymentData.descriptor = self.descriptor;
  }

  if (self.encoding)
  {
    copiedKeyedInEncryptedPaymentData.encoding = self.encoding;
  }

  return copiedKeyedInEncryptedPaymentData;
}

@end
