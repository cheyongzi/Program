//
//  MoreSettingViewController.m
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "MoreSettingViewController.h"
#import "SuggestViewController.h"
#import "CacheViewController.h"
#import "AboutViewController.h"
#import "ConstantField.h"

@interface MoreSettingViewController ()

@end

@implementation MoreSettingViewController

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
    
    self.title = @"更多设置";
    
    imgArr = [NSArray arrayWithObjects:@"suggest.png",@"clearCache.png",@"aboutUs.png", nil];
    titleArr = [NSArray arrayWithObjects:@"意见反馈",@"清理缓存",@"关于我们", nil];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, 300, 150) style:UITableViewStylePlain];
    [myTableView setBackgroundColor:[UIColor clearColor]];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.layer.borderWidth = 1;
    myTableView.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.bounces = NO;
    [self.view addSubview:myTableView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imgArr count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentify = @"MoreSettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    cell.textLabel.text = [titleArr objectAtIndex:[indexPath row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    cell.imageView.image = [UIImage imageNamed:[imgArr objectAtIndex:[indexPath row]]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 300, 1)];
    [seperateLine setBackgroundColor:LOAD_SEPERATE_COLOR];
    [cell addSubview:seperateLine];
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath row] == 0) {
        SuggestViewController *sugCon = [[SuggestViewController alloc] init];
        [self.navigationController pushViewController:sugCon animated:YES];
    }
    else if ([indexPath row] == 1)
    {
        CacheViewController *cacheCon = [[CacheViewController alloc] init];
        [self.navigationController pushViewController:cacheCon animated:YES];
    }
    else if ([indexPath row] == 2)
    {
        AboutViewController *aboutCon = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutCon animated:YES];
    }
}

@end
