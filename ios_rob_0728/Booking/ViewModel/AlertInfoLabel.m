//
//  AlertInfoLabel.m
//  Booking
//
//  Created by 1 on 14-6-25.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AlertInfoLabel.h"

@implementation AlertInfoLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString*)title withSuperView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        [self setFont:[UIFont systemFontOfSize:14]];
        [self setTextColor:[UIColor redColor]];
        [self setText:title];
        [view addSubview:self];
        
        [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^(void)
         {
             [self setAlpha:0];
         }completion:^(BOOL finished)
         {
             [self removeFromSuperview];
         }];
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
