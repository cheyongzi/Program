//
//  ConstantField.h
//  Music
//
//  Created by jinchenxin on 14-4-16.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

/*
 *系统常用字段的定义
 */

#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568) //判断设备
#define SYSTEM_VERSION [UIDevice currentDevice].systemVersion.intValue //判断系统版本
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height  //获得屏幕高度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width    //获得屏幕宽度
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] //获取app版本号
#define FILE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APPLICATION_HEIGHT [UIScreen mainScreen].applicationFrame.size.height
/*
 * 本地缓存字段定义
 */

#define CITYNAME @"cityName"
#define LONGITUDE @"longitude"
#define LATITUDE @"latitude"
#define ADDRESS @"address"
#define SYSTEMPARAM @"systemParam"

/*
 * 常用颜色值
 */
#define LOAD_SEPERATE_COLOR [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1]
#define USER_LOADBTN_COLOR [UIColor colorWithRed:0.937 green:0.176 blue:0.353 alpha:1]
#define USER_REGISTER_COLOR [UIColor colorWithRed:0.408 green:0.827 blue:0.620 alpha:1]
#define MY_ORDER_BACKGROUND [UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:1]
#define MY_ORDER_BUTTON_COLOR [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1]
#define TITLE_LABEL_COLOR [UIColor colorWithRed:0.584 green:0.584 blue:0.584 alpha:1]
#define ALERT_BACKGROUND_COLOR [UIColor colorWithRed:0.424 green:0.424 blue:0.424 alpha:1]
#define ALERT_HEADER_COLOR [UIColor colorWithRed:0.702 green:0.106 blue:0.247 alpha:1]
#define ALERT_CONFIRM_COLOR [UIColor colorWithRed:0.937 green:0.176 blue:0.353 alpha:1]
#define ALERT_CANCEL_COLOR [UIColor colorWithRed:0.961 green:0.329 blue:0.475 alpha:1]
#define COMM_RED_COLOR [UIColor colorWithRed:0.914 green:0.263 blue:0.416 alpha:1]
#define COMM_GRARY_COLOR [UIColor colorWithRed:0.141 green:0.141 blue:0.141 alpha:1]
#define USER_SHARE_BACK [UIColor colorWithRed:101.0f/255 green:101.0f/255 blue:101.0f/255 alpha:1]
#define INFO_TEXT_COLOR [UIColor colorWithRed:0.780 green:0.780 blue:0.780 alpha:1]
#define SELECTED_TAG_COLOR [UIColor colorWithRed:0.937 green:0.380 blue:0.502 alpha:1]
#define RED_COLOR [UIColor colorWithRed:232.0f/255 green:82.0f/255 blue:132.0f/255 alpha:1]

/*
 * 广播字段
 */
#define ADDDRINKREFRESH @"addDrinkRefresh"
#define ADDPROVIDERREFRESH @"addProviderRefresh"
#define CITYSELECTEREFRESH @"citySelecteRefresh"
#define SELECTEADDRESS @"selecteAddress"
#define PAYRESULTINFO @"payResultInfo"
#define SEARCHREFRESH @"searchRefresh"
#define COMMENTREFRESH @"commentRefresh"

#import <Foundation/Foundation.h>

@interface ConstantField : NSObject

@end
