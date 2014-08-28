//
//  ForgetNextStepViewController.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ForgetNextStepViewController.h"
#import "ConstantField.h"
#import "UserLoadViewController.h"
#import "NSString+CheckUserInfo.h"

@interface ForgetNextStepViewController ()
{
    UIButton *loadBtn;
}
@end

@implementation ForgetNextStepViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUserAccount:(NSString*)userAccount
{
    if (self = [super init]) {
        accountNumber = userAccount;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    NSArray *imgArr = [NSArray arrayWithObjects:@"user_pwd.png",@"confir_pwd.png", nil];
    
    backgroundView = [[TextFiledBackgroundView alloc] initWithFrame:CGRectMake(10, 10, 300, 80) withColor:LOAD_SEPERATE_COLOR withImage:imgArr];
    [self.view addSubview:backgroundView];
    
    [self initTextInfo];
    
    loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 300, 44)];
    [loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    //[loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [loadBtn setTitle:@"完成" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(finishFindPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
//    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0);
//    [self.view addSubview:indicator];
	// Do any additional setup after loading the view.
}

- (void)initTextInfo
{
    
    pwdText = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 249, 40)];
    [self setTextField:pwdText withPlaceholder:@"请输入6-32位密码" withSecure:YES];
    
    confirmPwdText = [[UITextField alloc] initWithFrame:CGRectMake(50, 40, 249, 40)];
    [self setTextField:confirmPwdText withPlaceholder:@"请确认您的密码" withSecure:YES];
}

- (void)setTextField:(UITextField*)textField withPlaceholder:(NSString*)title withSecure:(BOOL)isSecure
{
    textField.placeholder = title;
    textField.font = [UIFont systemFontOfSize:14];
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    if (isSecure)
    {
        textField.secureTextEntry = YES;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [backgroundView addSubview:textField];
}

- (void)finishFindPwd:(id)sender
{
    [self.view endEditing:YES];
    if ([self checkUserPwdInfo])
    {
        if (![ConUtils checkUserNetwork])
        {
            [self showToast:@"网络连接不可用，请稍后再试！"];
        }
        else
        {
            [SVProgressHUD show];
            //[indicator startAnimating];
            loadBtn.userInteractionEnabled = NO;
            [HttpRequestComm findPassWord:[[pwdText text] md5] andUserCount:accountNumber withDelegate:self];
        }
    }
}

- (BOOL)checkUserPwdInfo
{
    if ([pwdText text] == nil || [[pwdText text] isEqualToString:@""])
    {
        [self showToast:@"请输入6-32个字符"];
        return NO;
    }
    else
    {
        if ([[pwdText text] length] <6 || [[pwdText text] length] > 32)
        {
            [self showToast:@"请输入6-32个字符"];
            return NO;
        }
    }
    
    if ([confirmPwdText text] == nil || [[confirmPwdText text] isEqualToString:@""])
    {
        [self showToast:@"两次输入密码不一致"];
        return NO;
    }
    else
    {
        if (![[confirmPwdText text] isEqualToString:[pwdText text]])
        {
            [self showToast:@"两次输入密码不一致"];
            return NO;
        }
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark HttpRequestCommDelegate
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    //[indicator stopAnimating];
    loadBtn.userInteractionEnabled = YES;
    //NSLog(@"修改密码返回内容：%@,%@",inParam,[[inParam objectForKey:@"result"] objectForKey:@"msg"]);
    if (inParam == nil)
    {
        [self showToast:@"网络异常，请稍后再试"];
    }
    else
    {
        if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
        {
            [self showToast:@"修改密码成功,即将跳往登陆页面"];
            [self performSelector:@selector(backLogin) withObject:nil afterDelay:2];
        }
        else
        {
            [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
        }
    }
}

- (void)backLogin
{
    int index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index - 2)] animated:YES];
}

//网络请求失败协议方法
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    //[indicator stopAnimating];
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
