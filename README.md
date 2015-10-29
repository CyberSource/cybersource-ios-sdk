# cybersource-ios-sdk
This is a private repo for the CyberSource InApp SDK, it will be moved under CyberSource when it goes public

Integrating CyberSource InAppSDK for iOS Applications. 
------------------------------------------------------

Developer needs to include the InAppSDK.framework in to the application.


Once included, make sure in “Build Settings” tab, in section “Search Paths” the path to these frameworks are added correctly. 

After including the frameworks and the path now try to include the following framework headers in the application.

#import <InAppSDK/InAppSDK.h>

Now the App can do the following to access the API.

//Initialize the InAppSDK for CYBS Gateway Environtment.
[InAppSDKSettings sharedInstance].cybsEnvironment = ENV_TEST;

//Initialize the transaction object which collects all the required information for the encrypt service.
InAppSDKTransactionObject * transactionObject = [[InAppSDKTransactionObject alloc] init];

//Get and Set the Merchant specific credentials [merchantID, Finger Print, merchant Reference code etc.]  Refer: InAppSDKMerchant.h
transactionObject.merchant = [self getMerchantData];

//Get and Set the Card specific details[ cardNumber, expirationMonth, expirationYear and cvNumber.] Refer: InAppSDKCardData.h
transactionObject.cardData = [self getTestCardData];

//Initialize the InAppSDK Gateway and call performPaymentDataEncryption and implement the Delegate..
InAppSDKGateway * gateway = [InAppSDKGateway sharedInstance];
[gateway performPaymentDataEncryption:transactionObject withDelegate:self];




//Delegate, Refer InAppSDKGatewayProtocol.h
-(void) encryptPaymentDataServiceFinishedWithGatewayResponse:(InAppSDKGatewayResponse *)paramResponseData withError:(InAppSDKError *)paramError
{
if(paramError != nil || paramResponseData != nil)
{
NSMutableString* statusMsg = [NSMutableString new];

if (paramResponseData)
{
[statusMsg appendString: @"\n Encrypt Payment Data Service Response:"];
[statusMsg appendFormat: @"\n  * Accepted: %@", paramResponseData.isAccepted ? @"Yes" : @"No"];
}

// paramResponseData.encryptedPayment.data should give the encrypted payment blob.
NSLog(@"%@", statusMsg);
}
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
// Signature generation must be done at the Merchant Server.

InAppSDKSignatureGenerator * signatureGenerator = [[InAppSDKSignatureGenerator alloc] init];

NSString * signature = [signatureGenerator generateSignatureWithMerchantId:kInAppTestMerchantID
transactionSecretKey:kInAppTestTransactionSecretKey
merchantReferenceCode:kInAppTestMerchantReferenceNumber ];

NSLog(@"Signature:%@", signature);

merchantData.passwordDigest = signature;

return merchantData;
}