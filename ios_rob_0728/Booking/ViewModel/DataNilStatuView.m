//
//  DataNilStatuView.m
//  Booking
//
//  Created by 1 on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "DataNilStatuView.h"
#import "ConstantField.h"

@implementation DataNilStatuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImage:(UIImage*)image
{
    if (self = [super initWithFrame:frame])
    {
        
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 60, 60)];
        [self.img setImage:image];
        [self addSubview:self.img];
        
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 100, 20)];
        self.infoLabel.text = title;
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        self.infoLabel.textColor = INFO_TEXT_COLOR;
        [self.infoLabel setBackgroundColor:[UIColor clearColor]];
        [self.infoLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:self.infoLabel];
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
