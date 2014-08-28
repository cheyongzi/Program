//
//  CacheViewController.m
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "CacheViewController.h"
#import "ConstantField.h"

@interface CacheViewController ()

@end

@implementation CacheViewController

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
    
    self.title = @"缓存清理";
    
    imgArr = [NSArray arrayWithObjects:@"imgClear.png",@"dataClear.png", nil];
    titleArr = [NSArray arrayWithObjects:@"清除图片",@"清除数据", nil];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, 300, 100) style:UITableViewStylePlain];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.layer.borderWidth = 1;
    myTableView.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
    myTableView.bounces = NO;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath row] == 0)
    {
        //清理图片缓存
        
    }
    else if ([indexPath row] == 1)
    {
        //清理数据缓存
    }
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentify = @"ClearCacheCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    cell.textLabel.text = [titleArr objectAtIndex:[indexPath row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    cell.imageView.image = [UIImage imageNamed:[imgArr objectAtIndex:[indexPath row]]];
    if ([indexPath row] != ([imgArr count]-1)) {
        UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 300, 1)];
        [seperateLine setBackgroundColor:LOAD_SEPERATE_COLOR];
        [cell addSubview:seperateLine];
    }
    return cell;
}

@end
