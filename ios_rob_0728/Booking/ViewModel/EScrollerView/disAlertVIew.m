//
//  disAlertVIew.m
//  360
//
//  Created by fengchuan on 13-9-25.
//  Copyright (c) 2013年 Wang Dean. All rights reserved.
//

#import "disAlertVIew.h"

@implementation disAlertVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews{
    for (UIView *v in self.subviews) {
        NSLog(@"%f  %f   %f   %f",v.frame.origin.x,v.frame.origin.y,v.frame.size.width,v.frame.size.height);
        v.alpha = 0.0;
    }
    NSLog(@"self%f  self%f   self%f   self%f",self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
//    self.backgroundColor = [UIColor clearColor];
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
