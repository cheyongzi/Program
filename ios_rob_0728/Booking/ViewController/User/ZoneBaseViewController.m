//
//  ZoneBaseViewController.m
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ZoneBaseViewController.h"
#import "UserAccountEditViewController.h"

@interface ZoneBaseViewController ()

@end

@implementation ZoneBaseViewController

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
    
    [self addNavigationBarRightView];
	// Do any additional setup after loading the view.
}

-(void) addNavigationBarRightView {
    UIButton *rightf = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 40)];
    [rightf setImage:[UIImage imageNamed:@"userSetting.png"] forState:UIControlStateNormal];
    UIBarButtonItem *itemf = [[UIBarButtonItem alloc] initWithCustomView:rightf];
    [rightf addTarget:self action:@selector(rightItemClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = itemf;
}

/*
 * NavigationBar 右视图按钮事件方法
 */
-(void) rightItemClickEvent:(id) sender
{
    UserAccountEditViewController *accountEditController = [[UserAccountEditViewController alloc] init];
    [self.navigationController pushViewController:accountEditController animated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
