//
//  UserInfoCell.m
//  Booking
//
//  Created by 1 on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UserInfoCell.h"
@implementation UserInfoCell
@synthesize titleLabel;
@synthesize textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.frame];
        [backgroundView setBackgroundColor:[UIColor clearColor]];
        [backgroundView setImage:[[UIImage imageNamed:@"con_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 5, 10, 5)]];
        [self setBackgroundView:backgroundView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 40, 20)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:titleLabel];
        
        UIImageView *textBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(60, 10, 150, 40)];
        [textBackImg setBackgroundColor:[UIColor clearColor]];
        [textBackImg setImage:[[UIImage imageNamed:@"con_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 5, 10, 5)]];
        [textBackImg setUserInteractionEnabled:YES];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        [textBackImg addSubview:textField];
        [self addSubview:textBackImg];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
