//
//  InAppSDKTransactionObject.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

@class InAppSDKCardData;
@class InAppSDKMerchant;
@class InAppSDKAddress;

//!Representation of transaction type
typedef enum
{
    INAPPSDK_TRANSACTION_UNDEFINED = 0,/*!< Can be used for atomic operation */
    INAPPSDK_TRANSACTION_ENCRYPT,      /*!< Payment */
    
} InAppSDKTransactionType;


@interface InAppSDKTransactionObject : NSObject

//! Contains information about the merchant, @see InAppSDKMerchant
@property (atomic, strong) InAppSDKMerchant *merchant;

//! Contains information about the card used in making transaction, @see InAppSDKCardData
@property (atomic, strong) InAppSDKCardData *cardData;

//! Contains information about the customer address where the bill should be sent, @see InAppSDKAddress
@property (atomic, strong) InAppSDKAddress *billTo;

//! Contains transaction type, @see InAppSDKTransactionType
@property (atomic) InAppSDKTransactionType transactionType;

@end

