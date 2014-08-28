//
//  AppDelegate.h
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKMapManager.h"
#import "SharedUserDefault.h"
#import "HttpRequestCommDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,HttpRequestCommDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong ,nonatomic) BMKMapManager *manager ;

@end
