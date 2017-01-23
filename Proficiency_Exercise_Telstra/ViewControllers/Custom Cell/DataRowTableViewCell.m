//
//  DataRowTableViewCell.m
//  Proficiency_Exercise_Telstra
//
//  Created by Haresh on 23/01/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "DataRowTableViewCell.h"

@implementation DataRowTableViewCell

#pragma mark - Lifecycle & Init Methods

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initCellWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        // Initialization code
        [self setupThumbImageView];
        [self setupTitleTextLable];
        [self setupDescriptionTextLable];
        
        // Setting UI Autolayout Constraints
        [self setupCellUIConstraints];
    }
    
    return self;
}

#pragma mark - Custom inintlization methods

- (void)setupThumbImageView
{
    self.imgvThumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
    self.imgvThumb.frame = CGRectMake(13, 8, 104, 84);
    self.imgvThumb.clipsToBounds = YES;
    [self.imgvThumb setContentMode:UIViewContentModeScaleAspectFill];
    self.imgvThumb.layer.borderColor = [[UIColor colorWithRed:0.0f green:128.0/255.0f blue:128.0/255.0f alpha:1.0f] CGColor];
    self.imgvThumb.layer.borderWidth = 3.0f;
    self.imgvThumb.layer.cornerRadius = 8.0f;
    
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
    self.lblDescriptionText.lineBreakMode = NSLineBreakByCharWrapping;
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
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imgvThumb(==104)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb)]];
    
    // Height constraint of self.imgvThumb
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imgvThumb(==84)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb)]];
    
    // Align self.imgvThumb, self.lblTitleText from the left/right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-13-[_imgvThumb]-13-[_lblTitleText]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb, _lblTitleText)]];
    
    // Align self.imgvThumb from the top
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_imgvThumb]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb)]];
    
    // Align self.lblDescriptionText from the left/right
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imgvThumb]-13-[_lblDescriptionText]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgvThumb, _lblDescriptionText)]];
    
    // Align self.lblTitleText, self.lblDescriptionText from the top/bottom
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_lblTitleText]-5-[_lblDescriptionText]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblTitleText, _lblDescriptionText)]];
}

#pragma mark - Property Assignmnet Method

- (void)setValuesToCell:(RowDetails *)rowData
{
    self.lblTitleText.text = rowData.strTitleText;
    self.lblDescriptionText.text = rowData.strDescriptionText;
    
    [self lazyLoadImageWithURLString:rowData.strImageUrl];
}

- (void)lazyLoadImageWithURLString:(NSString *)strImgURL
{
    self.imgvThumb.image = [UIImage imageNamed:@"placeholder"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:strImgURL]
                                                         completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                             if (data) {
                                                                 UIImage *image = [UIImage imageWithData:data];
                                                                 if (image) {
                                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                                         self.imgvThumb.image = image;
                                                                     });
                                                                 }
                                                             }
                                                         }];
    [task resume];
}

#pragma mark - Calculating Cell Height

float const minCellHeight = 100.0f;

- (CGFloat)getHeightOfCell
{
    float width = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 140; //self.lblTitleText.frame.size.width
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:self.lblTitleText.text attributes:@{NSFontAttributeName:self.lblTitleText.font}];
    CGRect rectTitle = [attributedTitle boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                     context:nil];
    //self.lblDescriptionText.frame.size.width
    NSAttributedString *attributedDesc = [[NSAttributedString alloc] initWithString:self.lblDescriptionText.text attributes:@{NSFontAttributeName:self.lblDescriptionText.font}];
    CGRect rectDesc = [attributedDesc boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
    
    // Calculating the height of cell based on its content.
    float height = ceil(rectTitle.size.height) + ceil(rectDesc.size.height) + 15.0f; //15 is margin from top & bottom
    
    return (height < minCellHeight) ? minCellHeight : height;
}


@end
