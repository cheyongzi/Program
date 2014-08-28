//
//  TypeButton.m
//  Booking
//
//  Created by jinchenxin on 14-6-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "TypeButton.h"
#import "ConUtils.h"
#import "ConstantField.h"

@implementation TypeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTypeButton];
    }
    return self;
}

-(void) setTypeButton{
//    [self setBackgroundImage:[UIImage imageNamed:@"con_link"] forState:UIControlStateNormal];
//    [self setBackgroundImage:[UIImage imageNamed:@"con_hover"] forState:UIControlStateSelected];
//    self.backgroundColor = [UIColor redColor];
    [self setTitleColor:COMM_GRARY_COLOR forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.titleLabel.font = [UIFont systemFontOfSize:11];
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
