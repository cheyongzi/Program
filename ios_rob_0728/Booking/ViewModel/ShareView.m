//
//  ShareView.m
//  Booking
//
//  Created by 1 on 14-6-27.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ShareView.h"
#import "ConstantField.h"

#define BUTTON_TAG 1000

@implementation ShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGSize appSize = [[UIScreen mainScreen] applicationFrame].size;
        
        array = [NSArray arrayWithObjects:@"qqZone.png",@"qqFriend.png",@"wxZone.png",@"wx.png",@"sinaWb.png",@"qqWb.png", nil];
        textArray = [NSArray arrayWithObjects:@"QQ空间",@"QQ好友",@"朋友圈",@"微信好友",@"新浪微博",@"腾讯微博", nil];
        
        img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, appSize.width, appSize.height)];
        [img setBackgroundColor:ALERT_BACKGROUND_COLOR];
        [img setAlpha:0.6];
        [img setUserInteractionEnabled:YES];
        [self addSubview:img];
        
        img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, appSize.height-304, appSize.width, 260)];
        [img2 setBackgroundColor:USER_SHARE_BACK];
        [img2 setUserInteractionEnabled:YES];
        [self addSubview:img2];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, appSize.width-20, 1)];
        [label setBackgroundColor:LOAD_SEPERATE_COLOR];
        [img2 addSubview:label];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setFrame:CGRectMake(0, 200, appSize.width, 60)];
        [cancelBtn setBackgroundColor:[UIColor clearColor]];
        [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [img2 addSubview:cancelBtn];

    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

- (void)cancelBtnClicked:(id)sender
{
    [self removeFromSuperview];
}

- (void)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag - BUTTON_TAG == 0)
    {
        [[ShareApi shareInstance] sendQQZoneMessage];
    }
    else if (btn.tag - BUTTON_TAG == 1)
    {
        [[ShareApi shareInstance] sendQQFriendMessage];
    }
    else if (btn.tag - BUTTON_TAG == 2)
    {
        [[ShareApi shareInstance] sendWXZoneMessage];
    }
    else if (btn.tag - BUTTON_TAG == 3)
    {
        [[ShareApi shareInstance] sendWxFrienMessage];
    }
    else if (btn.tag - BUTTON_TAG == 4)
    {
        [[ShareApi shareInstance] sendSinaMessage];
    }
    else if (btn.tag - BUTTON_TAG == 5)
    {
        [[ShareApi shareInstance] sendWBMessage];
    }
}

- (void)initContentView
{
    for (int i = 0 ; i<[array count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(20+100*(i%3), (i/3)*100, 80, 80)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = BUTTON_TAG + i;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 50, 50)];
        [imgView setBackgroundColor:[UIColor clearColor]];
        [imgView setImage:[UIImage imageNamed:[array objectAtIndex:i]]];
        [button addSubview:imgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 20)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:[textArray objectAtIndex:i]];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [button addSubview:titleLabel];
        [img2 addSubview:button];
    }
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
