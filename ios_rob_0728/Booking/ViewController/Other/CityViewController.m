//
//  CityViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "CityViewController.h"
#import "SharedUserDefault.h"
#import "CityCell.h"

@interface CityViewController ()

@end

@implementation CityViewController

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
    self.title = @"城市选择";
    
    self.provincesAry = [[SharedUserDefault sharedInstance] getProvincesList];
    self.cityAry = [[SharedUserDefault sharedInstance] getCityList];
    self.proCityListDic = [[SharedUserDefault sharedInstance] getProvinceCitysList];
}

#pragma  mark -UITableViewDelegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [[[self.provincesAry objectAtIndex:section] allKeys] objectAtIndex:0];
    NSMutableArray *citys = [[NSMutableArray alloc]init];
    citys = [self.proCityListDic objectForKey: key];
    return [citys count] ;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.provincesAry count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44 ;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.9;
    UILabel *titleLa = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, 44)];
    titleLa.backgroundColor = [UIColor clearColor];
    titleLa.font = [ConUtils boldAndSizeFont:18];
    NSString *key = [[[self.provincesAry objectAtIndex:section] allKeys] objectAtIndex:0];
    titleLa.text = [[self.provincesAry objectAtIndex:section] objectForKey:key];
    [view addSubview:titleLa];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityCell *cell = nil;
    if(cell == nil) {        
        NSString *key = [[[self.provincesAry objectAtIndex:indexPath.section] allKeys] objectAtIndex:0];
        NSArray *citys =[self.proCityListDic objectForKey:key];
        NSDictionary *cityDic = [citys objectAtIndex:indexPath.row];
        NSString *cityKey = [[cityDic allKeys]objectAtIndex:0];
        NSString *cityName = [cityDic objectForKey:cityKey];
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        cell.textLabel.text = cityName;
        cell.cityDic = cityDic ;
  
    }
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CityCell *cell = (CityCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *cityDic = cell.cityDic ;
    NSString *key = [[cityDic allKeys] objectAtIndex:0];
    NSString *cityCode = [[SharedUserDefault sharedInstance] getCityCode:[cityDic objectForKey:key]];
    NSDictionary *resultDic = [[NSDictionary alloc] initWithObjectsAndKeys:[cityDic objectForKey:key],cityCode, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:CITYSELECTEREFRESH object:resultDic];
    [self popViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
