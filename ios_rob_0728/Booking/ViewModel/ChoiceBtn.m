//
//  ChoiceBtn.m
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ChoiceBtn.h"

@implementation ChoiceBtn

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

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        
        iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        [iconImg setBackgroundColor:[UIColor clearColor]];
        [iconImg setImage:[UIImage imageNamed:@"protocal.png"]];
        [self addSubview:iconImg];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 40, 20)];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
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
