//
//  InAppSDKSettingsPrivate.h
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#ifndef InAppSDK_InAppSDKSettingsPrivate_h
#define InAppSDK_InAppSDKSettingsPrivate_h

#import "InAppSDKSettings.h"
/**
 * CYBS END POINTS
 *
 */
typedef enum CYBSEndPoints
{
    CYBS_AUTH_API_EP,
    CYBS_REQUEST_API_EP,
    CYBS_SEARCH_API_EP,
    CYBS_HELP_API_EP,
    CYBS_FORGET_PASSWORD_API_EP,
    
} CYBS_END_POINTS;

@interface InAppSDKSettings(Pirvate)

-(NSString *) getURLfor:(CYBS_END_POINTS)endPointType;

@end


#endif
