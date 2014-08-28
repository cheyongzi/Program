//
//  GuideView.m
//  Booking
//
//  Created by 1 on 14-8-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "GuideView.h"
#import "ConstantField.h"

@implementation GuideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTag:(GuideTag)tag
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
        [img setBackgroundColor:ALERT_BACKGROUND_COLOR];
        [img setAlpha:0.8];
        [img setUserInteractionEnabled:YES];
        [self addSubview:img];
        
        guide = tag;
        
        switch (tag) {
            case HOME_GUIDE:
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-152, self.frame.size.width, 225)];
                imageView.image = [UIImage imageNamed:@"guide_img_one"];
                break;
            case PRICE_GUIDE:
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-75, self.frame.size.width, 75)];
                imageView.image = [UIImage imageNamed:@"guide_img_two"];
                break;
            case USERZONE_GUIDE:
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-240, self.frame.size.width, 240)];
                imageView.image = [UIImage imageNamed:@"guide_img_three"];
                break;
                
            default:
                break;
        }
        [self addSubview:imageView];
        
        UIButton *guideBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-45, imageView.frame.origin.y+imageView.frame.size.height+20, 90, 37)];
        [guideBtn setBackgroundImage:[UIImage imageNamed:@"guide_btn_icon"] forState:UIControlStateNormal];
        [guideBtn addTarget:self action:@selector(guideBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:guideBtn];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch (guide) {
        case HOME_GUIDE:
            [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"HOMEGUIDE"];
            break;
        case USERZONE_GUIDE:
            [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"USERZONEGUIDE"];
            break;
        case PRICE_GUIDE:
            [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"PRICEGUIDE"];
            break;
            
        default:
            break;
    }
    [self removeFromSuperview];
}

- (void)guideBtnAction:(id)sender
{
    switch (guide) {
        case HOME_GUIDE:
            [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"HOMEGUIDE"];
            break;
        case USERZONE_GUIDE:
            [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"USERZONEGUIDE"];
            break;
        case PRICE_GUIDE:
            [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:@"PRICEGUIDE"];
            break;
        default:
            break;
    }
    [self removeFromSuperview];
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
