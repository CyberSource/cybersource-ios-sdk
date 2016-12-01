//
//  InAppSDKEncryptedPaymentData.h
//  InAppSDK
//
//  Created by Erik Krietsch and Angela Dyrda on 6/8/16.
//

@interface InAppSDKEncryptedPaymentData : NSObject

//! An encrypted payment's data.
/*! Obtain the encrypted payment data from the `paymentData` property of the `PKPaymentToken` object.
 */
@property (nonatomic, copy) NSString *data;
//! An encrypted payment's descriptor.
/*! Format of the encrypted payment data. The value for Apple Pay is `RklEPUNPTU1PTi5BUFBMRS5JTkFQUC5QQVlNRU5U`.
*/
@property (nonatomic, copy) NSString *descriptor;
//! An encrypted payment's encoding.
/*! Encoding method used to encrypt the payment data. The value for Apple Pay is `Base64`.
 */
@property (nonatomic, copy) NSString *encoding;

@end
