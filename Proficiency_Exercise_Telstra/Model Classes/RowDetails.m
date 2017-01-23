//
//  RowDetails.m
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "RowDetails.h"

@implementation RowDetails

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if(![self setPropertiesWithDictionary:dictionary]) {
            self = nil;
        }
    }
    return self;
}

- (BOOL)setPropertiesWithDictionary:(NSDictionary *)dictionary {
    
    // This check was added to detect Null
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    // Setting default values
    self.strTitleText = @"";
    self.strDescriptionText = @"";
    self.strImageUrl = @"";
    
    // Setting values from Dictionary
    if ([dictionary valueForKey:@"title"] != [NSNull null] &&
        [dictionary valueForKey:@"title"] != nil) {
        self.strTitleText = [dictionary valueForKey:@"title"];
    }
    
    if ([dictionary valueForKey:@"description"] != [NSNull null] &&
        [dictionary valueForKey:@"description"] != nil) {
        self.strDescriptionText = [dictionary valueForKey:@"description"];
    }
    
    if ([dictionary valueForKey:@"imageHref"] != [NSNull null] &&
        [dictionary valueForKey:@"imageHref"] != nil) {
        self.strImageUrl = [dictionary valueForKey:@"imageHref"];
    }
    
    return YES;
}

@end
