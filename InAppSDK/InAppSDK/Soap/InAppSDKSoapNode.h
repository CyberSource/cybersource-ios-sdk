//
//  InAppSDKSoapNode.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//


@class InAppSDKSoapStructure;
@class InAppSDKCardData;
@class InAppSDKTransactionObject;
@class InAppSDKEncryptedPaymentData;


@interface InAppSDKSoapNode : NSObject

#pragma mark - CyberSource main nodes -

/*! Creates a structure for the Envelope SOAP node
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createEnvelope;

/*! Creates a structure for the Header SOAP node
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createHeader;


+ (InAppSDKSoapStructure *) createApplePayPaymentSolution;
/*! Creates a structure for the Body SOAP node.
 It includes \c paramRequestMessage in the body tha was created.
 \param paramRequestMessage the request message as @see InAppSDKSoapStructure object
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createBodyWithRequestMessage:(InAppSDKSoapStructure *)paramRequestMessage;

#pragma mark - CyberSource common node

/*! Creates a structure for the \c card SOAP node.
 It uses data from \c paramCard object of @see InAppSDKCardData
 \param paramCard the card. It must not be nil. \c paramCard.cardType needs to be defined as one of \c InAppSDKCardData described in @see InAppSDKCardData
 @return @see InAppSDKSoapStructure object or \c nil if the parameter does not meet the requirements.
 */
+ (InAppSDKSoapStructure *) createCardWithCard:(InAppSDKCardData*)paramCard;

/*! Creates a structure for the \c encryptedPayment SOAP node.
 It uses data from \c payment object of @see InAppSDKEncryptedPaymentData
 \param payment the payment object. It must not be nil.
 @return @see InAppSDKSoapStructure object or \c nil if the parameter does not meet the requirements.
 */
+ (InAppSDKSoapStructure *) createEncryptedPaymentWithPayment:(InAppSDKEncryptedPaymentData*) payment;


#pragma mark - CyberSource security nodes -

/*! Creates a structure for \c security SOAP node
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createSecurity;

/*! Creates a structure for the \c usernameToken SOAP node
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createUsernameToken;

/*! Creates a structure for the \c Password SOAP node
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createPasswordWithPasswordType: (NSString*)passwordType withPassword:(NSString *) paramPassword;

#pragma mark - CyberSource Api specific -

/*! Creates a structure for the \c capture SOAP node.
 It uses data from \c paramTransaction object of @see InAppSDKTransactionObject
 \param paramTransaction The transaction object. It must not be nil. The following fields are required and must not be nil:
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createEncryptPaymentDataServiceRequestMessageWithTransaction:(InAppSDKTransactionObject *)paramTransaction;

/*! Creates a structure for the \c capture SOAP node.
 It uses data from \c paramTransaction object of @see InAppSDKTransactionObject
 \param paramTransaction The transaction object. It must not be nil. The following fields are required and must not be nil:
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createApplePayAuthorizationServiceRequestMessageWithTransaction:(InAppSDKTransactionObject *)paramTransaction;

@end
