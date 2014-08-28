//
//  ShareApi.h
//  Booking
//
//  Created by 1 on 14-6-27.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

typedef enum
{
   TencentType = 0,
    WXType,
}ShareType;

#define TENCENT_APP_ID @"1101158778"
#define WX_APP_ID      @"wxafe9068a24767687"//@"wxd930ea5d5a258f4f"

#define SINA_APP_ID @"2810497069"
#define SINA_SECRET @"71fed988f55337ec8e88a889da9fc4b4"


#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/WeiBoAPI.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@protocol ShareApiDelegate <NSObject>

- (void)wxPayResult;

@end

@interface ShareApi : NSObject<TencentSessionDelegate,WXApiDelegate,TCAPIRequestDelegate,UIAlertViewDelegate,WeiboSDKDelegate>
{
    //QQ平台分享
    TencentOAuth *oauth;
    //微信平台分享
    WXApi       *wxApi;
    BOOL        isPay;
}

@property (strong, nonatomic) id<ShareApiDelegate> delegate;

+(ShareApi *)shareInstance;

-(BOOL)handleOpenURL:(NSURL *)url;

//QQ好友分享
-(void)sendQQFriendMessage;

//QQ空间分享
-(void)sendQQZoneMessage;

//腾讯微博分享
-(void)sendWBMessage;

//微信平台分享
-(void)sendWXZoneMessage;
//微信好友分享
-(void)sendWxFrienMessage;

//新浪微博分享
-(void)sendSinaMessage;

/**
 *  微信支付接口
 *
 *  @param payInfo 支付信息
 *
 *  @since 1.0.0
 */
-(void)payOrder:(NSString*)payInfo;
@end
