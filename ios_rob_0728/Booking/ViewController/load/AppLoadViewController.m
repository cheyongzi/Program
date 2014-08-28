//
//  AppLoadViewController.m
//  Booking
//
//  Created by 1 on 14-6-27.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AppLoadViewController.h"
#import "ConstantField.h"
#import "BaseViewController.h"
#import "SharedUserDefault.h"
#import "HomeMapViewController.h"

@interface AppLoadViewController ()

@end

@implementation AppLoadViewController

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
    
    array = [NSArray arrayWithObjects:@"appLoad1.jpg",@"appLoad2.jpg",@"appLoad3.jpg", nil];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT);
    myScrollView.delegate = self;
    myScrollView.bounces = NO;
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(SCREEN_WIDTH*0.5, APPLICATION_HEIGHT-30);
    pageControl.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    pageControl.numberOfPages = 3;
    [self.view addSubview:pageControl];
    
    [self initScrollViewContent];
	// Do any additional setup after loading the view.
}

- (void)initScrollViewContent
{
    for (int i=0; i<3; i++)
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        img.userInteractionEnabled = YES;
        [img setBackgroundColor:[UIColor clearColor]];
        [img setImage:[UIImage imageNamed:[array objectAtIndex:i]]];
        [img setUserInteractionEnabled:YES];
        [myScrollView addSubview:img];
        if (i == 2) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [img addGestureRecognizer:tapGesture];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture
{
    [self mapViewController];
}

- (void)mapViewController
{
    UINavigationController *rootCon = [[UINavigationController alloc]init];
    
    HomeMapViewController *homeMapCon = [[HomeMapViewController alloc] init];
    [rootCon addChildViewController:homeMapCon];
    
    [[SharedUserDefault sharedInstance] setFirstStartApp:@"N"];
    
    [self presentViewController:rootCon animated:NO completion:^(void){}];
}

#pragma mark UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (page==2)
    {
        [self mapViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
