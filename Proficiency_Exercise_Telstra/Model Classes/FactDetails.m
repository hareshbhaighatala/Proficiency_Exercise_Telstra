//
//  FactDetails.m
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "FactDetails.h"

@implementation FactDetails

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
    
    // This check was added to detect NSNull
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    if ([dictionary valueForKey:@"title"] != [NSNull null] &&
        [dictionary valueForKey:@"title"] != nil) {
        self.strScreenTitle = [dictionary valueForKey:@"title"];
    }
    else {
        self.strScreenTitle = @"Please Wait...";
    }
    
    if ([[dictionary valueForKey:@"rows"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in [dictionary valueForKey:@"rows"]) {
            RowDetails *row = [[RowDetails alloc] initWithDictionary:dic];
            [arrTemp addObject:row];
        }
        
        self.arrFactRows = [[NSArray alloc] initWithArray:(NSArray*)arrTemp];
    }
    
    return YES;
}

@end
