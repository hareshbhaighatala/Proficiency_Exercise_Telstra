//
//  DataRowTableViewCell.m
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "DataRowTableViewCell.h"

@implementation DataRowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initCellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView setFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 100)];
        
        // Initialization code
        [self setupThumbImageView];
        [self setupTitleTextLable];
        [self setupDescriptionTextLable];
        
        // Setting UI Autolayout Constraints
        [self setupCellUIConstraints];
    }
    
    return self;
}

- (void)setupThumbImageView
{
    self.imgvThumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
    self.imgvThumb.frame = CGRectMake(10, 5, 110, 90);
    self.imgvThumb.clipsToBounds = YES;
    [self.imgvThumb setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.contentView addSubview:self.imgvThumb];
}

- (void)setupTitleTextLable
{
    self.lblTitleText = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 235, 21)];
    self.lblTitleText.textAlignment = NSTextAlignmentLeft;
    self.lblTitleText.font = [UIFont boldSystemFontOfSize:17.0f];
    self.lblDescriptionText.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblTitleText.textColor = [UIColor colorWithRed:0.0f green:128.0/255.0f blue:128.0/255.0f alpha:1.0f];
    self.lblTitleText.numberOfLines = 0;
    
    [self.contentView addSubview:self.lblTitleText];
}

- (void)setupDescriptionTextLable
{
    self.lblDescriptionText = [[UILabel alloc] initWithFrame:CGRectMake(130, 31, 235, 21)];
    self.lblDescriptionText.textAlignment = NSTextAlignmentJustified;
    self.lblDescriptionText.font = [UIFont systemFontOfSize:14.0f];
    self.lblDescriptionText.lineBreakMode = NSLineBreakByWordWrapping;
    self.lblDescriptionText.numberOfLines = 0;
    
    [self.contentView addSubview:self.lblDescriptionText];
}

- (void)setupCellUIConstraints
{
    [self.imgvThumb removeConstraints:self.imgvThumb.constraints];
    [self.lblTitleText removeConstraints:self.lblTitleText.constraints];
    [self.lblDescriptionText removeConstraints:self.lblDescriptionText.constraints];
    [self.contentView removeConstraints:self.contentView.constraints];
    
    [self.imgvThumb setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lblTitleText setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.lblDescriptionText setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Width constraint of self.imgvThumb
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imgvThumb(==110)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb)]];
    
    // Height constraint of self.imgvThumb
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imgvThumb(==90)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb)]];
    
    // Align self.imgvThumb, self.lblTitleText from the left/right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_imgvThumb]-10-[_lblTitleText]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb, _lblTitleText)]];
    
    // Align self.imgvThumb from the top
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_imgvThumb]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb)]];
    
    // Align self.lblDescriptionText from the left/right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imgvThumb]-10-[_lblDescriptionText]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb, _lblDescriptionText)]];
    
    // Align self.lblTitleText, self.lblDescriptionText from the top/bottom
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_lblTitleText]-5-[_lblDescriptionText]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblTitleText, _lblDescriptionText)]];
}


@end
