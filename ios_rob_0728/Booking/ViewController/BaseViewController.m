//
//  BaseViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"

/*
 * 控制器基类
 */
@interface BaseViewController (){
    NSInteger pointCounts ;
}

@end

@implementation BaseViewController

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
    [self.navigationItem setHidesBackButton:YES];
//    [self setNavigationBarBackground];
//    UIImageView *bgImg = [[UIImageView alloc] init];
//    bgImg.frame = self.view.frame ;
//    bgImg.image = [UIImage imageNamed:@"all_bg_ic.jpg"];
//    [self.view insertSubview:bgImg atIndex:0];
//    [self.view setBackgroundColor:[UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"all_bg_ic.jpg"]];
}

-(void) viewWillAppear:(BOOL)animated {
    [self addNavigationBarBack];
}


/*
 * 返回上一个ViewController
 */
-(void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 底部刷新视图
 * @param type 刷新状态类型
 */
-(UIView *) bottomRefreshView:(NSInteger) type {
    UIView *boView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    boView.clipsToBounds = YES;
    UIImageView *loadingImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_loading"]];
    
    UIView *fbgView = [[UIView alloc] init];
    loadingImg.frame = CGRectMake(70, 0, loadingImg.frame.size.width, loadingImg.frame.size.height);
    fbgView.clipsToBounds = YES;
    fbgView.backgroundColor = [UIColor grayColor];
    fbgView.frame = loadingImg.frame ;
        
    self.sbgView = [[UIView alloc] init];
    self.sbgView.backgroundColor = [UIColor colorWithRed:0.867 green:0.078 blue:0.251 alpha:1];
    self.sbgView.frame = CGRectMake(0, fbgView.frame.size.height-4, loadingImg.frame.size.width, loadingImg.frame.size.height);
    
    self.desLa = [[UILabel alloc] initWithFrame:CGRectMake(120, 8, 200, 25)];
    self.desLa.text = @"正在加载数据…";
    self.desLa.font = [ConUtils boldAndSizeFont:16];
    self.desLa.backgroundColor = [UIColor clearColor];
    self.desLa.textColor = [UIColor colorWithRed:0.557 green:0.557 blue:0.557 alpha:1];
    [boView addSubview:self.desLa];
    
    [boView addSubview:fbgView];
    [fbgView addSubview:self.sbgView];
    [boView addSubview:loadingImg];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
    
    return boView ;
}

-(void)updateProgress:(id) obj {
    if(self.sbgView.frame.origin.y <5){
        self.sbgView.frame = CGRectMake(0, self.sbgView.frame.size.height-4, self.sbgView.frame.size.width, self.sbgView.frame.size.height);
    }else if(self.sbgView.frame.origin.y >self.sbgView.frame.size.height){
        self.sbgView.frame = CGRectMake(0, self.sbgView.frame.size.height-4, self.sbgView.frame.size.width, self.sbgView.frame.size.height);
    }else{
       self.sbgView.frame = CGRectMake(0, self.sbgView.frame.origin.y-1, self.sbgView.frame.size.width, self.sbgView.frame.size.height);
    }
    
    if(pointCounts > 0 && pointCounts < 5){
        self.desLa.text = @"正在加载数据.";
    }else if(pointCounts > 5 && pointCounts <10){
        self.desLa.text = @"正在加载数据..";
    }else if(pointCounts >10 && pointCounts<=15) {
        self.desLa.text = @"正在加载数据...";
        if(pointCounts == 15)
            pointCounts = 0 ;
    }
    pointCounts ++ ;
    
}

-(void) addNavigationBarBack {
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    
//    UIImageView *separateView = [[UIImageView alloc] initWithFrame:CGRectMake(44, 0, 2, 44)];
//    [separateView setImage:[UIImage imageNamed:@"navSeparateLine.png"]];
//    [self.navigationController.navigationBar addSubview:separateView];
    
    self.navigationItem.backBarButtonItem = nil ;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"new_com_back.png"] forState:UIControlStateNormal];
    backBtn.tag = 1000 ;
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:backBtn];
    
}

/*
 * 显示用户信息提示框
 */
- (void)showToast:(NSString *) msg  {
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 5 ;
    view.tag = 600 ;
    CGFloat width = [ConUtils labelWidth:msg withFont:[UIFont systemFontOfSize:15]];
    view.frame = CGRectMake(0, 0, width+30, 50);
    view.backgroundColor = [UIColor blackColor];
    view.center = CGPointMake(320/2, SCREEN_HEIGHT/2+80);
    UILabel *msgLa = [[UILabel alloc] init];
    msgLa.frame = CGRectMake(0, 0, width+30, 50) ;
    msgLa.text = msg ;
    msgLa.textAlignment = NSTextAlignmentCenter ;
    msgLa.font = [ConUtils boldAndSizeFont:15];
    msgLa.backgroundColor = [UIColor clearColor];
    msgLa.textColor = INFO_TEXT_COLOR;
    [view addSubview:msgLa];
    
    [self.view addSubview:view];
    
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dismissToastView) userInfo:nil repeats:NO];
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void)
     {
         [view setAlpha:0.8];
     }completion:^(BOOL finished)
     {
         [view removeFromSuperview];
     }];
}

-(void) dismissToastView {
    [[self.view viewWithTag:600] removeFromSuperview];
}

-(void) viewWillDisappear:(BOOL)animated {
    [[self.navigationController.navigationBar viewWithTag:1000] removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HttpRequestDelegate

- (void)httpRequestSuccessComm:(int)tagId withInParams:(id)inParam
{
    
}

- (void)httpRequestFailueComm:(int)tagId withInParams:(NSString *)error
{
    
}

@end
