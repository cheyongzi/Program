//
//  PwdChangeViewController.m
//  Booking
//
//  Created by 1 on 14-6-25.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "PwdChangeViewController.h"
#import "ConstantField.h"
#import "SharedUserDefault.h"
#import "NSString+CheckUserInfo.h"

@interface PwdChangeViewController ()

@end

@implementation PwdChangeViewController

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
    
    self.title = @"修改密码";
    
    NSArray *imgArr = [NSArray arrayWithObjects:@"user_pwd.png",@"user_pwd.png",@"confir_pwd.png", nil];
    
    backgroundView = [[TextFiledBackgroundView alloc] initWithFrame:CGRectMake(10, 10, 300, 120) withColor:LOAD_SEPERATE_COLOR withImage:imgArr];
    [self.view addSubview:backgroundView];
    
    [self initTextInfo];
    
    UIButton *finishBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, 300, 40)];
    [finishBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    //[finishBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishChangePwd:) forControlEvents:UIControlEventTouchUpInside];
    finishBtn.layer.cornerRadius = 5;
    [self.view addSubview:finishBtn];
	// Do any additional setup after loading the view.
}

- (void)initTextInfo
{
    oldPwdText = [[UITextField alloc] initWithFrame:CGRectMake(50, 0, 249, 40)];
    oldPwdText.returnKeyType = UIReturnKeyDone;
    [self setTextField:oldPwdText withPlaceholder:@"请输入原密码" withSecure:YES];
    
    newPwdText = [[UITextField alloc] initWithFrame:CGRectMake(50, 40, 249, 40)];
    newPwdText.returnKeyType = UIReturnKeyDone;
    [self setTextField:newPwdText withPlaceholder:@"请输入新密码，6-32位" withSecure:YES];
    
    confirPwdText = [[UITextField alloc] initWithFrame:CGRectMake(50, 80, 249, 40)];
    confirPwdText.returnKeyType = UIReturnKeyDone;
    [self setTextField:confirPwdText withPlaceholder:@"请确认新密码" withSecure:YES];
}

- (void)setTextField:(UITextField*)textField withPlaceholder:(NSString*)title withSecure:(BOOL)isSecure
{
    textField.placeholder = title;
    textField.font = [UIFont systemFontOfSize:14];
    textField.delegate = self;
    if (isSecure)
    {
        textField.secureTextEntry = YES;
    }
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [backgroundView addSubview:textField];
}

- (void)finishChangePwd:(id)sender
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
            userElement = [[SharedUserDefault sharedInstance] getUserInfo];
            
            NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
            [mulDic setObject:userElement.userCode forKey:@"userCode"];
            [mulDic setObject:userElement.sessionId forKey:@"sid"];
            [mulDic setObject:[[oldPwdText text] md5] forKey:@"passWord"];
            [mulDic setObject:[[newPwdText text] md5] forKey:@"newPwd"];
            [HttpRequestComm updatePassWord:mulDic withDelegate:self];
        }
    }
}

- (BOOL)checkUserInfo
{
    if ([oldPwdText text] == nil || [[oldPwdText text] isEqualToString:@""])
    {
        [self showToast:@"请输入原密码"];
        return NO;
    }
    else
    {
        if ([[oldPwdText text] length] < 6 || [[oldPwdText text] length] > 32)
        {
            [self showToast:@"密码长度必须为6-32个字符"];
            return NO;
        }
    }
    
    if ([newPwdText text] == nil || [[newPwdText text] isEqualToString:@""])
    {
        [self showToast:@"请输入新密码"];
        return NO;
    }
    else
    {
        if ([[newPwdText text] length] < 6 || [[newPwdText text] length] > 32)
        {
            [self showToast:@"密码长度必须为6-32个字符"];
            return NO;
        }
    }
    
    if ([confirPwdText text] == nil || [[confirPwdText text] isEqualToString:@""])
    {
        [self showToast:@"请二次输入新密码"];
        return NO;
    }
    else
    {
        if (![[confirPwdText text] isEqualToString:[newPwdText text]])
        {
            [self showToast:@"两次密码输入不一致"];
            return NO;
        }
    }
    return YES;
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

# pragma mark HttpRequestCommDelegate
//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam
{
    [SVProgressHUD dismiss];
    //NSLog(@"Veritify code get success %@,%@,%@",inParam,[[inParam objectForKey:@"result"] objectForKey:@"code"],[[inParam objectForKey:@"result"] objectForKey:@"msg"]);
    if (inParam == nil)
    {
        [self showToast:@"网络异常，请稍后再试"];
    }
    else
    {
        if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self showToast:[[inParam objectForKey:@"result"] objectForKey:@"msg"]];
        }
    }
}

//网络请求失败协议方法
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error
{
    [SVProgressHUD dismiss];
    [self showToast:@"网络异常，请稍后再试"];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}
@end
