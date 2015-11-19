//
//  InAppSDKTests.m
//  InAppSDKTests
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "InAppSDKGateway.h"
#import "InAppSDKTransactionObject.h"
#import "InAppSDKMerchant.h"
#import "InAppSDKCardData.h"
#import "InAppSDKGatewayResponse.h"
#import "InAppSDKSettings.h"
#import "InAppSDKGatewayError.h"
#import "InAppSDKSignatureGenerator.h"
#import "InAppSDKAddress.h"

//Credentials

static NSString* kInAppTestMerchantID = @"cybs_lg_sa_merchant";

static NSString* kInAppTestTransactionSecretKey = @"HQAE00u9hQCocLGqDKCBuiZ5WkaI26GEtGWvFyNuJuxYztZ42DKkVkaccxziYrt2087JfCYhbfDU4ek09qJFX1lwrnOtGtMgq08SiUn35aNeXb5kwVU+c+6ZfPs+z4/M66j2fbJJ9toU6AplkkPmeVfEq9X0I0Vn/87NvyFS9iHLMOUMB+l/axa7xanLhx9LXh4USXklRV1zZHgowHD0NaXcYgvl+3pxJVSggFN3y0o8K7ktEMY3hT/poZvASEiUL5q2rYnuFDRVsqphe1BiZ8GsmCB1rDauCtquxad6hzPqBxeTIXl4qJ3mrllSN/5IgdiATmKAVRaYYmr9wvWvUA==";

static NSString* kInAppTestMerchantReferenceNumber = @"InAppSDK_iOSUnitTests_12345";


//CYBS Local ENV Credentials.

static NSString* kCYBSLocalENVMerchantID = @"mpos_paymentech";
static NSString* kCYBSLocalENVUserName = @"mpos_paymentech";

static NSString* kCYBSLocalENVTransactionSecretKey = @"XuPPGtXb8eq7Gi0SB57QfYRG9UO672uzI+i6goHaHte1tUxAbpn6pNExgNMKo6Nis8f3JjzqH70EQCEuSwMkTjqOkNkSiDJJhYJjye1MbHYTJm0HGjj2EZqrM0RqFSdwQ1w8/sMMqo4deFVxlwp/vG74ky89U0N3dl2r4ljcliliJ6PGVFgUveBZ6sqHdWXGOUJSS57ugNzwcSlL9A87uC/FXdK7B0ZE89MXEp3VR5g87rci1O1VaiNazlOdltFY0g27FOM40SAqf8gOTtEFVnuz510wMhOyaKBi0S211N8KN0cDPOMe7dmrW1tP+F5zZuQuoMZqJ4a+jSLJKUmWug==";

@interface InAppSDKTests : XCTestCase <InAppSDKGatewayDelegate>

@property (nonatomic, strong) InAppSDKTransactionObject* transactionObject;

@property XCTestExpectation *didPaymentDataEncryptionSucceededExpectation;

@end

@implementation InAppSDKTests

-(InAppSDKAddress *) getBillToData
{
    InAppSDKAddress * billToInfo = [[InAppSDKAddress alloc] init];
    billToInfo.firstName = @"TestFirstName";
    billToInfo.lastName = @"TestLastName";
    billToInfo.postalCode = @"98004";
    
    return billToInfo;
}

-(InAppSDKCardData*) getTestCardData
{
    InAppSDKCardData* testCardData = [[InAppSDKCardData alloc] init];
    
    testCardData.accountNumber = @"4111111111111111";
    testCardData.expirationMonth = @"12";
    testCardData.expirationYear = @"2018";
    [testCardData setCvNumber:@"123"];
    
    return testCardData;
}

-(InAppSDKCardData*) getInValidCardData
{
    InAppSDKCardData* testCardData = [[InAppSDKCardData alloc] init];
    
    testCardData.accountNumber = @"41111111111";
    testCardData.expirationMonth = @"12";
    testCardData.expirationYear = @"2018";
    [testCardData setCvNumber:@"123"];
    
    return testCardData;
}

-(InAppSDKMerchant*) getMerchantData
{
    InAppSDKMerchant *merchantData = [[InAppSDKMerchant alloc] init];
    
    merchantData.merchantID = kInAppTestMerchantID;
    merchantData.merchantReferenceCode = kInAppTestMerchantReferenceNumber;
    
    //-------WARNING!----------------
    // This part of the code that generates the Signature is present here only to show as the sample.
    // Signature generation should be done at the Merchant Server.
    
    InAppSDKSignatureGenerator * signatureGenerator = [[InAppSDKSignatureGenerator alloc] init];
    
    NSString * signature = [signatureGenerator generateSignatureWithMerchantId:kInAppTestMerchantID
                                                        transactionSecretKey:kInAppTestTransactionSecretKey
                                                       merchantReferenceCode:kInAppTestMerchantReferenceNumber ];
    
    NSLog(@"Signature:%@", signature);
    
    merchantData.passwordDigest = signature;
    
    return merchantData;
}

-(InAppSDKMerchant*) getLocalENVMerchantData
{
    InAppSDKMerchant *merchantData = [[InAppSDKMerchant alloc] init];
    
    merchantData.userName = kCYBSLocalENVUserName;
    merchantData.merchantID = kCYBSLocalENVMerchantID;
    merchantData.merchantReferenceCode = kInAppTestMerchantReferenceNumber;
    
    InAppSDKSignatureGenerator * signatureGenerator = [[InAppSDKSignatureGenerator alloc] init];
    
    NSString * signature = [signatureGenerator generateSignatureWithMerchantId:kCYBSLocalENVMerchantID
                                                        transactionSecretKey:kCYBSLocalENVTransactionSecretKey
                                                       merchantReferenceCode:kInAppTestMerchantReferenceNumber];
    
    NSLog(@"Signature:%@", signature);
    
    merchantData.passwordDigest = signature;
    
    return merchantData;
}

