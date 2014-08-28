//
//  ShopMapViewController.h
//  Booking
//
//  Created by jinchenxin on 14-6-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "BMKMapView.h"
#import "BMKMapViewEx.h"
#import "KTVPointAnnotation.h"
#import "KTVBubbleView.h"

@interface ShopMapViewController : BaseViewController<BMKMapViewDelegate,CustomBubbleProtocol>

@property (strong ,nonatomic) BMKMapViewEx *mapView ;
@property (strong ,nonatomic) KTVBubbleView *bubbleView ;

@end
