//
//  ShopMapViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ShopMapViewController.h"
#import "SharedUserDefault.h"


@interface ShopMapViewController ()

@end

@implementation ShopMapViewController

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
    
    self.bubbleView = [[KTVBubbleView alloc] init];
    self.bubbleView = [[[NSBundle mainBundle] loadNibNamed:@"KTVBubbleView" owner:self options:nil] objectAtIndex:0];

    self.mapView = [[BMKMapViewEx alloc] initWithFrame:self.view.frame];
    self.mapView.showsUserLocation = YES ;
    self.mapView.delegate = self ;
    self.mapView.bubbleDelegate = self ;
    self.view = self.mapView ;
//    [self.view addSubview:self.bubbleView];
    [self addKTVShopAnnotion];
}

-(void) addKTVShopAnnotion {
    
    NSString *latitude = [[SharedUserDefault sharedInstance] getLatitude];
    NSString *longitude = [[SharedUserDefault sharedInstance] getLongitude];
    
    CLLocationCoordinate2D coordinate = {latitude.doubleValue,longitude.doubleValue};
    KTVPointAnnotation *item = [[KTVPointAnnotation alloc] init];
    item.tag = 110;
    item.title = @"asf";
//    item.shopInfo = shopDic;
    item.coordinate = coordinate;
//    item.title = @"kankan";
    [self.mapView addAnnotation:item];
    [self.mapView selectAnnotation:item animated:YES];
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
//        annotationView.centerOffset = CGPointMake(0, -50);
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
    NSLog(@"-------------");
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
