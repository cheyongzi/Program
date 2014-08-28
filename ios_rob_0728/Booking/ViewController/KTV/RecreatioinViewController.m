//
//  RecreatioinViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "RecreatioinViewController.h"
/*
 * 娱人广场ViewController
 */
@interface RecreatioinViewController ()

@end

@implementation RecreatioinViewController

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
    self.title = @"娱人广场";
    [self.view addSubview:[self bottomRefreshView:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
