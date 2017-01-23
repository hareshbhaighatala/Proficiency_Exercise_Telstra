//
//  FactDetails.h
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RowDetails.h"

@interface FactDetails : NSObject

@property (strong, nonatomic) NSString *strScreenTitle;
@property (strong, nonatomic) NSArray *arrFactRows;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
