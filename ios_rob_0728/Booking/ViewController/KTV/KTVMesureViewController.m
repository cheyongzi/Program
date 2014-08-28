//
//  KTVMesureViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "KTVMesureViewController.h"
#import "KTVMesureCell.h"
#import "KTVDetailsViewController.h"
/*
 * KTV 量贬VeiwController
 */
@interface KTVMesureViewController ()

@end

@implementation KTVMesureViewController

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
    self.title = @"KTV量贬";
//    [self.view addSubview:[self bottomRefreshView:0]];
}


#pragma  mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KTVMesureCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KTVMesureCell" owner:self options:nil] objectAtIndex:0];
    }
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    KTVDetailsViewController *ktvDetailsCon = [[KTVDetailsViewController alloc] init];
    [self.navigationController pushViewController:ktvDetailsCon animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
