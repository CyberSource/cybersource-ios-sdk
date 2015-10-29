//
//  InAppSDKSignatureGenerator.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/22/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InAppSDKSignatureGenerator : NSObject

//-------WARNING!----------------
// This part of the code that generates the Signature is present here only to show as the sample.
// Signature generation should be done at the Merchant Server.

-(NSString*) generateSignatureWithMerchantId: (NSString *) merchantId
                        transactionSecretKey: (NSString *) transactionSecretKey
                       merchantReferenceCode: (NSString *) merchantReferenceCode;
@end
