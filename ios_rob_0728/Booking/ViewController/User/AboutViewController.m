//
//  AboutViewController.m
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AboutViewController.h"
#import "ConstantField.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    
    self.title = @"关于我们";
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 10, 310, 120)];
    [textView setText:@"    微歌娱乐是湖南蓝创信息技术有限公司旗下核心产品，蓝创信息致力于成为中国娱乐服务O2O平台方案解决商和提供商之一，总部位于有“娱乐之都”美誉的星城长沙"];
    [textView setFont:[UIFont systemFontOfSize:15]];
    [textView setBackgroundColor:[UIColor clearColor]];
    textView.userInteractionEnabled = NO;
    [self.view addSubview:textView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 20)];
    [label setText:@"地       址: 长沙天心区芙蓉中路168号摩天大厦一座28楼"];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 300, 20)];
    [label1 setText:@"商务热线: "];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [label1 setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:label1];
    
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    telBtn.frame = CGRectMake(68, 140, 240, 20);
    [telBtn setTitle:@"4009908823" forState:UIControlStateNormal];
    [telBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [telBtn addTarget:self action:@selector(telBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [telBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    telBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:telBtn];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 60, 20)];
    [label2 setText:@"网       址: "];
    [label2 setBackgroundColor:[UIColor clearColor]];
    [label2 setTextAlignment:NSTextAlignmentLeft];
    [label2 setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:label2];
    
    UIButton *webBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    webBtn.frame = CGRectMake(68, 160, 240, 20);
    [webBtn setTitle:@"http://www.weigee.net" forState:UIControlStateNormal];
    [webBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [webBtn addTarget:self action:@selector(webBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [webBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    webBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:webBtn];
	// Do any additional setup after loading the view.
}

- (void)telBtnClick:(id)sender
{
    UIButton *tel = (UIButton*)sender;
    NSString *phoneNumber = tel.titleLabel.text;
    NSString *phoneString = [NSString stringWithFormat:@"telprompt:%@",phoneNumber];
    NSURL    *phoneUrl = [NSURL URLWithString:phoneString];
    [[UIApplication sharedApplication] openURL:phoneUrl];
}

- (void)webBtnClick:(id)sender
{
    UIButton *web = (UIButton*)sender;
    NSURL *url = [NSURL URLWithString:web.titleLabel.text];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
