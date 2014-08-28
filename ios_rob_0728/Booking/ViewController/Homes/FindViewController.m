//
//  FindViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

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
    [self.view addSubview:[self bottomRefreshView:0]];
}

-(void) viewWillAppear:(BOOL)animated {
    self.parentViewController.title = @"发现";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
