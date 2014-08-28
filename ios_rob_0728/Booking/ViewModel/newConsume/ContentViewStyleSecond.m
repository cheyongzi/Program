//
//  ContentViewStyleSecond.m
//  RobClientSecond
//
//  Created by 1 on 13-7-19.
//  Copyright (c) 2013年 cheyongzi. All rights reserved.
//

#import "ContentViewStyleSecond.h"

@implementation ContentViewStyleSecond

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
          withTitle:(NSString *)titleStr
    withSecondTitle:(NSString *)secondStr
          withImage:(NSString*)imageStr
{
    if (self = [super initWithFrame:frame]) {
        [self.backgroundImg setImage:[UIImage imageNamed:imageStr]];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, frame.size.width, 20)];
        self.titleLab.text = titleStr;
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self.titleLab setFont:[UIFont systemFontOfSize:15]];
        [self.titleLab setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.titleLab];
        
        self.secondTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, frame.size.width, 15)];
        self.secondTitleLab.text = secondStr;
        self.secondTitleLab.textAlignment = NSTextAlignmentCenter;
        [self.secondTitleLab setFont:[UIFont systemFontOfSize:12]];
        [self.secondTitleLab setBackgroundColor:[UIColor clearColor]];
        self.secondTitleLab.textColor = [UIColor lightGrayColor];
        [self addSubview:self.secondTitleLab];
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
