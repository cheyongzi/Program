//
//  AccountInfoChangeCell.m
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AccountInfoChangeCell.h"
#import "ConstantField.h"

@implementation AccountInfoChangeCell

@synthesize iconImg;
@synthesize titleLabel;
@synthesize contentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 21, 26)];
        [iconImg setBackgroundColor:[UIColor clearColor]];
        [self addSubview:iconImg];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 80, 30)];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setTextColor:TITLE_LABEL_COLOR];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:titleLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 160, 30)];
        [contentLabel setTextAlignment:NSTextAlignmentCenter];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:contentLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
