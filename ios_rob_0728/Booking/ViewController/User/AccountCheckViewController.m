//
//  AccountCheckViewController.m
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AccountCheckViewController.h"
#import "ConstantField.h"
#import "NSString+CheckUserInfo.h"
#import "BindPhoneViewController.h"
#import "BindEmailViewController.h"
#import "ConUtils.h"

@interface AccountCheckViewController ()

@end

@implementation AccountCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithAccountNum:(NSString *)accountNum
{
    if (self = [super init])
    {
        self.title = @"安全验证";
        
        accountNumber = accountNum;
        
        isUserPhoneType = YES;
        
        time = 59;
        
        NSArray *imgArr = [NSArray arrayWithObjects:@"user_account.png",@"verification_code.png", nil];
        
        backgroundView = [[TextFiledBackgroundView alloc] initWithFrame:CGRectMake(10, 10, 300, 80) withColor:LOAD_SEPERATE_COLOR withImage:imgArr];
        [self.view addSubview:backgroundView];
        
        [self initTextInfo];
        
        UIButton *loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
        [loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        //[loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
        [loadBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [loadBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loadBtn];
    }
    return self;
}

- (void)nextStep:(id)sender
{
    if ([verifyText text] == nil || [[verifyText text] isEqualToString:@""])
    {
        [self showToast:@"请输入正确的验证码"];
    }
    else
    {
        if (![ConUtils checkUserNetwork])
        {
            [self showToast:@"网络连接不可用，请稍后再试！"];
        }
        else
        {
            NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
            [mulDic setObject:accountNumber forKey:@"userCode"];
            [mulDic setObject:[verifyText text] forKey:@"verify"];
            [HttpRequestComm checkVerifyCode:mulDic withDelegate:self];
        }
    }
}

- (void)initTextInfo
{
    accountText = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 249, 40)];
    [self setTextField:accountText withPlaceholder:@"" withSecure:NO];
    accountText.text = accountNumber;
    accountText.userInteractionEnabled = NO;
    
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

- (void)queryVerifyCode:(id)sender
{
    //判断用户输入的类型
    if (![ConUtils checkUserNetwork])
    {
        [self showToast:@"网络连接不可用，请稍后再试！"];
    }
    else
    {
        [SVProgressHUD show];
        if ([accountNumber checkUserMailNumber])
        {
            isUserPhoneType = NO;
        }
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:accountNumber forKey:@"userCode"];
        if (isUserPhoneType)
        {
            [mulDic setObject:@"0" forKey:@"type"];
            [mulDic setObject:accountNumber forKey:@"mobile"];
        }else
        {
            [mulDic setObject:@"1" forKey:@"type"];
            [mulDic setObject:accountNumber forKey:@"email"];
        }
        [mulDic setObject:@"2" forKey:@"method"];
        [HttpRequestComm getVerifyCode:mulDic withDelegate:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    BaseViewController *controller;
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
            //NSLog(@"Check code success %@,%@,%@",inParam,[[inParam objectForKey:@"result"] objectForKey:@"code"],[[inParam objectForKey:@"result"] objectForKey:@"msg"]);
            if (inParam == nil)
            {
                [self showToast:@"网络异常，请稍后再试"];
            }
            else
            {
                if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
                {
                    if (isUserPhoneType)
                    {
                        controller = [[BindPhoneViewController alloc] init];
                    }
                    else
                    {
                        controller = [[BindEmailViewController alloc] init];
                    }
                    [timer invalidate];
                    [verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    verifyCodeBtn.userInteractionEnabled = YES;
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
    [timer invalidate];
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
