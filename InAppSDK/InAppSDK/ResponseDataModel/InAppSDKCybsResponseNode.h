//
//  InAppSDKCybsResponseNode.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/15/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

//! Value of "decision" node with positive response
/*! The request succeeded.
 */
static NSString * const kCybsResponseNodeAccept = @"ACCEPT";
//! Value of "decision" node with error response
/*! There was a system error. Errors that are caused by system problems are usually unrelated to the content of the request itself. You must design your transaction management system to correctly handle CyberSource system errors.
 Depending on which payment processor is handling the transaction, the error could indicate a valid CyberSource system error or it could indicate a processor rejection because of invalid data. CyberSource recommends that you do not design your system to endlessly retry sending a transaction in the case of a system error.
 Use the value of the reasonCode field to determine the reason for the ERROR decision. For more information about handling system errors and retries, see the documentation for your client.
 */
static NSString * const kCybsResponseNodeError = @"ERROR";
//! Value of "decision" node with negative response
/*! One or more of the service requests was declined. Requests can be rejected by CyberSource, the payment processor, or the issuing bank. For example:
 * CyberSource rejects a request if required data is missing or invalid.
 * The issuing bank rejects a request if the card limit is reached and
 funds are not available.
 This value can also be returned when an authorization transaction for a debit card or prepaid card is partially approved. See the information about debit cards and prepaid cards in Credit Card Services Using the Simple Order API.
 Use the value of the reasonCode field value to determine the reason for the REJECT decision
 */
static NSString * const kCybsResponseNodeReject = @"REJECT";
//! Value of "decision" node with review response.
/*! Decision Manager flagged the order for review.
 */
static NSString * const kCybsResponseNodeReview = @"REVIEW";

//! CyberSource parser of the XML node.
/*! It is a base class for the XML node specific parser
*/

@interface InAppSDKCybsResponseNode : NSObject

//! The name of the node that is currently being parsed.
@property (nonatomic, strong) NSString * currentNodeName;
//! The parent node for \c startingNodeName
@property (nonatomic, weak) InAppSDKCybsResponseNode * parentNode;
//! The name of the node that which is represented by this class
@property (nonatomic, strong) NSString * startingNodeName;

//! Node Parser initialisation method
/*!
 \param aParentNode Its parent node
 \return Object of @see InAppSDKCybsResponseNode class
 */
- (id) initWithParentNode:(InAppSDKCybsResponseNode *)aParentNode;

//! Enables the node that is currently being parsed to be updated.
/*!
 \param aParentNode Its parent node
 \return Object of @see InAppSDKCybsResponseNode class
 */
- (void) updateWithValue:(NSString *)aValue;

//! Provides an object of @see InAppSDKCybsResponseNode represents the node provided in the parameter \c aNode
/*! It should be called for the starting node.
 \param aNode Nod name to be considered
 \param aPreviousNode parent node object
 \return Object of @see InAppSDKCybsResponseNode class
 */
- (InAppSDKCybsResponseNode *) startingNode:(NSString *)aNode previousNode:(InAppSDKCybsResponseNode *)aPreviousNode;

//! Provides an object of @see InAppSDKCybsResponseNode that represents node provided in the parameter \c aNode
/*! It should be called for the ending node
 \param aNode Nod name to be considered
 \param aPreviousNode parent node object
 \return Object of @see InAppSDKCybsResponseNode class
 */
- (InAppSDKCybsResponseNode *) endingNode:(NSString *)aNode previousNode:(InAppSDKCybsResponseNode *)aPreviousNode;

@end
