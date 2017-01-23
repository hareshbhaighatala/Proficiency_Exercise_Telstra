//
//  NetworkDataFetcher.h
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NDF_CompletionBlock)(NSDictionary *response, NSError *error);


@interface NetworkDataFetcher : NSObject

+ (void)fetchDataRowFromServerWithCompletion:(NDF_CompletionBlock)completionBlock;

@end
