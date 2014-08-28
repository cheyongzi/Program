//
//  TextFiledBackgroundView.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "TextFiledBackgroundView.h"
#import "ConstantField.h"

@implementation TextFiledBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withColor:(UIColor*)color withImage:(NSArray *)imageArr
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [backgroundImg setUserInteractionEnabled:YES];
        [backgroundImg setBackgroundColor:[UIColor clearColor]];
        [backgroundImg setImage:[[UIImage imageNamed:@"con_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 5, 10, 5)]];
        [self addSubview:backgroundImg];
        
        int count = [imageArr count];
        for (int i = 0; i< count-1; i++) {
            UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(50, 40*(i+1), 249, 1)];
            [seperateLine setBackgroundColor:LOAD_SEPERATE_COLOR];
            [self addSubview:seperateLine];
        }
        
        for (int j=0; j<count; j++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10+40*j, 22.5, 22.5)];
            [img setImage:[UIImage imageNamed:[imageArr objectAtIndex:j]]];
            [self addSubview:img];
        }
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
