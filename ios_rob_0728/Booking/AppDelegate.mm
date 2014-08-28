//
//  AppDelegate.m
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "SystemParamResponse.h"
#import "ShareApi.h"
#import "AppLoadViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "AlixPayResult.h"
#import "HomeMapViewController.h"
#import "Reachability.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    
    // 要使用百度地图，请先启动BaiduMapManager
    self.manager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [self.manager start:@"2E419c12ea3ab4d4f8583bbdaef9216e"  generalDelegate:nil];
    //BOOL ret = [self.manager start:@"XN9VERBGjX2AGjWj1ksirex3"  generalDelegate:nil];
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }else
    {
        NSLog(@"manager start success!");
    }
    
    //设置一个默认的位置信息
    SharedUserDefault *shared = [SharedUserDefault sharedInstance];
    if([shared getCityName] == nil || [[shared getCityName] isEqualToString:@""]){
        [shared setCityName:@"长沙市"];
        [shared setLatitudeAndLongitude:@"28.177917" andLat:@"112.984171"];
        [shared setCurrentAddress:@"湖南省长沙市"];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *rootCon = [[UINavigationController alloc]init];
    if ([shared isFirstStartApp] == nil || [[shared isFirstStartApp] isEqualToString:@"Y"])
    {
        AppLoadViewController *loadController = [[AppLoadViewController alloc] init];
        
        self.window.rootViewController = loadController ;
    }
    else
    {
        HomeMapViewController *homeMapCon = [[HomeMapViewController alloc] init];
        [rootCon addChildViewController:homeMapCon];
        
        self.window.rootViewController = rootCon;
    }
    [self.window makeKeyAndVisible];
    [[[Reachability reachabilityForInternetConnection] retain] startNotifier];
    
    //公共参数请求
    [HttpRequestComm getCommonparamsList:self];
    
    return YES;
}

/*
 *设置NavigationBar的背景
 */
-(void)setNavigationBarBackground{
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -HttpRequestCommDelegate
-(void) httpRequestSuccessComm:(int)tagId withInParams:(id)inParam {
    [[SharedUserDefault sharedInstance] saveSysetmParam:inParam];
}

-(void) httpRequestFailueComm:(int)tagId withInParams:(NSString *)error
{
    [self showToast:@"获取系统参数失败"];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[ShareApi shareInstance] handleOpenURL:url];
    //return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //支付处理结果
    AlixPayResult *result = [self handleOpenURL:url];
    if(result){
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if(result.statusCode == 9000){
            [userDefault setObject:@"1" forKey:@"payStatue"];
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:PAYRESULTINFO object:self userInfo:nil];
        }else{
            [userDefault setObject:@"0" forKey:@"payStatue"];
        }
    }
    
    return [[ShareApi shareInstance] handleOpenURL:url];
    //return [TencentOAuth HandleOpenURL:url];
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

/*
 * 显示用户信息提示框
 */
- (void)showToast:(NSString *) msg  {
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 5 ;
    view.tag = 600 ;
    CGFloat width = [ConUtils labelWidth:msg withFont:[UIFont systemFontOfSize:15]];
    view.frame = CGRectMake(0, 0, width+30, 50);
    view.backgroundColor = [UIColor blackColor];
    view.center = CGPointMake(320/2, SCREEN_HEIGHT/2+80);
    UILabel *msgLa = [[UILabel alloc] init];
    msgLa.frame = CGRectMake(0, 0, width+30, 50) ;
    msgLa.text = msg ;
    msgLa.textAlignment = NSTextAlignmentCenter ;
    msgLa.font = [ConUtils boldAndSizeFont:15];
    msgLa.backgroundColor = [UIColor clearColor];
    msgLa.textColor = INFO_TEXT_COLOR;
    [view addSubview:msgLa];
    
    [self.window addSubview:view];
    
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dismissToastView) userInfo:nil repeats:NO];
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void)
     {
         [view setAlpha:0.8];
     }completion:^(BOOL finished)
     {
         [view removeFromSuperview];
     }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //将device token转换为字符串
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    deviceTokenStr = [[deviceTokenStr substringWithRange:NSMakeRange(0, 72)] substringWithRange:NSMakeRange(1, 71)];
    [[NSUserDefaults standardUserDefaults] setObject:deviceTokenStr forKey:@"DeviceToken"];
    NSLog(@"deviceTokenStr = %@",deviceTokenStr);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"error is %@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    application.applicationIconBadgeNumber += 1;
    // We can determine whether an application is launched as a result of the user tapping the action
    // button or whether the notification was delivered to the already-running application by examining
    // the application state.
    
    //当用户打开程序时候收到远程通知后执行
    if (application.applicationState == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"订单提醒"
                                                            message:[NSString stringWithFormat:@"\n%@",
                                                                     [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
        
    }
}



@end
