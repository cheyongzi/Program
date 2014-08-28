//
//  KTVDetailsViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "KTVDetailsViewController.h"
#import "KTVDetailsFCell.h"

@interface KTVDetailsViewController ()

@end

@implementation KTVDetailsViewController

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
    self.title = @"商品详情";
}

#pragma  mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KTVDetailsFCell *fCell = [tableView dequeueReusableCellWithIdentifier:@""];
    
    if(fCell == nil){
        fCell = [[[NSBundle mainBundle] loadNibNamed:@"KTVDetailsFCell" owner:self options:nil] objectAtIndex:0];
    }
    
    return fCell ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