- (void)testGenerateSignatureWithLocalENVCredentials
{
    InAppSDKSignatureGenerator * signatureGenerator = [[InAppSDKSignatureGenerator alloc] init];
    
    NSString * signature = [signatureGenerator generateSignatureWithMerchantId:kCYBSLocalENVMerchantID
                                                        transactionSecretKey:kCYBSLocalENVTransactionSecretKey
                                                       merchantReferenceCode:kInAppTestMerchantReferenceNumber];
    
    NSLog(@"FingerPrint:%@", signature);

}

- (void)testPerformPaymentDataEncryption
{
    BOOL result = NO;
    
    //Basic Request and Response logging to be enabled or disabled. Default Disabled.
    [InAppSDKSettings sharedInstance].enableLog = FALSE;
    
    //Setting the connection Timeout. Default 110.
    [InAppSDKSettings sharedInstance].timeOut = 45.0;
    
    //Initialize the InAppSDK for CYBS Gateway Environtment.
    [InAppSDKSettings sharedInstance].inAppSDKEnvironment = INAPPSDK_ENV_TEST;
    
    //Intialize the transaction object which collects all the required information for the encryt service.
    InAppSDKTransactionObject * transactionObject = [[InAppSDKTransactionObject alloc] init];
    
    //Set First Name, Last Name and Postal Code. These are optional Values, not mandatory.
    transactionObject.billTo = [self getBillToData];
    
    //Set the Merchant specific credentails. Refer getMerchantData
    transactionObject.merchant = [self getMerchantData];
    
    //Set the Card specific details. Refer getKeyedInTestCardData
    transactionObject.cardData = [self getTestCardData];
    
    self.didPaymentDataEncryptionSucceededExpectation = [self expectationWithDescription:@"Encrypt Payment Data"];
    
    InAppSDKGateway * gateway = [InAppSDKGateway sharedInstance];

    // If the result is success, the request is accepted. Failure means some input values may be not a valid ones.
    result = [gateway performPaymentDataEncryption:transactionObject withDelegate:self];

    //NSLog(@"Result = %d", result);
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testPerformPaymentDataEncryptionWithInvalidCardData
{
    BOOL result = NO;
    
    //Initialize the InAppSDK for CYBS Gateway Environtment.
    [InAppSDKSettings sharedInstance].inAppSDKEnvironment = INAPPSDK_ENV_TEST;
    
    //Intialize the transaction object which collects all the required information for the encryt service.
    InAppSDKTransactionObject * transactionObject = [[InAppSDKTransactionObject alloc] init];
    
    //Set the Merchant specific credentails. Refer getMerchantData
    transactionObject.merchant = [self getMerchantData];
    
    //Set the Card specific details. Refer getKeyedInTestCardData
    transactionObject.cardData = [self getInValidCardData];
    
    self.didPaymentDataEncryptionSucceededExpectation = [self expectationWithDescription:@"Encrypt Payment Data"];
    
    InAppSDKGateway * gateway = [InAppSDKGateway sharedInstance];
    
    result = [gateway performPaymentDataEncryption:transactionObject withDelegate:self];
    
    NSLog(@"Result = %d", result);
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testPerformPaymentDataEncryptionforLocalENV
{
    //Initialize the InAppSDK for CYBS Gateway Environtment.
    [InAppSDKSettings sharedInstance].inAppSDKEnvironment = INAPPSDK_ENV_TEST;
    
    //Intialize the transaction object which collects all the required information for the encryt service.
    InAppSDKTransactionObject * transactionObject = [[InAppSDKTransactionObject alloc] init];
    
    //Set the Merchant specific credentails. Refer getMerchantData
    transactionObject.merchant = [self getLocalENVMerchantData];
    
    //Set the Card specific details. Refer getKeyedInTestCardData
    transactionObject.cardData = [self getTestCardData];
    
    self.didPaymentDataEncryptionSucceededExpectation = [self expectationWithDescription:@"Encrypt Payment Data"];
    
    InAppSDKGateway * gateway = [InAppSDKGateway sharedInstance];
    
    [gateway performPaymentDataEncryption:transactionObject withDelegate:self];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}


#pragma InAppSDKGateway delegate

-(void) encryptPaymentDataServiceFinishedWithGatewayResponse:(InAppSDKGatewayResponse *)paramResponseData withError:(InAppSDKError *)paramError
{
    if(paramError != nil || paramResponseData != nil)
    {
        NSMutableString* statusMsg = [NSMutableString new];
        
        if (paramResponseData)
        {
            [statusMsg appendString:@"\nEncrypt Payment Data Service Response:"];
            [statusMsg appendFormat:@"\nAccepted: %@", paramResponseData.isAccepted ? @"Yes" : @"No"];
            [statusMsg appendFormat:@"\nRequestID %@", paramResponseData.requestId];
            [statusMsg appendFormat:@"\nResultCode %@", paramResponseData.resultCode];
            [statusMsg appendFormat:@"\nEncrypted Payment Data:%@", paramResponseData.encryptedPayment.data];
        }
        if (paramError)
        {
            [statusMsg appendFormat:@"\nError: %@", paramError.localizedDescription];
        }
        
        if(paramResponseData.isAccepted)
        {
            [self.didPaymentDataEncryptionSucceededExpectation fulfill];
            
        }
        
        NSLog(@"%@", statusMsg);
   }
}

@end
