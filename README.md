# CyberSource iOS SDK

##SDK Installation 

### CocoaPods
````
     pod 'cybersource-ios-sdk'  
````  

### Manual Installation

Include the ```InAppSDK.framework``` in to the application. Select Target, In Embedded Binaries, press the plus (+)
and select the framework.

Once included, make sure in “Build Settings” tab, in section “Search Paths” the path to these frameworks are added correctly. 

##SDK Usage 
After including the frameworks and the path now try to include the following framework headers in the application.
```objc
#import <InAppSDK/InAppSDK.h>
```

```objc
-(void) performPaymentDataEncryption
{
 BOOL result = NO;
 
//Initialize the InAppSDK for CYBS Gateway Environtment.
[InAppSDKSettings sharedInstance].inAppSDKEnvironment = INAPPSDK_ENV_TEST;

//Initialize the transaction object which collects all the required information for the encrypt service.
//Refer: InAppSDKTransactionObject.h
InAppSDKTransactionObject * transactionObject = [[InAppSDKTransactionObject alloc] init];

//Set First Name, Last Name and Postal Code. These are optional Values, not mandatory.
//Refer: InAppSDKAddress.h
transactionObject.billTo = [self getBillToData];
    
//Get and Set the Merchant specific credentials [merchantID, Signature, merchant Reference code etc.] 
//Refer: InAppSDKMerchant.h
transactionObject.merchant = [self getMerchantData];

//Get and Set the Card specific details[ cardNumber, expirationMonth, expirationYear and cvNumber.] 
//Refer: InAppSDKCardData.h
transactionObject.cardData = [self getTestCardData];

//Initialize the InAppSDK Gateway and call performPaymentDataEncryption and implement the Delegate.
InAppSDKGateway * gateway = [InAppSDKGateway sharedInstance]; 
result = [gatway performPaymentDataEncryption:transactionObject withDelegate:self];
    
if (result)
{
  NSLog(@"Request is Accepted. Expect the response in the delegate method.");
}
else
{
  NSLog(@"Request is NOT Accepted. Verify the input values if any one is invalid.");
}
}



//Delegate. Refer InAppSDKGatewayProtocol.h
- (void) encryptPaymentDataServiceFinishedWithGatewayResponse:(InAppSDKGatewayResponse *)paramResponseData withError:(InAppSDKError *)paramError
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

    NSLog(@"%@", statusMsg);
  } 
}

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

-(InAppSDKMerchant*) getMerchantData 
{
  InAppSDKMerchant *merchantData = [[InAppSDKMerchant alloc] init];
  merchantData.userName = kInAppTestUserName;
  merchantData.merchantID = kInAppTestMerchantID; 
  merchantData.merchantReferenceCode = kInAppTestMerchantReferenceNumber;
  
  //-------WARNING!----------------
  // This part of the code that generates the Signature is present here only to show as a sample. 
  // Signature generation must be done and obtained from the Merchant Server.
  
  InAppSDKSignatureGenerator * signatureGenerator = [[InAppSDKSignatureGenerator alloc] init]; 
  NSString * signature = [signatureGenerator generateSignatureWithMerchantId:kInAppTestMerchantID
                                                        transactionSecretKey:kInAppTestTransactionSecretKey
                                                       merchantReferenceCode:kInAppTestMerchantReferenceNumber ];
  NSLog(@"Signature:%@", signature);
  merchantData.passwordDigest = signature;
  return merchantData; 
}
```

##Sample Application
We have a sample application which demonstrates the SDK usage:  
   https://github.com/CyberSource/cybersource-ios-samples
   
  
##Apple In-App Purchase API  
Please remember that you are required to use Apple’s In-App Purchase API to sell virtual goods such as premium content for your app, and subscriptions for digital content. Specifically, Apple’s developer terms require that the In-App Purchase API must be used for digital “content, functionality, or services” such as premium features or credits. See https://developer.apple.com/app-store/review/guidelines/ for more details.
