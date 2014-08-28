//
//  HomeMapViewController.m
//  Booking
//
//  Created by jinchenxin on 14-7-7.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

enum SHOPTYPEENUM{
    KTVTYPE = 0 ,
    BARTYPE,
    YCTYPE,
};

#import "HomeMapViewController.h"
#import "SharedUserDefault.h"
#import "MerchantSearchController.h"
#import "OrderCenterViewController.h"
#import "PriceMySelfViewController.h"
#import "UserLoadViewController.h"
#import "UserZoneMainViewController.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "GuideView.h"

@interface HomeMapViewController ()
{
    NSArray *paramArray;
    BOOL    isSearch;
    ProviderElement *searchElement;
    GuideView   *guideView;
}
@end

@implementation HomeMapViewController

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
    self.title = @"您出价,KTV抢单";
    [self setNavigationBarBackground];
    
    if ([[SharedUserDefault sharedInstance] getSystemParam]!=nil)
    {
        paramArray = [[SharedUserDefault sharedInstance] getSystemType:@"ShopType"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCustomViewOne:) name:kReachabilityChangedNotification object:nil];
    
    self.search = [[BMKGeoCodeSearch alloc] init];
    self.search.delegate = self ;
    
    self.locService = [[BMKLocationService alloc] init];
    self.locService.delegate = self ;
    [self.locService startUserLocationService];
    if(!DEVICE_IS_IPHONE5){
        self.view.frame = CGRectMake(0, -10, SCREEN_WIDTH, 416);
    }
    
    //地图的初始化
    //    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APPLICATION_HEIGHT-44)];
    self.mapView.userTrackingMode = BMKUserTrackingModeNone ;
    self.mapView.zoomLevel = 14.1 ;
    self.mapView.showMapScaleBar = YES ;
    [self.view addSubview:self.mapView];
    
    //添加搜索框背景视图
    self.searchImg = [[UIImageView alloc] init];
    self.searchImg.frame = CGRectMake(SCREEN_WIDTH - 10, 10, 0, 50);
    self.searchImg.image = [[UIImage imageNamed:@"h_search_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    self.searchImg.clipsToBounds = YES ;
    self.searchImg.userInteractionEnabled = YES ;
    [self.view addSubview:self.searchImg];
    
    
    UIImageView *searchBg = [[UIImageView alloc] init];
    searchBg.frame = CGRectMake(5, 5, SCREEN_WIDTH - 75, 40);
    searchBg.image = [[UIImage imageNamed:@"h_search_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    searchBg.userInteractionEnabled = YES ;
    [self.searchImg addSubview:searchBg];
    
    //添加搜索框
    self.searchTf = [[UITextField alloc] init];
    self.searchTf.frame = CGRectMake(5, 10, SCREEN_WIDTH-75, 20);
    self.searchTf.placeholder = @"请输入搜索内容";
    self.searchTf.font = [UIFont systemFontOfSize:15];
    self.searchTf.returnKeyType = UIReturnKeyDone ;
    self.searchTf.delegate = self;
    [searchBg addSubview:self.searchTf];
    
    //添加搜索按钮
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(SCREEN_WIDTH-60, 10, 50, 50);
    [self.searchBtn setImage:[UIImage imageNamed:@"h_search"] forState:UIControlStateNormal];
    [self.searchBtn setImage:[UIImage imageNamed:@"h_search_p"] forState:UIControlStateSelected];
    [self.searchBtn addTarget:self action:@selector(searchClickEvent:) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:self.searchBtn];
    
    
    self.circleImg = [[UIImageView alloc] init];
    self.circleImg.frame = CGRectMake(0, 0, 160, 160);
    self.circleImg.image = [UIImage imageNamed:@"h_circle"];
    self.circleImg.center = self.mapView.center ;
    [self.view addSubview:self.circleImg];
    
    
    self.paopaoView = [[KTVBubbleView alloc] init];
    self.paopaoView = [[[NSBundle mainBundle] loadNibNamed:@"KTVBubbleView" owner:self options:nil] objectAtIndex:0];
    self.paopaoView.center = CGPointMake(self.circleImg.center.x, self.circleImg.center.y-105);
    [self.view addSubview:self.paopaoView];
    
    [self setCircleHidden:YES];
    
    //添加手势事件方法
    UITapGestureRecognizer *guest = [[UITapGestureRecognizer alloc] init];
    [guest addTarget:self action:@selector(sendOrderClickEvent:)];
    [self.paopaoView addGestureRecognizer:guest];
    
    [self addMapBottomView];
    
    
    NSString *latitude = [[SharedUserDefault sharedInstance] getLatitude];
    NSString *longitude = [[SharedUserDefault sharedInstance] getLongitude];
    CLLocationCoordinate2D coordinate = {latitude.doubleValue,longitude.doubleValue};
    [self addKTVShopAnnotion:coordinate withTag:0];
    
    self.currentPosition = KTVTYPE ;
    for (ParamElement *param in paramArray)
    {
        if ([param.paramName isEqualToString:@"KTV"])
        {
            self.shopType = param.paramterId;
            break;
        }
    }
    
    self.shopsAry = [[NSMutableArray alloc] init];
    
    self.proAry = [[NSMutableArray alloc] init];
    self.paramDic = [[NSMutableDictionary alloc]init];
    [self.paramDic setObject:@"430100" forKey:CITY];
    [self.paramDic setObject:@"" forKey:@"shopsName"];
    if (self.shopType!=nil&&![self.shopType isEqualToString:@""]) {
        [self.paramDic setObject:self.shopType forKey:SHOPTYPE];
    }
    [self.paramDic setObject:[NSString stringWithFormat:@"%d",1] forKey:INDEX];
    
    //     [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
    if (![ConUtils checkUserNetwork])
    {
        [self showToast:@"当前无可用网络"];
    }
    
    //注册一个搜索选择通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchRefresh:) name:SEARCHREFRESH object:nil];
    
}

/*
 * 搜索刷新的通知方法
 */
-(void) searchRefresh:(id) obj {
    //[SVProgressHUD show];
    self.isRefreshData = YES ;
    isSearch = YES;
    NSNotification *notification = obj ;
    searchElement = notification.object ;
    self.shopId = searchElement.shopId ;
    [self.paramDic setObject:searchElement.latitude forKey:LATITUDE];
    [self.paramDic setObject:searchElement.longitude forKey:LONGITUDE];
    [self.paramDic setObject:searchElement.shopName forKey:@"shopsName"];
//    CLLocationCoordinate2D coordinateCenter = CLLocationCoordinate2DMake([[self.paramDic objectForKey:LATITUDE] floatValue], [[self.paramDic objectForKey:LONGITUDE] floatValue]);
//    [self.mapView setCenterCoordinate:coordinateCenter animated:YES];
    //[self.proAry removeAllObjects];
    [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
}

/*
 * 搜索按钮的事件方法
 */
-(void) searchClickEvent:(id) sender {
    
    UIButton *btn = (UIButton *)sender ;
    btn.selected = !btn.selected ;
    NSString *keyword = self.searchTf.text ;
    if(keyword == nil)keyword = @"";
    [self.view endEditing:YES];
    if(btn.selected && [keyword isEqualToString:@""]){
        [UIView animateWithDuration:0.5 animations:^{
            self.searchImg.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, 50);
        }];
    }else if([keyword isEqualToString:@""]){
        [UIView animateWithDuration:0.5 animations:^{
            self.searchImg.frame = CGRectMake(SCREEN_WIDTH - 10, 10, 0, 50);
        }];
        
        btn.selected = NO ;
    }else {
        [UIView animateWithDuration:0.5 animations:^{
            self.searchImg.frame = CGRectMake(SCREEN_WIDTH - 10, 10, 0, 50);
        }];
        self.searchTf.text = @"" ;
        MerchantSearchController *merchantCon = [[MerchantSearchController alloc] init];
        merchantCon.paramDic = [[NSMutableDictionary alloc] initWithDictionary:self.paramDic] ;
        [merchantCon.paramDic setObject:keyword forKey:@"shopsName"];
        [self.navigationController pushViewController:merchantCon animated:YES];
    }
    
}

/*
 * 范围显示圈的显示方法
 */
-(void) setCircleHidden:(BOOL) hidden {
    self.circleImg.hidden = hidden ;
    self.paopaoView.hidden = hidden ;
}

/*
 * 添加底部视图的方法
 */
-(void) addMapBottomView {
    
    self.mapView.mapScaleBarPosition = CGPointMake(10, SCREEN_HEIGHT-210);
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, APPLICATION_HEIGHT-169, SCREEN_WIDTH, 125);
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    //底部视图
//    UIImageView *bottomImg = [[UIImageView alloc] init];
//    bottomImg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
//    bottomImg.image = [UIImage imageNamed:@"h_bottom_bg"];
//    [bottomView addSubview:bottomImg];
    UIView *bottomBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomView.frame.size.height-56, SCREEN_WIDTH, 56)];
    bottomBtnView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:bottomBtnView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    label.backgroundColor = [UIColor lightGrayColor];
    [bottomBtnView addSubview:label];
    
    //地图放大缩小视图
    
    UIImageView *scaleImg = [[UIImageView alloc] init];
    scaleImg.userInteractionEnabled = YES ;
    scaleImg.frame = CGRectMake(SCREEN_WIDTH - 50, SCREEN_HEIGHT-300, 40, 80);
    scaleImg.image = [UIImage imageNamed:@"h_scale_bg"];
    [self.view addSubview:scaleImg];
    
    UIButton *maxBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    maxBtn.frame = CGRectMake(0, 2, 40, 40);
    maxBtn.tag = 100 ;
    [maxBtn setBackgroundImage:[UIImage imageNamed:@"h_add"] forState:UIControlStateNormal];
    [maxBtn addTarget:self action:@selector(scaleMapViewClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scaleImg addSubview:maxBtn];
    
    UIButton *minBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    minBtn.frame = CGRectMake(0, 40, 40, 40);
    minBtn.tag = 101 ;
    [minBtn setBackgroundImage:[UIImage imageNamed:@"h_reduce"] forState:UIControlStateNormal];
    [minBtn addTarget:self action:@selector(scaleMapViewClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [scaleImg addSubview:minBtn];
    
    UIButton *positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    positionBtn.frame = CGRectMake(10, SCREEN_HEIGHT-260, 40, 40);
    positionBtn.tag = 100 ;
    [positionBtn setBackgroundImage:[UIImage imageNamed:@"h_position"] forState:UIControlStateNormal];
    [positionBtn addTarget:self action:@selector(localMapViewClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:positionBtn];
    
    UIMenuButton *ktvBtn = [[UIMenuButton alloc] initWithFrame:CGRectMake(10, 10, 93, 55)];
    [ktvBtn setTitle:@"去K歌" forState:UIControlStateNormal];
    [ktvBtn setImage:[UIImage imageNamed:@"h_ktv"] forState:UIControlStateNormal];
    [ktvBtn setImage:[UIImage imageNamed:@"h_ktv_s"] forState:UIControlStateSelected];
    [ktvBtn setBackgroundImage:[UIImage imageNamed:@"h_selected_n"] forState:UIControlStateNormal];
    [ktvBtn setBackgroundImage:[UIImage imageNamed:@"h_selected_s"] forState:UIControlStateSelected];
    [ktvBtn addTarget:self action:@selector(menuClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    ktvBtn.selected = YES ;
    ktvBtn.tag = 101 ;
    [ktvBtn setMenuSelectedState:YES];
    self.curMenuBtn = ktvBtn ;
    [self.curMenuBtn setTitleColor:[UIColor colorWithRed:0.863 green:0.369 blue:0.525 alpha:1] forState:UIControlStateNormal];
    [bottomView addSubview:ktvBtn];
    
    UIMenuButton *barBtn = [[UIMenuButton alloc] initWithFrame:CGRectMake(113, 10, 93, 55)];
    [barBtn setTitle:@"去泡吧" forState:UIControlStateNormal];
    [barBtn setImage:[UIImage imageNamed:@"h_bar"] forState:UIControlStateNormal];
    [barBtn setImage:[UIImage imageNamed:@"h_bar_s"] forState:UIControlStateSelected];
    [barBtn setBackgroundImage:[UIImage imageNamed:@"h_selected_n"] forState:UIControlStateNormal];
    [barBtn setBackgroundImage:[UIImage imageNamed:@"h_selected_s"] forState:UIControlStateSelected];
    [barBtn addTarget:self action:@selector(menuClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    barBtn.tag = 102 ;
    [bottomView addSubview:barBtn];
    
    UIMenuButton *ycBtn = [[UIMenuButton alloc] initWithFrame:CGRectMake(217, 10, 93, 55)];
    [ycBtn setTitle:@"去夜场" forState:UIControlStateNormal];
    [ycBtn setImage:[UIImage imageNamed:@"h_yc"] forState:UIControlStateNormal];
    [ycBtn setImage:[UIImage imageNamed:@"h_yc_s"] forState:UIControlStateSelected];
    [ycBtn setBackgroundImage:[UIImage imageNamed:@"h_selected_n"] forState:UIControlStateNormal];
    [ycBtn setBackgroundImage:[UIImage imageNamed:@"h_selected_s"] forState:UIControlStateSelected];
    [ycBtn addTarget:self action:@selector(menuClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    ycBtn.tag = 103 ;
    [bottomView addSubview:ycBtn];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.frame = CGRectMake(10, 6, SCREEN_WIDTH-20, 44);
    [self.sendBtn setTitle:@"我来出价" forState:UIControlStateNormal];
    [self.sendBtn setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    //self.sendBtn.adjustsImageWhenHighlighted = NO;
    self.sendBtn.titleLabel.font = [ConUtils boldAndSizeFont:15];
    //[self.sendBtn setImage:[UIImage imageNamed:@"h_ktv_icon"] forState:UIControlStateNormal];
    //[self.sendBtn setImage:[UIImage imageNamed:@"h_ktv_icon"] forState:UIControlStateHighlighted];
    [self.sendBtn addTarget:self action:@selector(sendOrderClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtnView addSubview:self.sendBtn];
}

/*
 *  订单发布类型的事件响应方法
 */
-(void) menuClickEvent:(id) sender {
    /*
     * 101 KTV消费发布
     * 102 酒吧消费发布
     * 103 KTV夜场消费发布
     */
    UIMenuButton *btn = sender ;
    NSInteger tagValue = btn.tag ;
    if(self.curMenuBtn.tag == tagValue) return ;
    [self.curMenuBtn setTitleColor:[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1] forState:UIControlStateNormal];
    self.curMenuBtn.selected = NO ;
    [self.curMenuBtn setMenuSelectedState:NO];
    self.curMenuBtn = btn ;
    btn.selected = !btn.selected ;
    [btn setMenuSelectedState:btn.selected];
    
    
//    ((UIMenuButton *)[self.view viewWithTag:101]).enabled = NO ;
//    ((UIMenuButton *)[self.view viewWithTag:102]).enabled = NO ;
//    ((UIMenuButton *)[self.view viewWithTag:103]).enabled = NO ;
    NSString *imageName = @"";
    switch (tagValue) {
        case 101:{
            imageName = @"h_ktv_icon";
            ((UIMenuButton *)[self.view viewWithTag:101]).enabled = YES ;
            for (ParamElement *param in paramArray)
            {
                if ([param.paramName isEqualToString:@"KTV"])
                {
                    self.shopType = param.paramterId;
                    break;
                }
            }
            self.currentPosition = KTVTYPE ;
        }
            break;
        case 102:{
            imageName = @"h_bar_icon";
            ((UIMenuButton *)[self.view viewWithTag:102]).enabled = YES ;
            for (ParamElement *param in paramArray)
            {
                if ([param.paramName isEqualToString:@"JB"])
                {
                    self.shopType = param.paramterId;
                    break;
                }
            }
            self.currentPosition = BARTYPE ;
        }
            break;
        case 103:{
            imageName = @"h_yc_icon";
            ((UIMenuButton *)[self.view viewWithTag:103]).enabled = YES ;
            for (ParamElement *param in paramArray)
            {
                if ([param.paramName isEqualToString:@"YC"])
                {
                    self.shopType = param.paramterId;
                    break;
                }
            }
            self.currentPosition = YCTYPE ;
        }
            break;
    }
    
    
    if (self.shopType!=nil&&![self.shopType isEqualToString:@""]) {
        [self.paramDic setObject:self.shopType forKey:SHOPTYPE];
    }
    [self.proAry removeAllObjects];
    
    NSString *latitude = [[SharedUserDefault sharedInstance] getLatitude];
    NSString *longitude = [[SharedUserDefault sharedInstance] getLongitude];
    [self.paramDic setObject:latitude forKey:LATITUDE];
    [self.paramDic setObject:longitude forKey:LONGITUDE];
    
    //移除地图商户
    NSInteger count = [[self.mapView annotations] count];
    if(count >0){
        for (int i =0; i<count; i++) {
            [self.mapView removeAnnotation:[[self.mapView annotations] objectAtIndex:0]];
        }
    }
    [self.mapView addAnnotation:self.localAnnotation];
    [SVProgressHUD show];
    [self.paramDic setObject:@"" forKey:@"shopsName"];
    [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
    
    [btn setTitleColor:[UIColor colorWithRed:0.863 green:0.369 blue:0.525 alpha:1] forState:UIControlStateNormal];
//    UIButton *reBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    reBtn.frame = CGRectMake(0, 40, self.sendView.frame.size.width, self.sendView.frame.size.height);
//    [reBtn setTitle:@"我来定价" forState:UIControlStateNormal];
//    reBtn.titleLabel.font = [ConUtils boldAndSizeFont:15];
//    reBtn.tag = 10 ;
//    //[reBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [self.sendView addSubview:reBtn];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.sendBtn.frame = CGRectMake(0, -40, self.sendBtn.frame.size.width, self.sendBtn.frame.size.height);
//        reBtn.frame = CGRectMake(0, 0, self.sendView.frame.size.width, self.sendView.frame.size.height);
//    } completion:^(BOOL finish){
//        //[self.sendBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        //[self.sendBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
//        self.sendBtn.frame = CGRectMake(0, 0, self.sendView.frame.size.width, self.sendView.frame.size.height);
//        [[self.sendView viewWithTag:10] removeFromSuperview];
//        ((UIMenuButton *)[self.view viewWithTag:101]).enabled = YES ;
//        ((UIMenuButton *)[self.view viewWithTag:102]).enabled = YES ;
//        ((UIMenuButton *)[self.view viewWithTag:103]).enabled = YES ;
//    }];
}

/*
 * 地图定位的事件方法
 */
-(void)localMapViewClickEvent:(id) sender {
    NSString *latitude = [[SharedUserDefault sharedInstance] getLatitude];
    NSString *longitude = [[SharedUserDefault sharedInstance] getLongitude];
    CLLocationCoordinate2D coordinate = {latitude.doubleValue,longitude.doubleValue};
    [self.mapView setCenterCoordinate:coordinate];
    self.mapView.zoomLevel = 16.1 ;
}

/*
 * 地图页面放大，缩小的事件方法
 */
-(void) scaleMapViewClickEvent:(id) sender {
    UIButton *btn = (UIButton *)sender ;
    NSInteger tagValue = btn.tag ;
    switch (tagValue) {
        case 100:
            self.mapView.zoomLevel = self.mapView.zoomLevel+0.5 ;
            break;
        case 101:
            self.mapView.zoomLevel = self.mapView.zoomLevel-0.5 ;
            break;
    }
}

/*
 * 发单的事件方法
 */
-(void) sendOrderClickEvent:(id) sender
{
    PriceMySelfViewController *priceController = [[PriceMySelfViewController alloc] init];
    priceController.shopArray = self.shopsAry ;
    priceController.shopType = [self.shopType integerValue];
    priceController.locationCoordinate = self.locationCoordinate;
    [self.navigationController pushViewController:priceController animated:YES];
}

-(void) addKTVShopAnnotion:(CLLocationCoordinate2D ) coordinate withTag:(NSInteger) tag{
    KTVPointAnnotation *item = [[KTVPointAnnotation alloc] init];
    item.tag = tag;
    item.shopType = self.currentPosition ;
    if(tag != 0)item.title = [[self.proAry objectAtIndex:(tag -1)] shopName];
    item.coordinate = coordinate;
    [self.mapView addAnnotation:item];
    
    if(tag == 0){
        self.localAnnotation = item ;
        item.title = @"当前位置";
    }else {
        if(self.isRefreshData && [[[self.proAry objectAtIndex:(tag -1)] shopId] isEqualToString:self.shopId]){
            [self.mapView selectAnnotation:item animated:YES];
            self.isRefreshData = NO ;
        }
    }
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
        
        if(tag == 0){
            annotationView.canShowCallout = YES ;
            annotationView.image = [UIImage imageNamed:@"h_location"];
        }else{
            if(tag == 1) annotationView.canShowCallout = YES ;
            
            switch (ann.shopType) {
                case KTVTYPE:
                    annotationView.image = [UIImage imageNamed:@"h_lo_ktv"];
                    break;
                case BARTYPE:
                    annotationView.image = [UIImage imageNamed:@"h_lo_bar"];
                    break;
                case YCTYPE:
                    annotationView.image = [UIImage imageNamed:@"h_lo_yc"];
                    break;
            }
            
        }
    }
    return annotationView ;
}

/*
 * 地图单击事件
 */
-(void) mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    self.locationCoordinate = coordinate;
    BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
    reversePotion.reverseGeoPoint = coordinate ;
    [self.search reverseGeoCode:reversePotion];
    [self.mapView setCenterCoordinate:coordinate animated:YES];
    [self.mapView removeAnnotation:self.localAnnotation];
    [self addKTVShopAnnotion:coordinate withTag:0];
    
}

-(void) mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    
}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        self.searchImg.frame = CGRectMake(SCREEN_WIDTH - 10, 10, 0, 50);
    }];
    
    self.searchBtn.selected = NO ;
    [self.view endEditing:YES];
    
    if (!isSearch) {
//        CGPoint point = CGPointMake(self.circleImg.frame.origin.x + self.circleImg.frame.size.width/2, self.circleImg.frame.origin.y+self.circleImg.frame.size.height/2);
//        CLLocationCoordinate2D coordinateCenter = [self.mapView convertPoint:point toCoordinateFromView:self.view];
        CLLocationCoordinate2D coordinateCenter = mapView.centerCoordinate;
        self.locationCoordinate = coordinateCenter;
        BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
        reversePotion.reverseGeoPoint = coordinateCenter ;
        [self.search reverseGeoCode:reversePotion];
        [self.mapView removeAnnotation:self.localAnnotation];
        [self addKTVShopAnnotion:coordinateCenter withTag:0];
        
        [self.paramDic setObject:@"" forKey:@"shopsName"];
        [self.paramDic setObject:[NSString stringWithFormat:@"%f",coordinateCenter.latitude] forKey:LATITUDE];
        [self.paramDic setObject:[NSString stringWithFormat:@"%f",coordinateCenter.longitude] forKey:LONGITUDE];
        [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
    }
    else
    {
        CLLocationCoordinate2D coordinateCenter = CLLocationCoordinate2DMake([[self.paramDic objectForKey:LATITUDE] floatValue], [[self.paramDic objectForKey:LONGITUDE] floatValue]);
        self.locationCoordinate = coordinateCenter;
        BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
        reversePotion.reverseGeoPoint = coordinateCenter ;
        [self.search reverseGeoCode:reversePotion];
        //[self.mapView removeAnnotation:self.localAnnotation];
        //[self addKTVShopAnnotion:coordinateCenter withTag:0];
    }
    
    if(self.isFirstScrope)
    {
        [self setCircleHidden:NO];
    }
    isSearch = NO;
}

-(void) mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    [UIView animateWithDuration:0.5 animations:^{
        self.searchImg.frame = CGRectMake(SCREEN_WIDTH - 10, 10, 0, 50);
    }];
    
    self.searchBtn.selected = NO ;
    for (id<BMKAnnotation> an in self.mapView.annotations)
    {
        if([an isKindOfClass:[KTVPointAnnotation class]]){
            KTVPointAnnotation *kyan = (KTVPointAnnotation *)an ;
            if(kyan.tag == [(KTVPointAnnotation *)[view annotation] tag]){
                //[self.mapView setCenterCoordinate:kyan.coordinate];
                break;
            }
        }
    }
}

#pragma mark -BMKLocationServiceDelegate
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
//{
//    if (userLocation.isUpdating)
//    {
//        [_mapView updateLocationData:userLocation];
//        if(userLocation != nil){
//            if(userLocation.location.coordinate.latitude != 0){
//                //定位成功后保存当前的位置信息
//                SharedUserDefault *shared = [SharedUserDefault sharedInstance];
//                [shared setLatitudeAndLongitude:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] andLat:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude]];
//                
//                self.locationCoordinate = userLocation.location.coordinate;
//                
//                BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
//                reversePotion.reverseGeoPoint = userLocation.location.coordinate ;
//                [self.search reverseGeoCode:reversePotion];
//                
//                [self.mapView removeAnnotation:self.localAnnotation];
//                [self addKTVShopAnnotion:userLocation.location.coordinate withTag:0];
//                [self.mapView setCenterCoordinate:userLocation.location.coordinate];
//            }else{
//                //self.locService startUserLocationService];
//            }
//        }
//    }
//}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    if(userLocation != nil){
        if(userLocation.location.coordinate.latitude != 0){
            //定位成功后保存当前的位置信息
            SharedUserDefault *shared = [SharedUserDefault sharedInstance];
            [shared setLatitudeAndLongitude:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] andLat:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude]];
            
            self.locationCoordinate = userLocation.location.coordinate;
            
            if(!self.isFirstShow)
            {
                BMKReverseGeoCodeOption *reversePotion = [[BMKReverseGeoCodeOption alloc] init];
                reversePotion.reverseGeoPoint = userLocation.location.coordinate ;
                [self.search reverseGeoCode:reversePotion];
                
                [self.mapView removeAnnotation:self.localAnnotation];
                [self addKTVShopAnnotion:userLocation.location.coordinate withTag:0];
                [self.mapView setCenterCoordinate:userLocation.location.coordinate];
                self.isFirstShow = YES ;
            }
        }else{
            //self.locService startUserLocationService];
        }
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"微歌无法确认您当前的位置,请到设置-隐私-定位服务-开启微歌定位" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}

#pragma mark _BMKGeocodeSearchDelegate
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    //保存当前城市名称
    [[SharedUserDefault sharedInstance] setCityName:result.addressDetail.city];
    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
    [[SharedUserDefault sharedInstance] setCurrentAddress:address];
    
}

#pragma mark - HttpRequestCommDelegate
-(void) httpRequestSuccessComm:(int)tagId withInParams:(id)inParam {
    switch (tagId) {
        case COMMPARAM:
            [[SharedUserDefault sharedInstance] saveSysetmParam:inParam];
            break;
        case SHOPNEARLIST:
            [SVProgressHUD dismiss];
            self.proResponse = [[ProviderResponse alloc] init];
            [self.proResponse setResultData:inParam];
            if(self.proResponse.code == 0){
                NSInteger count = [[self.mapView annotations] count];
                if(count >0){
                    for (int i =0; i<count; i++) {
                        [self.mapView removeAnnotation:[[self.mapView annotations] objectAtIndex:0]];
                    }
                }
                [self.mapView addAnnotation:self.localAnnotation];
                [self.shopsAry removeAllObjects];
                
                if(self.proResponse.providerAry != nil && [self.proResponse.providerAry count]>0){
                    //[self.proAry addObjectsFromArray:self.proResponse.providerAry];
                    self.proAry = self.proResponse.providerAry;
                    int i = 1 ;
                    for (ProviderElement *element in self.proAry) {
                        NSString *latitude = element.latitude;
                        NSString *longitude = element.longitude;
                        CLLocationCoordinate2D coordinate = {latitude.doubleValue,longitude.doubleValue};
                        [self addKTVShopAnnotion:coordinate withTag:i];
                        i++;
                    }
                
                    int j = 0 ;
                    if (isSearch) {
                        j++;
                        [self.shopsAry addObject:searchElement];
                    }else
                    {
                        for (ProviderElement *element in self.proAry) {
                            
                            NSString *latitude = element.latitude;
                            NSString *longitude = element.longitude;
                            CLLocationCoordinate2D coordinate = {latitude.doubleValue,longitude.doubleValue};
                            CGPoint point = [self.mapView convertCoordinate:coordinate toPointToView:self.mapView];
                            CGPoint centerPoint = self.mapView.center ;
                            CGFloat value = fabs((point.x - centerPoint.x)*(point.x - centerPoint.x)) + fabs((point.y - centerPoint.y)*(point.y - centerPoint.y));
                            CGFloat longValue = sqrt(value);
                            if(longValue <80){
                                j++ ;
                                if (self.isFirstScrope)
                                {
                                    [self.shopsAry addObject:element];
                                }
                            }
                        }
                    }
                    
                    if(self.shopsAry == nil || [self.shopsAry count]==0){
                        self.paopaoView.addressLa.text = @"该范围内无商家,请缩放地图查看";
                    }else{
                        self.paopaoView.addressLa.text = [NSString stringWithFormat:@"该范围内发单给%d位商家", j];
                    }
                }else {
                    self.paopaoView.addressLa.text = @"该范围内无商家,请缩放地图查看";
                }
                if(!self.isFirstScrope)
                {
                    self.isFirstScrope = YES ;
                }else{
                    if (isSearch)
                    {
                        CLLocationCoordinate2D coordinateCenter = CLLocationCoordinate2DMake([[self.paramDic objectForKey:LATITUDE] floatValue], [[self.paramDic objectForKey:LONGITUDE] floatValue]);
                        [self.mapView setCenterCoordinate:coordinateCenter animated:YES];
                    }
                }
            }
            break;
        default:
            break;
    }
}

-(void) httpRequestFailueComm:(int)tagId withInParams:(NSString *)error {
    [SVProgressHUD dismiss];
    [self showToast:@"网络异常，请稍后重试"];
}

#pragma  mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}


/*
 *设置NavigationBar的背景
 */
-(void)setNavigationBarBackground{
    if (SYSTEM_VERSION >= 7){
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"navBackHighter.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageNamed:@"navBack.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor whiteColor], UITextAttributeTextColor,[ConUtils boldAndSizeFont:20],UITextAttributeFont, nil];
}

-(void) viewWillAppear:(BOOL)animated {
    [self.mapView viewWillAppear];
    self.mapView.delegate = self ;
    UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userBtn.frame = CGRectMake(0, 0, 40, 44);
    [userBtn setImage:[UIImage imageNamed:@"h_map_user"] forState:UIControlStateNormal];
    [userBtn addTarget:self action:@selector(userCenterClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:userBtn];
    self.navigationItem.leftBarButtonItem = item ;
    
//    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    locationBtn.frame = CGRectMake(0, 0, 40, 44);
//    [locationBtn setImage:[UIImage imageNamed:@"h_map_user"] forState:UIControlStateNormal];
//    [locationBtn addTarget:self action:@selector(userCenterClickEvent:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *locationItem = [[UIBarButtonItem alloc] initWithCustomView:locationBtn];
//    self.navigationItem.rightBarButtonItem = locationItem ;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"HOMEGUIDE"]==nil)
    {
        guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APPLICATION_HEIGHT) withTag:HOME_GUIDE];
        [self.view addSubview:guideView];
    }
}

/*
 * 用户中心入口
 */
-(void) userCenterClickEvent:(id) sender {
    [SVProgressHUD dismiss];
    if ([[SharedUserDefault sharedInstance] isLogin])
    {
        UserZoneMainViewController *zoneMainController = [[UserZoneMainViewController alloc] init];
        [self.navigationController pushViewController:zoneMainController animated:YES];
    }
    else
    {
        UserLoadViewController *loginController = [[UserLoadViewController alloc] init];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
}

#pragma mark 网络变化的通知

- (void)refreshCustomViewOne:(NSNotification *)notification
{
    if ([[SharedUserDefault sharedInstance] getSystemParam]==nil)
    {
        if ([ConUtils checkUserNetwork])
        {
            [HttpRequestComm getCommonparamsList:self];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
