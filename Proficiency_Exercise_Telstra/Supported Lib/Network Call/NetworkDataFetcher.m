//
//  NetworkDataFetcher.m
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "NetworkDataFetcher.h"

#define NE_FectsUrl @"https://dl.dropboxusercontent.com/u/746330/facts.json"

@implementation NetworkDataFetcher

+ (void)fetchDataRowFromServerWithCompletion:(NDF_CompletionBlock)completionBlock
{
    // Represent a URL load request
    NSURL *URL = [NSURL URLWithString:NE_FectsUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    // Creates a session with the specified session configuration.
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            completionBlock(nil, error);
        }
        else {
            // NSISOLatin1StringEncoding gives the well result for character code of "ö"
            NSString *isoEncoding = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
            // Encoding can the bytes of the NSData be interpreted as a valid string
            NSData *utfEncoding = [isoEncoding dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:utfEncoding options:NSJSONReadingMutableContainers error:&error];
            
            completionBlock(jsonDict, error);
        }
    }];
    
    [dataTask resume];
}

@end
