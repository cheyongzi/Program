//
//  PositionMapController.m
//  Booking
//
//  Created by jinchenxin on 14-6-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "PositionMapController.h"
#import "SharedUserDefault.h"

@interface PositionMapController ()

@end

@implementation PositionMapController

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
    self.title = @"地图";
    
//    self.bubbleView = [[KTVBubbleView alloc] init];
    self.bubbleView = [[[NSBundle mainBundle] loadNibNamed:@"KTVBubbleView" owner:self options:nil] objectAtIndex:0];
    
    self.locService = [[BMKLocationService alloc] init];
    self.locService.delegate = self ;
    [self.locService startUserLocationService];
    
    self.search = [[BMKGeoCodeSearch alloc] init];
    self.search.delegate = self ;
    
    self.mapView = [[BMKMapViewEx alloc] initWithFrame:self.view.frame];
    self.mapView.showsUserLocation = YES ;
    self.mapView.delegate = self ;
    self.mapView.bubbleDelegate = self ;
    self.mapView.zoomLevel = 16 ;
    self.view = self.mapView ;
    //    [self.view addSubview:self.bubbleView];
    
    NSString *latitude = [[SharedUserDefault sharedInstance] getLatitude];
    NSString *longitude = [[SharedUserDefault sharedInstance] getLongitude];
    CLLocationCoordinate2D coordinate = {latitude.doubleValue,longitude.doubleValue};
    [self.mapView setCenterCoordinate:coordinate];
    
}

-(void) addKTVShopAnnotion:(CLLocationCoordinate2D) coordinate {
    if(self.item != nil) [self.mapView removeAnnotation:self.item];
    self.item = [[KTVPointAnnotation alloc] init];
    self.item.tag = 110;
    self.item.title = @"asf";
    self.item.coordinate = coordinate;
    [self.mapView addAnnotation:self.item];
    [self.mapView selectAnnotation:self.item animated:YES];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

-(BMKAnnotationView *) mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    BMKAnnotationView *annotationView = [mapView viewForAnnotation:annotation];
    if(annotationView == nil){
        KTVPointAnnotation *ann ;
        NSInteger tag = 100 ;
        if([annotation isKindOfClass:[KTVPointAnnotation class]]){
            ann = annotation ;
            tag = ann.tag ;
        }
        
        annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@""];
        [annotationView.paopaoView removeFromSuperview];
        annotationView.image = [UIImage imageNamed:@"h_near"];
        annotationView.canShowCallout = NO ;
    }
    return annotationView ;
}

-(void) mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    for (id<BMKAnnotation> an in self.mapView.annotations) {
        if([an isKindOfClass:[KTVPointAnnotation class]]){
            KTVPointAnnotation *kyan = (KTVPointAnnotation *)an ;
            if(kyan.tag == [(KTVPointAnnotation *)[view annotation] tag]){
                [self.mapView mapView:self.mapView didSelectAnnotationView:[self.mapView viewForAnnotation:kyan]];
                break;
            }
        }
    }
    NSLog(@"----DIDSELECTANNOTATIONVIEW-----");
}

-(UIView *) customBubbleForAnnotation:(KTVPointAnnotation *)annotation {
    //手势事件的添加方法
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapClickEvent:)];
    [self.bubbleView addGestureRecognizer:gestureRecognizer];
    return self.bubbleView ;
}

-(void) mapClickEvent:(id) sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:SELECTEADDRESS object:self.bubbleView.addressLa.text];
    [self popViewController];
}

/*
 * 地图单击事件
 */
-(void) mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
    reversePotion.reverseGeoPoint = coordinate ;
    [self.search reverseGeoCode:reversePotion];
    [self addKTVShopAnnotion:coordinate];
    
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
            
            //定位成功后保存当前的位置信息
            SharedUserDefault *shared = [SharedUserDefault sharedInstance];
            [shared setLatitudeAndLongitude:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] andLat:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude]];
            [self addKTVShopAnnotion:userLocation.location.coordinate];
        }else{
            [self.locService startUserLocationService];
        }
    }
}

#pragma mark _BMKGeocodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetNumber];
    self.bubbleView.addressLa.text = address ;
    
}


-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
