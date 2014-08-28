//
//  HomeMapViewController.h
//  Booking
//
//  Created by jinchenxin on 14-7-7.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "BMapKit.h"
#import "KTVBubbleView.h"
#import "BMKLocationService.h"
#import "ProviderResponse.h"
#import "KTVPointAnnotation.h"
#import "UIMenuButton.h"

@interface HomeMapViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,UITextFieldDelegate,BMKGeoCodeSearchDelegate>

@property (strong ,nonatomic) BMKMapView *mapView ;
@property (strong ,nonatomic) BMKLocationService *locService ;
@property (nonatomic) BOOL isFirstShow ;
@property (nonatomic) BOOL isFirstScrope ;
@property (nonatomic) BOOL isRefreshData ;
@property (strong ,nonatomic) NSMutableArray *proAry ;
@property (strong ,nonatomic) NSMutableDictionary *paramDic ;
@property (strong ,nonatomic) ProviderResponse *proResponse ;
@property (strong ,nonatomic) KTVPointAnnotation *localAnnotation ;
@property (strong ,nonatomic) UIImageView *circleImg ;
@property (strong ,nonatomic) KTVBubbleView *paopaoView ;
@property (strong ,nonatomic) UIMenuButton *curMenuBtn ;
@property (strong ,nonatomic) UIButton *sendBtn ;
@property (strong ,nonatomic) UIView *sendView ;
@property (strong ,nonatomic) UIImageView *searchImg ;
@property (strong ,nonatomic) UIButton *searchBtn ;
@property (strong ,nonatomic) UITextField *searchTf ;
@property (nonatomic) BOOL isLocation ;
@property (strong ,nonatomic) NSString *shopType ;
@property (nonatomic) NSInteger currentPosition ;
@property (strong ,nonatomic) NSMutableArray *shopsAry ;
@property (strong ,nonatomic) NSString *shopId ;
@property (strong ,nonatomic) BMKGeoCodeSearch *search ;

@property (strong ,nonatomic) BMKMapManager *manager;

@property (assign ,nonatomic) CLLocationCoordinate2D locationCoordinate;



@end
