//
//  UserCenterMainViewController.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UserZoneMainViewController.h"
#import "SharedUserDefault.h"
#import "UserInfoEditViewController.h"
#import "ShareView.h"
#import "UserMessageViewController.h"
#import "OrderCenterViewController.h"
#import "GuideView.h"

#define BUTTON_TAG 1000

@interface UserZoneMainViewController ()
{
    GuideView *guideView;
}
@end

@implementation UserZoneMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的微歌";
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoChangeNotification:) name:@"USERINFOCHANGENOTIFICATION" object:nil];
    
    buttonNorImgArr = [NSArray arrayWithObjects:@"userAccount.png",@"userScore.png",@"userOrder.png", nil];
    buttonTitleArr  = [NSArray arrayWithObjects:@"我的账户",@"我的积分",@"我的订单", nil];
    //初始化页面上部信息
    [self initHeadUserInfo];
    
    [self initContentView];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(214, 165, 96, 35)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"userShare.png"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"shareImg.png"] forState:UIControlStateNormal];
    [shareBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [shareBtn setTitle:@"邀请注册" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"USERZONEGUIDE"]==nil) {
        guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APPLICATION_HEIGHT) withTag:USERZONE_GUIDE];
        [self.view addSubview:guideView];
    }
}

- (void)initHeadUserInfo
{
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    [backgroundView setImage:[UIImage imageNamed:@"zoneBackground.png"]];
    [self.view addSubview:backgroundView];
    
    userPicImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 140, 60, 60)];
    [userPicImg setBackgroundColor:[UIColor whiteColor]];
    [userPicImg.layer setCornerRadius:5];
    userPicImg.layer.masksToBounds = YES;
    userPicImg.layer.borderWidth = 1;
    userPicImg.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    userPicImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editUserInfo)];
    [userPicImg addGestureRecognizer:gesture];
    [self.view addSubview:userPicImg];
    
    nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 140, 100, 20)];
    [nickNameLabel setFont:[UIFont systemFontOfSize:11]];
    [nickNameLabel setTextColor:[UIColor whiteColor]];
    [nickNameLabel setBackgroundColor:[UIColor clearColor]];
    nickNameLabel.userInteractionEnabled = YES;
    nickNameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editUserInfo)];
    [nickNameLabel addGestureRecognizer:gesture2];
    [self.view addSubview:nickNameLabel];
    
    sexImg = [[UIImageView alloc] initWithFrame:CGRectMake(170, 140, 20, 20)];
    [self.view addSubview:sexImg];
    
    inviteCodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 140, 100, 20)];
    [inviteCodeLabel setFont:[UIFont systemFontOfSize:11]];
    [inviteCodeLabel setTextColor:[UIColor whiteColor]];
    [inviteCodeLabel setBackgroundColor:[UIColor clearColor]];
    inviteCodeLabel.userInteractionEnabled = YES;
    [self.view addSubview:inviteCodeLabel];
    
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(75, 165, 45, 35);
    [messageBtn setBackgroundImage:[UIImage imageNamed:@"userMessage.png"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(readMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageBtn];
}

- (void)initContentView
{
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 210, 300, 60)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.borderWidth = 1;
    view1.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:view1];
    
    UILabel *separateLine = [[UILabel alloc] initWithFrame:CGRectMake(149, 0, 1, 60)];
    separateLine.backgroundColor = [UIColor lightGrayColor];
    [view1 addSubview:separateLine];
    
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(150*i, 0, 150, 60);
        [button setImage:[UIImage imageNamed:[buttonNorImgArr objectAtIndex:i]] forState:UIControlStateNormal];
        [button setTitle:[buttonTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = BUTTON_TAG+i;
        [button addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button];
    }
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(10, 290, 300, 60)];
    view2.backgroundColor = [UIColor whiteColor];
    view2.layer.borderWidth = 1;
    view2.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [self.view addSubview:view2];
    
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.frame = CGRectMake(0, 0, 300, 60);
    [orderBtn setImage:[UIImage imageNamed:[buttonNorImgArr objectAtIndex:2]] forState:UIControlStateNormal];
    [orderBtn setTitle:[buttonTitleArr objectAtIndex:2] forState:UIControlStateNormal];
    [orderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [orderBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    orderBtn.tag = BUTTON_TAG+2;
    orderBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    orderBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [orderBtn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:orderBtn];
    
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(270, 20, 23, 23)];
    arrowImg.image = [UIImage imageNamed:@"arrow.png"];
    arrowImg.userInteractionEnabled = YES;
    [view2 addSubview:arrowImg];
    
    noticeImage = [[UIImageView alloc] initWithFrame:CGRectMake(240, 20, 23, 23)];
    noticeImage.image = [UIImage imageNamed:@"notice.png"];
    [view2 addSubview:noticeImage];
    
    noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 20, 23, 23)];
    noticeLabel.backgroundColor = [UIColor clearColor];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.textColor = [UIColor whiteColor];
    [view2 addSubview:noticeLabel];
}

