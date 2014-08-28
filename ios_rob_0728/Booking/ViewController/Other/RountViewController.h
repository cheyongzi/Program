//
//  RountViewController.h
//  Booking
//
//  Created by jinchenxin on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BMapKit.h"

@interface RountViewController : BaseViewController<BMKMapViewDelegate,BMKRouteSearchDelegate>

@property (strong ,nonatomic) BMKMapView *mapView ;
@property (strong ,nonatomic) BMKRouteSearch *routesearch;

@property (strong ,nonatomic) NSString *lautitude ;
@property (strong ,nonatomic) NSString *longitude ;

@end
