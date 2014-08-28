//
//  MailRegisteViewController.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "MailRegisteViewController.h"
#import "ConstantField.h"
#import "ConUtils.h"
#import "NSString+CheckUserInfo.h"
#import "UserProtocalViewController.h"

@interface MailRegisteViewController ()

@end

@implementation MailRegisteViewController

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
    
    self.title = @"注册";
    
    isAgreeProtocal = YES;
    
    time = 59;
    
    NSArray *imgArr = [NSArray arrayWithObjects:@"registe_mail.png",@"verification_code.png",@"user_pwd.png",@"confir_pwd.png", nil];
    
    backgroundView = [[TextFiledBackgroundView alloc] initWithFrame:CGRectMake(10, 10, 300, 160) withColor:LOAD_SEPERATE_COLOR withImage:imgArr];
    [self.view addSubview:backgroundView];

    [self initRegisteInfo];
    
    
    UIButton *loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 180, 300, 44)];
    [loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [loadBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(registe:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    protocalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protocalBtn setBackgroundImage:[UIImage imageNamed:@"protocal.png"] forState:UIControlStateNormal];
    [protocalBtn setFrame:CGRectMake(10, 230, 22.5, 22.5)];
    [protocalBtn addTarget:self action:@selector(protocalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocalBtn];
    
    UILabel *protocalInfo = [[UILabel alloc] initWithFrame:CGRectMake(35, 230, 75, 22.5)];
    [protocalInfo setBackgroundColor:[UIColor clearColor]];
    [protocalInfo setText:@"我已阅读并接受"];
    //[protocalInfo setTextColor:USER_LOADBTN_COLOR];
    [protocalInfo setFont:[UIFont systemFontOfSize:10]];
    [self.view addSubview:protocalInfo];
    
    UIButton *protocalViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[protocalViewBtn setBackgroundColor:[UIColor clearColor]];
    [protocalViewBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
    [protocalViewBtn setFrame:CGRectMake(101, 230, 70, 22.5)];
    [protocalViewBtn setTitle:@"微歌用户协议" forState:UIControlStateNormal];
    [protocalViewBtn addTarget:self action:@selector(viewProtocal:) forControlEvents:UIControlEventTouchUpInside];
    [protocalViewBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.view addSubview:protocalViewBtn];
	// Do any additional setup after loading the view.
}

- (void)initRegisteInfo
{
    
    mailNum = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 249, 40)];
    [self setTextField:mailNum withPlaceholder:@"请输入您的真实邮箱" withSecure:NO];
    
    verificationCode = [[UITextField alloc] initWithFrame:CGRectMake(50, 40, 170, 40)];
    [self setTextField:verificationCode withPlaceholder:@"请输入验证码" withSecure:NO];
    
    UILabel *proSeperateLine = [[UILabel alloc] initWithFrame:CGRectMake(220, 40, 1, 40)];
    [proSeperateLine setBackgroundColor:LOAD_SEPERATE_COLOR];
    [backgroundView addSubview:proSeperateLine];
    
    verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verifyCodeBtn setFrame:CGRectMake(220, 40, 80, 40)];
    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verifyCodeBtn addTarget:self action:@selector(queryVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [verifyCodeBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
    [verifyCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [backgroundView addSubview:verifyCodeBtn];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(50, 80, 249, 40)];
    [self setTextField:password withPlaceholder:@"请输入6-32位密码" withSecure:YES];
    
    confirmPwd = [[UITextField alloc] initWithFrame:CGRectMake(50, 120, 249, 40)];
    [self setTextField:confirmPwd withPlaceholder:@"请确认您的密码" withSecure:YES];
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

- (void)protocalBtnClick:(id)sender
{
    if (isAgreeProtocal)
    {
        isAgreeProtocal = NO;
        [protocalBtn setBackgroundImage:[UIImage imageNamed:@"protocalUnSel.png"] forState:UIControlStateNormal];
    }
    else
    {
        isAgreeProtocal = YES;
        [protocalBtn setBackgroundImage:[UIImage imageNamed:@"protocal.png"] forState:UIControlStateNormal];
    }
}

-(void)viewProtocal:(id)sender
{
    UserProtocalViewController *controller = [[UserProtocalViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

/*
 *  获取验证码
 */
- (void)queryVerifyCode:(id)sender
{
    if ([[mailNum text] isEqualToString:@""] || mailNum == nil || [mailNum text] == nil) {
        //用户手机号为空时的提示
        [self showToast:@"请输入正确的邮箱"];
    }else{
        if ([[mailNum text] checkUserMailNumber])
        {
            if (![ConUtils checkUserNetwork])
            {
                [self showToast:@"网络连接不可用，请稍后再试！"];
            }
            else
            {
                [SVProgressHUD show];
                [HttpRequestComm getCecurityCode:[mailNum text] withDelegate:self withFlag:@"Email"];
            }
        }
        else
        {
            [self showToast:@"请输入正确的邮箱"];
        }
    }
}

- (void)verifyCodding
{
    [verifyCodeBtn setUserInteractionEnabled:NO];
    [verifyCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%d)",time] forState:UIControlStateNormal];
    time -=1;
    if (time == 0)
    {
        [verifyCodeBtn setUserInteractionEnabled:YES];
        [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        time = 59;
        [timer invalidate];
    }
}

- (void)registe:(id)sender
{
    if (!isAgreeProtocal)
    {
        //用户未勾选协议的提示
        [self showToast:@"请选择接受微歌用户协议"];
    }else
    {
        if ([self checkUserInfo])
        {
            if (![ConUtils checkUserNetwork])
            {
                [self showToast:@"网络连接不可用，请稍后再试！"];
            }
            else
            {
                NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
                [mulDic setObject:[mailNum text] forKey:@"userCode"];
                [mulDic setObject:[verificationCode text] forKey:@"verify"];
                [mulDic setObject:[[password text] md5] forKey:@"passWord"];
                [mulDic setObject:@"2" forKey:@"registerMethod"];
                [mulDic setObject:@"1" forKey:@"registerResource"];
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"]!=nil)
                {
                    [mulDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"] forKey:@"device"];
                }
                [HttpRequestComm userRegister:mulDic withDelegate:self];
            }
        }
    }
}

- (BOOL)checkUserInfo
{
    if ([[mailNum text] isEqualToString:@""] || [mailNum text] == nil)
    {
        [self showToast:@"请输入正确的邮箱"];
        return  NO;
    }
    else
    {
        if (![[mailNum text] checkUserMailNumber])
        {
            [self showToast:@"请输入正确的邮箱"];
            return  NO;;
        }
    }
    
    if ([[verificationCode text] isEqualToString:@""] || [verificationCode text] == nil)
    {
        [self showToast:@"验证码错误，请重新输入"];
        return  NO;
    }
    else
    {
        if ([[verificationCode text] length] != 4)
        {
            [self showToast:@"验证码错误，请重新输入"];
            return  NO;
        }
    }
    
    if ([password text] == nil || [[password text] isEqualToString:@""])
    {
        [self showToast:@"密码长度必须为6-32个字符"];
        return  NO;
    }
    else
    {
        if ([[password text] length] > 32 || [[password text] length] < 6)
        {
            [self showToast:@"密码长度必须为6-32个字符"];
            return  NO;
        }
    }
    
    if ([confirmPwd text] == nil || [[confirmPwd text] isEqualToString:@""])
    {
        [self showToast:@"两次输入的密码不一致"];
        return  NO;
    }
    else
    {
        if (![[confirmPwd text] isEqualToString:[password text]])
        {
            [self showToast:@"两次输入的密码不一致"];
            return  NO;
        }
    }
    return YES;
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

- (void)backLogin
{
    [timer invalidate];
    int index = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index - 2)] animated:YES];
}

# pragma HttpRequestCommDelegate
//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    switch (tagId) {
        case SECURITYCODE:
            //NSLog(@"Veritify code get success %@,%@,%@",inParam,[[inParam objectForKey:@"result"] objectForKey:@"code"],[[inParam objectForKey:@"result"] objectForKey:@"msg"]);
            if (inParam == nil)
            {
                //数据库返回内容为空时
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                verifyResponse = [[VerifyResponse alloc] init];
                [verifyResponse setHeadData:inParam];
                //判断服务器返回的code值
                if (verifyResponse.code == 0)
                {
                    //验证码下发成功
                    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(verifyCodding) userInfo:nil repeats:YES];
                    [self showToast:@"验证码下发成功"];
                    [verifyResponse setResultData:inParam];
                }else
                {
                    //验证码下发失败
                    [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
                }
            }
            break;
        case USERREGISTER:
            //NSLog(@"registe test result %@",inParam);
            if (inParam == nil)
            {
                //数据库返回内容为空时
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
                {
                    [self showToast:@"注册成功"];
                    [self performSelector:@selector(backLogin) withObject:nil afterDelay:2];
                }
                else
                {
                    NSString *returnMsg = [[inParam objectForKey:@"result"] objectForKey:@"msg"];
                    if (returnMsg == nil || [returnMsg isEqualToString:@""])
                    {
                        [self showToast:@"网络异常，请稍后再试"];
                    }
                    else
                    {
                        [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
                    }
                }
            }
            break;
            
        default:
            break;
    }
}

//网络请求失败协议方法
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    switch (tagId) {
        case SECURITYCODE:
            NSLog(@"Veritify code get failed %@",error);
            [self showToast:@"网络异常，请稍后再试"];
            break;
        case USERREGISTER:
            [self showToast:@"网络异常，请稍后再试"];
            break;
            
        default:
            break;
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

- (void)popViewController
{
    
}

@end