- (void)editUserInfo
{
    //用户编辑个人数据
    UserInfoEditViewController *userInfoCon = [[UserInfoEditViewController alloc] init];
    [self.navigationController pushViewController:userInfoCon animated:YES];
}
-(void)popViewController
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)readMessage:(id)sender
{
    //读取用户信息
    UserMessageViewController *messageCon = [[UserMessageViewController alloc] init];
    [self.navigationController pushViewController:messageCon animated:YES];
}

- (void)buttonClickedAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag - BUTTON_TAG) {
        case 0:
            [self showToast:@"功能暂未开放,敬请期待"];
            break;
        case 1:
            [self showToast:@"功能暂未开放,敬请期待"];
            break;
        case 2:
        {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            OrderCenterViewController *orderCon = [[OrderCenterViewController alloc] init];
            [self.navigationController pushViewController:orderCon animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initUserInfo];
}

- (void)shareButtonAction:(id)sender
{
    ShareView *shareView = [[ShareView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:shareView];
    [shareView initContentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUserInfo
{
    userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    
    if (userElement == nil || userElement.logoUrl == nil || [userElement.logoUrl isEqualToString:@""])
    {
        [userPicImg setImage:[UIImage imageNamed:@"defaultImg.png"]];
    }
    else
    {
        [ConUtils checkFileWithURLString:userElement.logoUrl withImageView:userPicImg withDirector:@"User" withDefaultImage:@"defaultImg.png"];
    }
    NSString *nickName = @"";
    if (userElement == nil || userElement.name == nil || [userElement.name isEqualToString:@""])
    {
        //[nickNameLabel setText:@"抢单达人"];
        nickName = @"抢单达人";
    }
    else
    {
        nickName = userElement.name;
    }
    [nickNameLabel setText:nickName];
    CGSize strSize = [nickName sizeWithFont:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(100, 20)];
    sexImg.frame = CGRectMake(80+strSize.width, 140, 20, 20);
    
    if (userElement!=nil&&userElement.inviteCode!=nil)
    {
        inviteCodeLabel.text = [NSString stringWithFormat:@"(%@)",userElement.inviteCode];
        inviteCodeLabel.frame = CGRectMake(110+strSize.width, 140, 100, 20);
    }
    
    if (userElement == nil || userElement.sex == nil)
    {
        [sexImg setImage:[UIImage imageNamed:@"userSexM.png"]];
    }
    else
    {
        if ([userElement.sex integerValue] == 0)
        {
            [sexImg setImage:[UIImage imageNamed:@"userSexM.png"]];
        }
        else
        {
            [sexImg setImage:[UIImage imageNamed:@"userSexW.png"]];
        }
    }
    
    if ([UIApplication sharedApplication].applicationIconBadgeNumber!=0)
    {
        noticeLabel.hidden = NO;
        noticeImage.hidden = NO;
        noticeLabel.text = [NSString stringWithFormat:@"%d",[UIApplication sharedApplication].applicationIconBadgeNumber];
    }
    else
    {
        noticeImage.hidden = YES;
        noticeLabel.hidden = YES;
    }
}

@end
