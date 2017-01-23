//
//  DataRowTableViewCell.h
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowDetails.h"

@interface DataRowTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *lblTitleText;
@property (strong, nonatomic) UILabel *lblDescriptionText;
@property (strong, nonatomic) UIImageView *imgvThumb;

- (id)initCellWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValuesToCell:(RowDetails *)rowData;
- (CGFloat)getHeightOfCell;

@end
