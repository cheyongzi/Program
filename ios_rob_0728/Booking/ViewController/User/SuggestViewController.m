//
//  SuggestViewController.m
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "SuggestViewController.h"
#import "ConstantField.h"

@interface SuggestViewController ()<UITextViewDelegate>

@end

@implementation SuggestViewController

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
    
    self.title = @"意见反馈";
    
    text_view = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 200)];
    text_view.delegate = self;
    text_view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    text_view.layer.borderWidth = 1;
    [self.view addSubview:text_view];
    
    UIButton *loadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 220, 300, 40)];
    [loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    [loadBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
    [loadBtn setTitle:@"确定" forState:UIControlStateNormal];
    [loadBtn addTarget:self action:@selector(confirmSuggest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
	// Do any additional setup after loading the view.
}

- (void)confirmSuggest:(id)sender
{
    //向服务器提交意见
    if ([text_view text] == nil || [[text_view text] isEqualToString:@""])
    {
        [self showToast:@"请输入反馈意见"];
    }
    else
    {
        if (![ConUtils checkUserNetwork])
        {
            [self showToast:@"网络异常，请稍后再试"];
        }
        else
        {
            [HttpRequestComm commitSuggestion:[text_view text] withDelegate:self];
        }
    }
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
    [self showToast:@"网络异常，请稍后再试"];
}

#pragma mark UITextFieldDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
