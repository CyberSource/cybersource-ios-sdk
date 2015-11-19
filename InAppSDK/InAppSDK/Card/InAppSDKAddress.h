//
//  InAppSDKAddress.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 11/18/15.
//  Copyright © 2015 CyberSource, a Visa Company. All rights reserved.
//

#import <AddressBook/ABRecord.h>

@interface InAppSDKAddress : NSObject <NSCopying>

//! First name
@property (nonatomic, copy) NSString *firstName;
//! Last name
@property (nonatomic, copy) NSString *lastName;
//! Postal code
@property (nonatomic, copy) NSString *postalCode;

@end
