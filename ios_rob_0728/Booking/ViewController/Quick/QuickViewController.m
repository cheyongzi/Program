//
//  QuickViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "QuickViewController.h"
#import "ShopMapViewController.h"
#import "SearchKTVViewController.h"

/*
 * 快速预定的ViewController
 */
@interface QuickViewController ()

@end

@implementation QuickViewController

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
    self.title = @"快速预定";
//    [self.view addSubview:[self bottomRefreshView:0]];
    
    //初始化BMKLocationService
    self.locService = [[BMKLocationService alloc] init];
    self.locService.delegate = self ;
    [self.locService startUserLocationService];
    
    self.search = [[BMKGeoCodeSearch alloc] init];
    self.search.delegate = self ;
    
    //设置上一次的位置地址
    NSString *address = [[SharedUserDefault sharedInstance] getCurrentAddress];
    self.locLa.text = address;
    
    //添加条件筛选框
//    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 80, 280, 265)];
//    self.alertView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:self.alertView];
}


-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addNavigationBarRightViews]; 
}

/*
 * 添加导航栏右部菜单选项
 */
-(void) addNavigationBarRightViews {
    
    UIButton *btnf = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -35, 0, 35, 44)];
    btnf.tag = 100 ;
    [btnf setImage:[UIImage imageNamed:@"com_search"] forState:UIControlStateNormal];
    [btnf addTarget:self action:@selector(rightViewClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btns = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 35*2, 0, 35, 44)];
    btns.tag = 101 ;
    [btns setImage:[UIImage imageNamed:@"com_map"] forState:UIControlStateNormal];
    [btns addTarget:self action:@selector(rightViewClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:btnf];
    [self.navigationController.navigationBar addSubview:btns];
}

/*
 * 顶部导航栏右部菜单事件方法
 */
-(void) rightViewClickEvent:(id) sender {
    /*
     * 100 搜索按钮
     * 101 地图
     */
    UIButton *btn = (UIButton *)sender ;
    NSInteger tagValue = btn.tag ;
    switch (tagValue) {
        case 100:{
            SearchKTVViewController *searchCon = [[SearchKTVViewController alloc] init];
            [self.navigationController pushViewController:searchCon animated:YES];
        }
            break;
        case 101:{
            ShopMapViewController *shopMapCon = [[ShopMapViewController alloc] init];
            [self.navigationController pushViewController:shopMapCon animated:YES];
        }
            break;
    }
}

/*
 * 条件筛选事件按钮
 */
-(IBAction)topMenuClickEvent:(id)sender {
    /*
     * 102 区域位置
     * 103 全部时段
     * 104 离我最近
     * 105 位置信息刷新
     * 106 条件筛选
     */
    UIButton *btn = (UIButton *) sender ;
    NSInteger tagValue = btn.tag ;
    switch (tagValue) {
        case 102:{
            
        }
            
            break;
        case 103:{
            
        }
            break;
        case 104:{
            
        }
            break;
        case 105:{
            [self.locService startUserLocationService];
        }
            break;
        case 106:{
            
//            if(self.isExtend){
//                [UIView beginAnimations:@"view" context:nil];
//                self.alertView.frame = CGRectMake(SCREEN_WIDTH, self.alertView.frame.origin.y, self.alertView.frame.size.width, self.alertView.frame.size.height);
//                [UIView commitAnimations];
//            }else{
//                [UIView beginAnimations:@"view" context:nil];
//                self.alertView.frame = CGRectMake(60, self.alertView.frame.origin.y, self.alertView.frame.size.width, self.alertView.frame.size.height);
//                [UIView commitAnimations];
//            }
            self.isExtend = !self.isExtend ;
        }
            break;
            
    }
}


#pragma mark -BMKLocationServiceDelegate
-(void) didUpdateUserHeading:(BMKUserLocation *)userLocation {
    NSLog(@"----------Heading%f---%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if(userLocation != nil){
        if(userLocation.location.coordinate.latitude != 0){
            BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
            reversePotion.reverseGeoPoint = userLocation.location.coordinate ;
            [self.search reverseGeoCode:reversePotion];
            [self.locService stopUserLocationService];
        }else{
            [self.locService startUserLocationService];
        }
    }
}

-(void) didUpdateUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"----------UserLocation%f---%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
//    [self.locService stopUserLocationService];
    
}

#pragma mark _BMKGeocodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetNumber];
    [[SharedUserDefault sharedInstance] setCurrentAddress:address];
    self.locLa.text = address;
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self.navigationController.navigationBar viewWithTag:100] removeFromSuperview];
    [[self.navigationController.navigationBar viewWithTag:101] removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
