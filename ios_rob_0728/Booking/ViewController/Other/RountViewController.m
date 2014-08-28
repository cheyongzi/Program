//
//  RountViewController.m
//  Booking
//
//  Created by jinchenxin on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "RountViewController.h"
#import "SharedUserDefault.h"
#import "BMKRouteSearch.h"


@interface RountViewController ()

@end

@implementation RountViewController

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
    self.title = @"导航路径搜索中...";
    self.mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
//    self.mapView.delegate = self;
    self.view = self.mapView ;
    [self startNavigation];
}

-(void) startNavigation {
    
    NSString *latitude = [[SharedUserDefault sharedInstance] getLatitude];
    NSString *longitude = [[SharedUserDefault sharedInstance] getLongitude];
    CLLocationCoordinate2D coordinate = {latitude.doubleValue,longitude.doubleValue};
    BMKPlanNode * startNode = [[BMKPlanNode alloc] init];
    startNode.pt = coordinate ;  //设置路径起点
    
    CLLocationCoordinate2D startLoc ;
    CLLocationCoordinate2D endLoc ;
    
#if TARGET_IPHONE_SIMULATOR
    startLoc = (CLLocationCoordinate2D){39.915101, 116.403981};
    endLoc = (CLLocationCoordinate2D){40.056957, 116.307827};
#else
    startLoc = (CLLocationCoordinate2D){39.915101, 116.403981};
    endLoc = (CLLocationCoordinate2D){40.056957, 116.307827};
#endif
    
    startNode.pt = startLoc ;
    
    [self.mapView region] ;//设置地图可调整范围
    self.mapView.centerCoordinate = startLoc ;
    
    BMKPlanNode *endNode = [[BMKPlanNode alloc] init];
    endNode.pt = endLoc;
    
    BMKRouteSearch *search = [[BMKRouteSearch alloc]init];
//    search.delegate = self ;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
