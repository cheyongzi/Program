//
//  QuickViewController.h
//  Booking
//
//  Created by jinchenxin on 14-6-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BMapKit.h"
#import "BaseViewController.h"
#import "SharedUserDefault.h"


/*
 * 快速预定的ViewController
 */
@interface QuickViewController : BaseViewController<BMKLocationServiceDelegate ,BMKGeoCodeSearchDelegate>

@property (strong ,nonatomic) BMKLocationService *locService ;
@property (strong ,nonatomic) BMKGeoCodeSearch *search ;

@property (strong ,nonatomic) IBOutlet UIButton *areBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *timeBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *nearBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *refBtn ;
@property (strong ,nonatomic) IBOutlet UILabel *locLa ;
@property (strong ,nonatomic) IBOutlet UIButton *conBtn ;

@property (strong ,nonatomic) UIView *alertView ;

@property (nonatomic) BOOL isExtend ;



/*
 * 条件筛选事件按钮
 */
-(IBAction)topMenuClickEvent:(id)sender ;

@end
