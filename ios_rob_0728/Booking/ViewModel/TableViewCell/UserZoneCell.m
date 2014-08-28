//
//  UserZoneCell.m
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UserZoneCell.h"

@implementation UserZoneCell

@synthesize iconImg;
@synthesize backgroundImg;
@synthesize textLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 62)];
//        [backgroundImg setImage:[[UIImage imageNamed:@"con_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 5, 10, 5)]];
//        [self addSubview:backgroundImg];
        
        iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 40, 40)];
        [self addSubview:iconImg];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 60)];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        [textLabel setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:textLabel];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
