//
//  BindPhoneViewController.m
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "ConstantField.h"
#import "NSString+CheckUserInfo.h"
#import "ConUtils.h"
#import "SharedUserDefault.h"
#import "AccountCheckViewController.h"

@interface BindPhoneViewController ()

@end

@implementation BindPhoneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)initTextInfo
{
    accountText = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 249, 40)];
    [self setTextField:accountText withPlaceholder:@"请输入手机号码" withSecure:NO];
    
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
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    if (isSecure)
    {
        textField.secureTextEntry = YES;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [backgroundView addSubview:textField];
}

- (void)finishBinding:(id)sender
{
    if ([accountText text] == nil || [[accountText text] isEqualToString:@""])
    {
        [self showToast:@"请输入绑定的手机号号码"];
        return;
    }
    if ([verifyText text] == nil || [[verifyText text] isEqualToString:@""])
    {
        [self showToast:@"请输入正确的验证码"];
        return;
    }
    if (![ConUtils checkUserNetwork])
    {
        [self showToast:@"网络异常，请稍后再试"];
    }
    else
    {
        [SVProgressHUD show];
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:userElement.userCode forKey:@"userCode"];
        [mulDic setObject:userElement.sessionId forKey:@"sid"];
        [mulDic setObject:[accountText text] forKey:MOBILE];
        [HttpRequestComm updateMemberInfo:mulDic withDelegate:self];
    }
}

- (void)queryVerifyCode:(id)sender
{
    if ([self checkUserInfo])
    {
        if (![ConUtils checkUserNetwork])
        {
            [self showToast:@"网络连接不可用，请稍后再试！"];
        }
        else
        {
            [SVProgressHUD show];
            NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
            [mulDic setObject:userElement.userCode forKey:@"userCode"];
            [mulDic setObject:@"0" forKey:@"type"];
            [mulDic setObject:@"1" forKey:@"method"];
            [mulDic setObject:[accountText text] forKey:@"mobile"];
            [HttpRequestComm getVerifyCode:mulDic withDelegate:self];
        }
    }
    else
    {
        [self showToast:@"请输入正确的手机号"];
    }
}

- (BOOL)checkUserInfo
{
    if ([accountText text] == nil || [[accountText text] isEqualToString:@""])
    {
        return NO;
    }
    else
    {
        if ([[accountText text] checkUserPhoneNumber])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"绑定手机号码";
    
    time = 59;
    
    userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    
    NSArray *imgArr = [NSArray arrayWithObjects:@"registe_phone.png",@"verification_code.png", nil];
    
    backgroundView = [[TextFiledBackgroundView alloc] initWithFrame:CGRectMake(10, 10, 300, 80) withColor:LOAD_SEPERATE_COLOR withImage:imgArr];
    [self.view addSubview:backgroundView];
    
    [self initTextInfo];
    
    UIButton *finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 120, 300, 44)];
    [finishBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [finishBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishBinding:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
	// Do any additional setup after loading the view.
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

- (void)popViewController
{
    [timer invalidate];
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
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
        case USERUPDATE:
            if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
            {
                loginResponse = [[LoginResponse alloc] init];
                [loginResponse setHeadData:inParam];
                [loginResponse setResultData:inParam];
                
                [[SharedUserDefault sharedInstance] setUserInfo:[NSKeyedArchiver archivedDataWithRootObject:loginResponse.userElement]];
                [timer invalidate];
                int controllerIndex = [self.navigationController.viewControllers indexOfObject:self];
                if ([[self.navigationController.viewControllers objectAtIndex:(controllerIndex - 1)] isKindOfClass:[AccountCheckViewController class]])
                {
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(controllerIndex - 2)] animated:YES];
                }
                else
                {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else
            {
                [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
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
