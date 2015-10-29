//
//  InAppSDKSoapStructure.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//


@interface InAppSDKSoapStructure : NSObject

/*! Creates SOAP element with defined \c paramName and \c paramValue
 @param paramName Element's name. \c paramName must not be nil. Any white spaces will be removed.
 @param paramValue Element's value. \c paramValue must not be nil in this method. Any white spaces will be removed.
 @return @see InAppSDKSoapStructure object or \c nil if
 */
+ (InAppSDKSoapStructure *) createElementWithName:(NSString *)paramName
                                     withValue:(NSString *)paramValue;

/*! Creates SOAP element with defined \c paramName and \c paramValue and \c paramNamespace
 It allows to add namespace for this specific SOAP node
 @param paramName Element's name. \c paramName must not be nil. Any white spaces will be removed.
 @param paramValue element's value. \c paramValue must not be nil in this method. Any white spaces will be removed.
 @param paramNamespace element's namespace. \c paramNamespace must not be nil in this method. Any white spaces will be removed.
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createElementWithName:(NSString *)paramName
                                     withValue:(NSString *)paramValue
                                 withNamespace:(NSString *)paramNamespace;

/*! Creates SOAP element with defined \c paramName
 @param paramName Element's name. \c paramName must not be nil. Any white spaces are removed.
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createElementWithName:(NSString *)paramName;

/*! Creates SOAP element with defined \c paramName and \c paramNamespace
 It allows to add namespace for this specific SOAP node
 @param paramName element's name. \c paramName must not be nil. Any white spaces are removed.
 @param paramNamespace element's namespace. \c paramNamespace must not be nil in this method. Any white spaces will be removed.
 @return @see InAppSDKSoapStructure object
 */
+ (InAppSDKSoapStructure *) createElementWithName:(NSString *)paramName
                                 withNamespace:(NSString *)paramNamespace;

/*! Adds \c aChild element into the SOAP structure
 @param paramChild Element's child
 */
- (void) addChild:(InAppSDKSoapStructure *)paramChild;

/*! Adds \c aParameter element into a SOAP structure
 @param paramValue Element's parameter
 */
- (void) addParameter:(InAppSDKSoapStructure *)paramValue;

/*! Generates XML structure
 @return XML SOAP structure as @see NSString
 */
- (NSString *) generateSoapXmlStructure;

/*! Generates NVP XML structure
 @return NVP XML SOAP structure as @see NSString
 */
- (NSString *) generateNVPSoapXmlStructure;


@end
