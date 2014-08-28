//
//  PositionMapController.h
//  Booking
//
//  Created by jinchenxin on 14-6-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "BMKMapViewEx.h"
#import "BMKLocationService.h"
#import "BMKGeocodeSearch.h"
#import "KTVPointAnnotation.h"
#import "KTVBubbleView.h"

@interface PositionMapController : BaseViewController<BMKMapViewDelegate,CustomBubbleProtocol,BMKLocationServiceDelegate ,BMKGeoCodeSearchDelegate>

@property (strong ,nonatomic) BMKMapViewEx *mapView ;
@property (strong ,nonatomic) KTVBubbleView *bubbleView ;
@property (strong ,nonatomic) BMKLocationService *locService ;
@property (strong ,nonatomic) BMKGeoCodeSearch *search ;
@property (strong ,nonatomic) KTVPointAnnotation *item ;

@end
