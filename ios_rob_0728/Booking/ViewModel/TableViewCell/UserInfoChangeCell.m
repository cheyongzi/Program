//
//  UserInfoChangeCell.m
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UserInfoChangeCell.h"
#import "ConstantField.h"

@implementation UserInfoChangeCell
@synthesize titleLabel;
@synthesize contentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:TITLE_LABEL_COLOR];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:titleLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 30)];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        [contentLabel setTextAlignment:NSTextAlignmentCenter];
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
