//
//  ContentViewStyleOne.m
//  RobClientSecond
//
//  Created by 1 on 13-7-19.
//  Copyright (c) 2013年 cheyongzi. All rights reserved.
//

#import "ContentViewStyleOne.h"

@implementation ContentViewStyleOne

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)titleStr withImage:(NSString*)imageStr
{
    if (self = [super initWithFrame:frame]) {
        [self.backgroundImg setImage:[UIImage imageNamed:imageStr]];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.titleLab.text = titleStr;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self.titleLab setFont:[UIFont systemFontOfSize:15]];
        [self.titleLab setBackgroundColor:[UIColor clearColor]];
        [self.titleLab setTextColor:[UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1]];
        [self addSubview:self.titleLab];
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
