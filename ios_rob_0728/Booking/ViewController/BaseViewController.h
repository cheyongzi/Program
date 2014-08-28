//
//  BaseViewController.h
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568) //判断设备
#define SYSTEM_VERSION [UIDevice currentDevice].systemVersion.intValue //判断系统版本
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height  //获得屏幕高度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width    //获得屏幕宽度
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] //获取app版本号


#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "ConUtils.h"
#import "HttpRequestCommDelegate.h"
#import "HttpRequestComm.h"
#import "ConstantField.h"
/*
 * 控制器基类
 */

@interface BaseViewController : UIViewController<HttpRequestCommDelegate>


@property (strong ,nonatomic) UIView *sbgView ;
@property (strong ,nonatomic) UILabel *desLa ;
/*
 * 返回上一个ViewController
 */
-(void)popViewController ;

/*
 * 底部刷新视图
 * @param type 刷新状态类型
 */
-(UIView *) bottomRefreshView:(NSInteger) type ;

/*
 * 显示用户信息提示框
 */
- (void)showToast:(NSString *) msg ;

/*
 * 图片背景的拉伸处理
 */
//-(UIImage *) setImageScale:(NSString *) imageName ;

@end
