//
//  ForgetPwdViewController.m
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ConstantField.h"
#import "ForgetNextStepViewController.h"
#import "NSString+CheckUserInfo.h"
#import "ConUtils.h"

@interface ForgetPwdViewController ()
{
    UIButton *loadBtn;
}
@end

@implementation ForgetPwdViewController

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
    
    self.title = @"找回密码";
    
    time = 59;
    
    isUserPhoneType = YES;
    
    NSArray *imgArr = [NSArray arrayWithObjects:@"user_account.png",@"verification_code.png", nil];
    
    backgroundView = [[TextFiledBackgroundView alloc] initWithFrame:CGRectMake(10, 10, 300, 80) withColor:LOAD_SEPERATE_COLOR withImage:imgArr];
    [self.view addSubview:backgroundView];
    
    [self initTextInfo];
    
    loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 300, 44)];
    [loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    //[loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [loadBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
//    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0);
//    [self.view addSubview:indicator];
	// Do any additional setup after loading the view.
}

- (void)initTextInfo
{
    
    accountText = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 249, 40)];
    [self setTextField:accountText withPlaceholder:@"请输入您绑定的手机号/邮箱" withSecure:NO];
    
    verifyText = [[UITextField alloc] initWithFrame:CGRectMake(50, 40, 170, 40)];
    [self setTextField:verifyText withPlaceholder:@"请输入验证码" withSecure:NO];
    
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

- (void)nextStep:(id)sender
{
    [self.view endEditing:YES];
    if ([accountText text] == nil || [[accountText text] isEqualToString:@""])
    {
        [self showToast:@"请输入绑定的手机号或邮箱"];
        return;
    }
    if ([verifyText text] == nil || [[verifyText text] isEqualToString:@""])
    {
        [self showToast:@"请输入正确的验证码"];
        return;
    }
    if (![ConUtils checkUserNetwork])
    {
        [self showToast:@"网络连接不可用，请稍后再试！"];
    }
    else
    {
        //[indicator startAnimating];
        [SVProgressHUD show];
        loadBtn.userInteractionEnabled = NO;
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:[accountText text] forKey:@"userCode"];
        [mulDic setObject:[verifyText text] forKey:@"verify"];
        [HttpRequestComm checkVerifyCode:mulDic withDelegate:self];
    }
}
- (void)queryVerifyCode:(id)sender
{
    [self.view endEditing:YES];
    //判断用户输入的类型
    if ([accountText text] == nil || [[accountText text] isEqualToString:@""])
    {
        [self showToast:@"请输入绑定的手机号或邮箱"];
    }
    else
    {
        if (![[accountText text] checkUserPhoneNumber]&&![[accountText text] checkUserMailNumber]) {
            [self showToast:@"请输入绑定的手机号或邮箱"];
            return;
        }
        [SVProgressHUD show];
        if ([[accountText text] checkUserMailNumber])
        {
            isUserPhoneType = NO;
        }
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:[accountText text] forKey:@"userCode"];
        if (isUserPhoneType)
        {
            [mulDic setObject:@"0" forKey:@"type"];
            [mulDic setObject:[accountText text] forKey:@"mobile"];
        }else
        {
            [mulDic setObject:@"1" forKey:@"type"];
            [mulDic setObject:[accountText text] forKey:@"email"];
        }
        [mulDic setObject:@"0" forKey:@"method"];
        [HttpRequestComm getVerifyCode:mulDic withDelegate:self];
    }
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

- (void)popViewController
{
    [timer invalidate];
    [SVProgressHUD dismiss];
    [super popViewController];
}

- (void)verifyCodding
{
    [verifyCodeBtn setUserInteractionEnabled:NO];
    [verifyCodeBtn setTitle:[NSString stringWithFormat:@"重新获取%d",time] forState:UIControlStateNormal];
    time -=1;
    if (time == 0)
    {
        [verifyCodeBtn setUserInteractionEnabled:YES];
        [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        time = 59;
        [timer invalidate];
    }
}

# pragma mark HttpRequestCommDelegate
//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    switch (tagId) {
        case GETVERIFY:
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
        case CHECKVERIFY:
            loadBtn.userInteractionEnabled = YES;
            //NSLog(@"Check code success %@,%@,%@",inParam,[[inParam objectForKey:@"result"] objectForKey:@"code"],[[inParam objectForKey:@"result"] objectForKey:@"msg"]);
            if (inParam == nil)
            {
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
                {
                    [timer invalidate];
                    verifyCodeBtn.userInteractionEnabled = YES;
                    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    ForgetNextStepViewController *controller = [[ForgetNextStepViewController alloc] initWithUserAccount:[accountText text]];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                else
                {
                    [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
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
        case GETVERIFY:
            [self showToast:@"网络异常，请稍后再试"];
            break;
        case CHECKVERIFY:
            loadBtn.userInteractionEnabled = YES;
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


@end
