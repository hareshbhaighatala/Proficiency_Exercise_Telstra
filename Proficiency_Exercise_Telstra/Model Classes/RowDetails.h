//
//  RowDetails.h
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RowDetails : NSObject

@property (strong, nonatomic) NSString *strTitleText;
@property (strong, nonatomic) NSString *strDescriptionText;
@property (strong, nonatomic) NSString *strImageUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
