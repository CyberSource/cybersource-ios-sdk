//
//  InAppSDKConnection.m
//  InAppSDK
//
//  Created by Senthil Kumar Periyasamy on 10/14/15.
//  Copyright (c) 2015 CyberSource, a Visa Company. All rights reserved.
//

#import "InAppSDKConnection.h"
#import "InAppSDKRequestInfo.h"
#import "InAppSDKHttpConnectionError.h"
#import "InAppSDKSettings.h"

@interface InAppSDKConnection()

@property (atomic, strong) NSMutableArray * requestsQueueArray;
@property (atomic, strong) InAppSDKRequestInfo * currentlyProcessedRequest;

@property (nonatomic, assign) NSInteger responseStatusCode;
@property (nonatomic, assign) float responseDataExpectedSize;
@property (nonatomic, strong) NSMutableData * responseData;

@end

const int kInAppSDKResponseStatusCodeOk = 200;

@implementation InAppSDKConnection

#pragma mark - Singleton -

+ (InAppSDKConnection *) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _requestsQueueArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Communication Manager -

- (void) makeRequest:(InAppSDKRequestInfo *)aRequestInfo
{
    [self.requestsQueueArray addObject:aRequestInfo];
    [self processWaitingRequests];
}

- (void) processWaitingRequests
{
    
    if (self.currentlyProcessedRequest != nil)
    {
        return;
    }
    if ([self.requestsQueueArray count] == 0)
    {
        return;
    }
    
    self.currentlyProcessedRequest = [self.requestsQueueArray objectAtIndex:0];
    
    // Reset previously received data
    self.responseData = [NSMutableData data];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    
    self.currentlyProcessedRequest.connection = [[NSURLConnection alloc] initWithRequest:self.currentlyProcessedRequest.request
                                                                                delegate:self];
    
    if (!self.currentlyProcessedRequest.connection)
    {
        if (self.currentlyProcessedRequest.delegate)
        {
            [self.currentlyProcessedRequest.delegate requestWithId:self.currentlyProcessedRequest.requestType
                                                  finishedWithData:nil
                                                         withError:nil];
        }
        
        self.currentlyProcessedRequest = nil;
        [self processWaitingRequests];
    }
}


#pragma mark - NSURLConnection -

- (void) connection:(NSURLConnection*)connection didReceiveResponse:(NSHTTPURLResponse*)response
{
    self.responseStatusCode = [response statusCode];
    if (self.responseStatusCode == kInAppSDKResponseStatusCodeOk)
    {
        self.responseDataExpectedSize = [response expectedContentLength];
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
    if ([InAppSDKSettings sharedInstance].enableLog)
    {
        
        NSLog(@"\nRESPONSE DATA:\n%@", [[NSString alloc] initWithData:data
                                                      encoding:NSUTF8StringEncoding]);
    }
 }

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    // since Cybersource respond 'not found' with empty body
    // request will be resend until following conditions are met
    BOOL repeatRequest = (self.currentlyProcessedRequest.repeatUntilSuccess) &&
    ([self.responseData length] == 0) &&
    (self.responseStatusCode == INAPPSDK_HTTP_ERROR_TYPE_NOT_FOUND);
    if (repeatRequest == NO) {
        [self.requestsQueueArray removeObjectAtIndex:0];
    }
    if ([self.currentlyProcessedRequest.connection isEqual:connection])
    {
        if (self.currentlyProcessedRequest.delegate)
        {
            [self.currentlyProcessedRequest.delegate requestWithId:self.currentlyProcessedRequest.requestType
                                                  finishedWithData:self.responseData
                                                         withError:[InAppSDKHttpConnectionError errorWithCode:self.responseStatusCode]];
        }
        self.currentlyProcessedRequest = nil;
        [connection cancel];
        [self processWaitingRequests];
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.requestsQueueArray removeObjectAtIndex:0];
    if ([self.currentlyProcessedRequest.connection isEqual:connection])
    {
        if (self.currentlyProcessedRequest.delegate)
        {
            [self.currentlyProcessedRequest.delegate requestWithId:self.currentlyProcessedRequest.requestType
                                                  finishedWithData:nil
                                                         withError:[InAppSDKHttpConnectionError errorWithCode:error.code]];
        }
        self.currentlyProcessedRequest = nil;
        [connection cancel];
        [self processWaitingRequests];
    }
}

- (NSCachedURLResponse *) connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}

- (BOOL) connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace*)space
{
    return [[space authenticationMethod] isEqualToString: NSURLAuthenticationMethodServerTrust];
}

- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSURL *originalUrl = connection.originalRequest.URL;
    NSString *filename = [originalUrl.host stringByReplacingOccurrencesOfString:@"." withString:[NSString string]];
    NSURLProtectionSpace *  protectionSpace = [challenge protectionSpace];
    
    if ([protectionSpace.authenticationMethod isEqualToString: NSURLAuthenticationMethodServerTrust])
    {
        do {
            SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
            if (nil == serverTrust)
            {
                break; /* failed */
            }
            
            // Validate against system trust
            SecTrustResultType trustResult;
            OSStatus status = SecTrustEvaluate(serverTrust, &trustResult);
            BOOL trusted = errSecSuccess == status && (trustResult == kSecTrustResultProceed || trustResult == kSecTrustResultUnspecified);
            
            // Perform special case certificate validation if not systemm trusted
            if (!trusted)
            {
                // Must have a corresponding certificate file in resource
                NSString *file = [[NSBundle bundleForClass:[InAppSDKConnection class]] pathForResource:filename ofType:@"der"];
                NSData *certFromFile = nil;
                if (file)
                {
                    certFromFile = [NSData dataWithContentsOfFile:file];
                }
                if (nil == certFromFile)
                {
                    break; /* failed */
                }
                
                // Get server certifiate data
                SecCertificateRef serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0);
                CFDataRef serverCertificateData = nil;
                if (serverCertificate)
                {
                    serverCertificateData = SecCertificateCopyData(serverCertificate);
                }
                if (nil == serverCertificateData)
                {
                    break; /* failed */
                }
                
                // Put certificate data in NSData
                const UInt8 *const data = CFDataGetBytePtr(serverCertificateData);
                const CFIndex size = CFDataGetLength(serverCertificateData);
                NSData *certFromUrl = [NSData dataWithBytes:data length:(NSUInteger)size];
                CFRelease(serverCertificateData);
                if (nil == certFromUrl)
                {
                    break; /* failed */
                }
                
                // Validate certificate data
                if (![certFromFile isEqualToData:certFromUrl])
                {
                    break; /* failed */
                }
            }
            // The only good exit point
            return [[challenge sender] useCredential: [NSURLCredential credentialForTrust:serverTrust]
                          forAuthenticationChallenge: challenge];
        } while(0);
        
    }
    // Refuse connection
    return [[challenge sender] cancelAuthenticationChallenge: challenge];
}

@end
