//
//  UserProtocalViewController.m
//  Booking
//
//  Created by 1 on 14-6-30.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UserProtocalViewController.h"

@interface UserProtocalViewController ()

@end

@implementation UserProtocalViewController

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
    
    self.title = @"微歌用户协议";
    
    CGSize size = [[UIScreen mainScreen] applicationFrame].size;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"protocol" ofType:@"html"];
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:encode error:nil];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 44)];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    [self.view addSubview:webView];
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicatorView setFrame:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0)];
    [self.view addSubview:indicatorView];
	// Do any additional setup after loading the view.
}

#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [indicatorView stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
