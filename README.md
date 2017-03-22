# CyberSource iOS SDK

This SDK provides simple functionality to dispatch sensitive credit card data directly to CyberSource, returning a safe payment token that can be passed up to your mobile backend for standard CyberSource processing without the burden of credit card data ever hitting your server.  With this secure payment token your server can create a CyberSource subscription, long term token or payment.

**_NOTE: this SDK is not intended for ApplePay transactions but rather is complimentary to the Apple Passkit SDK.  The payment data blobs from this SDK and the Apple Passkit SDK can be treated just the same for CyberSource payment processing._**

## SDK Installation 

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

## Sample Application
We have a sample application which demonstrates the SDK usage:  
   https://github.com/CyberSource/cybersource-ios-samples
  
## Using the Payment Blob
Once you have the secure payment blob from our SDK you can post that up to your mobile backend/payment server (without incurring any additional PCI burden) and make a standard CyberSource API call.  For example, to authorize that card:  
  
````xml
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <soapenv:Header>
    <wsse:Security soapenv:mustUnderstand="1" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
      <wsse:UsernameToken>
        <wsse:Username>test_paymentech_001</wsse:Username>
        <wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wssusername-token-profile-1.0#PasswordText">POgqicGXdrqafap/7WzT/KcYVzuN/aW4u1cuRKawBvOg==</wsse:Password>
      </wsse:UsernameToken>
    </wsse:Security>
  </soapenv:Header>
  <soapenv:Body>
    <nvpRequest xmlns="urn:schemas-cybersource-com:transaction-data-1.121">
ccAuthService_run=true
merchantID=test_paymentech_001
merchantReferenceCode=23AEE8CB6B62EE2AF07
encryptedPayment_data=eyJkYXRhIjoiN2kxTUxjWEIxRXZoMjk2emRJdnFyY1hZXC93SG9zRE9jbXdVRE1PRG5tdk9xWXJZWXlpTXhmRzc0bTRWbndTblwvN1FEdjlYUm9kZHNxalc4aXpoTVA4cXpDOG5HVkhMa3ZES2ZVYVNqWnB3WURKS2JaYk5JNklVcE1QUjlPWmJ2NFJ5VE5tbUprcmlVU25JbFwvbVRobWprbkh1eXpwc3FFRzdVR21wcXNkOHczaG50ZStvaUpSU2pBbmtraTI1T2hmUFlqTU9CUE9BaHNFMUsxM0Npc3dNWTA4dEN5K1V3VEhuakY5MThyTFVkXC9jMnpKTW9BOEFjN042SHFPQklWa2plUVwvd25rOGkyeGNcL3lubE51bTlMMlR5RGRnRE42SHNYWjNRb3V6Z053cTZyTGFSYjU5WGpMSlVXUmRDcU5namtFTjZlUkE0Mk94NElubDlQc0RKblRpbzZ4SDVcLyIsImhlYWRlciI6eyJhcHBsaWNhdGlvbkRhdGEiOiI0Nzc1Njk2NDNEMzczMDM4MzI2MzM5MzEzNjJENjI2MjY0NjMyRDM0MzY2NTY1MkQzODM0MzEzMDJENjM2NDM1MzEzNDMxMzQzNTMzNjUzNjM1M0I0NDYxNzQ2NTU0Njk2RDY1M0QzMjMwMzEzNTJEMzEzMjJEMzEzNDU0MzIzMDNBMzMzMTNBMzAzNTJFMzEzMjMzMzAzOTMwMzI1QSIsImVwaGVtZXJhbFB1YmxpY0tleSI6Ik1Ga3dFd1lIS29aSXpqMENBUVlJS29aSXpqMERBUWNEUWdBRU80V2prRzFLYXlpbmhlRGY5QXFtRVJCeHRxMHdiaFBmS25qcUNCZ0w4RWw4NU45c3JBWVdhaEE1d29iaHFTQ0VQazc5Q0xKNGhRVXU1bENIem43ZVdBPT0iLCJwdWJsaWNLZXlIYXNoIjoieXRLSjgwc3JjWXppQnVwNzRcL0R5K3RTV1FQSENwXC9ZbkFabGhcL3lXOFk3ND0iLCJ0cmFuc2FjdGlvbklkIjoiNDUwMTI1MDYyMDA3NTAwMDAwMTUxOSJ9LCJzaWduYXR1cmVBbGdJbmZvIjoiU0hBMjU2Iiwic2lnbmF0dXJlIjoiWitjbWg4UXNzNUdQMzUrOEEzTkZOcUNNRThFbVBqb0xiKzRqUWpIVDdGMD0iLCJ2ZXJzaW9uIjoiMS4xLjEuMiJ9
paymentSolution=004
billTo_firstName=Brian
billTo_lastName=McManus
billTo_city=Bellevue
billTo_country=US
billTo_email=bmc@mail.com
billTo_state=WA
billTo_street1=213 yiui St
billTo_postalCode=98103
purchaseTotals_currency=USD
purchaseTotals_grandTotalAmount=200.23
    </nvpRequest>
  </soapenv:Body>
</soapenv:Envelope>

````

**_NOTE: You could also make an ics_create_subscription call to create a permanent card-on-file payment token, simply replace the card data fields with the encryptedPayment_data field, and don't forget to set paymentSolution to 004._**

# Apple In-App Purchase API  
  
Please remember that you are required to use Apple’s In-App Purchase API to sell virtual goods such as premium content for your app, and subscriptions for digital content. Specifically, Apple’s developer terms require that the In-App Purchase API must be used for digital “content, functionality, or services” such as premium features or credits. See https://developer.apple.com/app-store/review/guidelines/ for more details.

