//
//  UserAccountEditViewController.m
//  Booking
//
//  Created by 1 on 13-7-23.
//  Copyright (c) 2013年 bluecreate. All rights reserved.
//

#import "UserAccountEditViewController.h"
#import "NSString+CheckUserInfo.h"
#import "AccountCheckViewController.h"
#import "AccountInfoChangeCell.h"
#import "BindPhoneViewController.h"
#import "BindEmailViewController.h"
#import "PwdChangeViewController.h"
#import "SuggestViewController.h"
#import "CacheViewController.h"
#import "AboutViewController.h"

#define TABLEVIEW_TAG 1000

@interface UserAccountEditViewController ()

@end

@implementation UserAccountEditViewController

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
    
    self.title = @"帐户管理";
    
    userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    
    accountArr1 = [NSArray arrayWithObjects:@"userZonePhone.png",@"userZoneMail.png",@"userZonePwd.png", nil];
    
    accountArr2 = [NSArray arrayWithObjects:@"手机号码",@"邮       件",@"登陆密码", nil];
    
    paramArr = [NSArray arrayWithObjects:@"",@"name",@"contact",@"sex", nil];
    
    userType = [self checkUserType];
    
    imgArr = [NSArray arrayWithObjects:@"suggest.png",@"clearCache.png",@"aboutUs.png", nil];
    titleArr = [NSArray arrayWithObjects:@"意见反馈",@"清理缓存",@"关于我们", nil];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APPLICATION_HEIGHT - 44)];
    myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 460);
    [self.view addSubview:myScrollView];
    
//    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicatorView.frame= CGRectMake(SCREEN_WIDTH/2, 20,0,0);
//    [myScrollView addSubview:indicatorView];
//    
//    indicatorView2 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicatorView2.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0);
    
    [self initAccountInfoView];
    
    UIButton *finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 400, 300, 44)];
    [finishBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    //[finishBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [finishBtn setTitle:@"注销登陆" forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
    [myScrollView addSubview:finishBtn];
	// Do any additional setup after loading the view.
}

- (void)initAccountInfoView
{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 290, 20)];
    label1.text = @"账户信息";
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [UIColor lightGrayColor];
    [myScrollView addSubview:label1];
    
    mySecTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 40, 300, 150)];
    mySecTable.tag = TABLEVIEW_TAG + 0;
    [self initWithTableView:mySecTable];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 205, 290, 20)];
    label2.text = @"更多设置";
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor lightGrayColor];
    [myScrollView addSubview:label2];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 230, 300, 150)];
    myTableView.tag = TABLEVIEW_TAG + 1;
    [self initWithTableView:myTableView];
}

- (void)initWithTableView:(UITableView*)tableView
{
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.layer.borderWidth = 1;
    tableView.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [myScrollView addSubview:tableView];
}

- (int)checkUserType
{
    if ([userElement.userCode checkUserPhoneNumber])
    {
        return 0;
    }
    return 1;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView.tag - TABLEVIEW_TAG == 0) {
        AccountInfoChangeCell *cell = (AccountInfoChangeCell *)[tableView cellForRowAtIndexPath:indexPath];
        if (!cell.contentLabel.isHidden&&cell.contentLabel.text != nil&&![cell.contentLabel.text isEqualToString:@""])
        {
            AccountCheckViewController *checkCon = [[AccountCheckViewController alloc] initWithAccountNum:cell.contentLabel.text];
            [self.navigationController pushViewController:checkCon animated:YES];
        }
        else
        {
            if ([indexPath row] == 0)
            {
                BindPhoneViewController *phoneController = [[BindPhoneViewController alloc] init];
                [self.navigationController pushViewController:phoneController animated:YES];
            }
            else if ([indexPath row] == 1)
            {
                BindEmailViewController *emailController = [[BindEmailViewController alloc] init];
                [self.navigationController pushViewController:emailController animated:YES];
            }
            
            if ([indexPath row] == 2)
            {
                PwdChangeViewController *pwdChangeCon = [[PwdChangeViewController alloc] init];
                [self.navigationController pushViewController:pwdChangeCon animated:YES];
            }
        }
    }
    else
    {
        if ([indexPath row] == 0) {
            SuggestViewController *sugCon = [[SuggestViewController alloc] init];
            [self.navigationController pushViewController:sugCon animated:YES];
        }
        else if ([indexPath row] == 1)
        {
//            CacheViewController *cacheCon = [[CacheViewController alloc] init];
//            [self.navigationController pushViewController:cacheCon animated:YES];
            [[NSFileManager defaultManager] removeItemAtPath:[FILE_PATH stringByAppendingPathComponent:@"Wine"] error:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[FILE_PATH stringByAppendingPathComponent:@"User"] error:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[FILE_PATH stringByAppendingPathComponent:@"Shop"] error:nil];
            [self showToast:@"缓存清理完成"];
        }
        else if ([indexPath row] == 2)
        {
            AboutViewController *aboutCon = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutCon animated:YES];
        }
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag - TABLEVIEW_TAG == 0) {
        static NSString *secCellIndentify = @"ACCOUNTCHANGECELL";
        AccountInfoChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:secCellIndentify];
        if (cell == nil) {
            cell = [[AccountInfoChangeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secCellIndentify];
        }
        cell.iconImg.image = [UIImage imageNamed:[accountArr1 objectAtIndex:[indexPath row]]];
        cell.titleLabel.text = [accountArr2 objectAtIndex:[indexPath row]];
        if ([indexPath row] == 0)
        {
            cell.contentLabel.text = userType == 0 ? userElement.userCode : userElement.mobile;
        }
        else if ([indexPath row] == 1)
        {
            cell.contentLabel.text = userType == 1 ? userElement.userCode : userElement.email;
        }
        if ([indexPath row] == 2)
        {
            [cell.contentLabel setHidden:YES];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 300, 1)];
        [seperateLine setBackgroundColor:LOAD_SEPERATE_COLOR];
        [cell addSubview:seperateLine];
        return cell;
    }
    else
    {
        static NSString *indentify = @"MoreSettingCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
        }
        UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 21, 26)];
        [iconImg setBackgroundColor:[UIColor clearColor]];
        iconImg.image = [UIImage imageNamed:[imgArr objectAtIndex:[indexPath row]]];
        [cell addSubview:iconImg];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 80, 30)];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.text = [titleArr objectAtIndex:[indexPath row]];
        [cell addSubview:titleLabel];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 300, 1)];
        [seperateLine setBackgroundColor:LOAD_SEPERATE_COLOR];
        [cell addSubview:seperateLine];
        return cell;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    [mySecTable reloadData];
}

- (void)loginOut:(id)sender
{
//    if ([ConUtils checkUserNetwork])
//    {
//        [HttpRequestComm userLogout:self];
//    }
//    else
//    {
//        [self showToast:@"网络连接不可用，请稍后再试！"];
//    }
    
    [[SharedUserDefault sharedInstance] setLoginState:@"N"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
