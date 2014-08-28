//
//  SexSelectButton.m
//  Booking
//
//  Created by 1 on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "SexSelectButton.h"

@implementation SexSelectButton
@synthesize iconImg;
@synthesize titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withIconImg:(NSString *)iconName withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame])
    {
        iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 10, 10)];
        [iconImg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:iconName]]];
        [self addSubview:iconImg];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 20, 20)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:title];
        [self addSubview:titleLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
