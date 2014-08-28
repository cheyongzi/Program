//
//  UserLoadViewController.m
//  Booking
//
//  Created by 1 on 11-12-31.
//  Copyright (c) 2011年 bluecreate. All rights reserved.
//

#import "UserLoadViewController.h"
#import "ConstantField.h"
#import "PhoneRegisteViewController.h"
#import "ForgetPwdViewController.h"
#import "UserZoneMainViewController.h"
#import "SharedUserDefault.h"
#import "NSString+CheckUserInfo.h"
#import "ConUtils.h"
#import "ShareView.h"

@interface UserLoadViewController ()
{
    UIButton *loadBtn;
}
@end

@implementation UserLoadViewController

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
    
    self.title = @"登陆";
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"user_account.png",@"user_pwd.png", nil];
    
    UIImageView *loadLogoImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 10, 80, 80)];
    [loadLogoImg setImage:[UIImage imageNamed:@"loadLogo.png"]];
    [self.view addSubview:loadLogoImg];
    
    backgroundView = [[TextFiledBackgroundView alloc] initWithFrame:CGRectMake(10, 100, 300, 80) withColor:LOAD_SEPERATE_COLOR withImage:imageArr];
    [self.view addSubview:backgroundView];
    
    [self initUserAccount];
    
    [self initUserPassword];
    
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPwdBtn setFrame:CGRectMake(240, 180, 60, 40)];
    [forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPwdBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
    [forgetPwdBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [forgetPwdBtn addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];
    
    loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 220, 300, 44)];
    [loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    //[loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [loadBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(userLoad:) forControlEvents:UIControlEventTouchUpInside];
    loadBtn.layer.cornerRadius = 5;
    [self.view addSubview:loadBtn];
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 274, 300, 44)];
    [registerBtn setBackgroundColor:USER_REGISTER_COLOR];
    [registerBtn setTitle:@"免费注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(userRegiste:) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.cornerRadius = 5;
    [self.view addSubview:registerBtn];
    
//    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicatorView.frame= CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2,0,0);
//    [self.view addSubview:indicatorView];
}

- (void)forgetPassword:(id)sender
{
    ForgetPwdViewController *forgetPwdCon = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetPwdCon animated:YES];
}

- (void)initUserAccount
{
    accountField = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 249, 40)];
    [self setTextField:accountField withPlaceholder:@"手机号码/邮箱" withSecure:NO];
}

- (void)initUserPassword
{
    pwdField = [[UITextField alloc] initWithFrame:CGRectMake(50, 40, 249, 40)];
    [self setTextField:pwdField withPlaceholder:@"密码" withSecure:YES];
}

- (void)setTextField:(UITextField*)textField withPlaceholder:(NSString*)title withSecure:(BOOL)isSecure
{
    textField.placeholder = title;
    textField.font = [UIFont systemFontOfSize:14];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
    if (isSecure)
    {
        textField.secureTextEntry = YES;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [backgroundView addSubview:textField];
}

- (void)userLoad:(id)sender
{
    [self.view endEditing:YES];
    if ([self checkUserInfo])
    {
        if (![ConUtils checkUserNetwork])
        {
            [self showToast:@"网络连接不可用，请稍后再试！"];
        }
        else
        {
            [SVProgressHUD show];
            //[indicatorView startAnimating];
            loadBtn.userInteractionEnabled = NO;
            //[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [HttpRequestComm userLogin:[accountField text] AndPassword:[pwdField text] withDelegate:self];
        }
    }
}

- (int)checkUserType
{
    if ([userElement.userCode checkUserPhoneNumber])
    {
        return 0;
    }
    else if ([userElement.userCode checkUserMailNumber])
    {
        return 1;
    }
    return 2;
}

- (BOOL)checkUserInfo
{
    if (accountField == nil || [accountField text] == nil || [[accountField text] isEqualToString:@""])
    {
        [self showToast:@"请输入正确的手机号码或邮箱"];
        return NO;
    }
    else
    {
        if (![[accountField text] checkUserPhoneNumber]&&![[accountField text] checkUserMailNumber])
        {
            [self showToast:@"请输入正确的手机号码或邮箱"];
            return NO;
        }
    }
    
    if ([pwdField text] == nil || [[pwdField text] isEqualToString:@""])
    {
        [self showToast:@"密码长度必须为6-32个字符"];
        return NO;
    }
    else
    {
        if ([[pwdField text] length] < 6 || [[pwdField text] length] > 32)
        {
            [self showToast:@"密码长度必须为6-32个字符"];
            return NO;
        }
    }
    return YES;
}

- (void)userRegiste:(id)sender
{
    PhoneRegisteViewController *phoneRegisteCon = [[PhoneRegisteViewController alloc] init];
    [self.navigationController pushViewController:phoneRegisteCon animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HttpRequestCommDelegate
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    //[indicatorView stopAnimating];
    [SVProgressHUD dismiss];
    loadBtn.userInteractionEnabled = YES;
    loginResponse = [[LoginResponse alloc] init];
    [loginResponse setHeadData:inParam];
    if (loginResponse.code == 0) {
        [loginResponse setResultData:inParam];
        userElement = loginResponse.userElement;
        
        [[SharedUserDefault sharedInstance] setLoginState:@"Y"];
        
        [[SharedUserDefault sharedInstance] setUserInfo:[NSKeyedArchiver archivedDataWithRootObject:userElement]];
        
        if (self.loginTag)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UserZoneMainViewController *mainCon = [[UserZoneMainViewController alloc] init];
            [self.navigationController pushViewController:mainCon animated:YES];
        }
    }else{
        userElement = nil;
        NSString *returnMsg = [[inParam objectForKey:@"result"] objectForKey:@"msg"];
        if (returnMsg == nil || [returnMsg isEqualToString:@""])
        {
            [self showToast:@"网络异常，请稍后再试"];
        }
        else
        {
            [self showToast:returnMsg];
        }
    }
}

//网络请求失败协议方法
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    //[indicatorView stopAnimating];
    loadBtn.userInteractionEnabled = YES;
    [self showToast:@"网络异常，请稍后再试"];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

- (void)popViewController
{
    [SVProgressHUD dismiss];
    [super popViewController];
}

@end
