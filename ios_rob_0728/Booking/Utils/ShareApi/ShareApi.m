//
//  ShareApi.m
//  Booking
//
//  Created by 1 on 14-6-27.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ShareApi.h"
#import "UserElement.h"
#import "SharedUserDefault.h"

#define ALERT_TAG 1000

#define SHARE_TITLE @"微歌,我K歌我定价"
#define SHARE_CONTENT1 @"HI,快来使用微歌预订KTV吧!注册时请输入我的邀请码"
#define SHARE_CONTENT2 @"你也可以邀请其他小伙伴一起Funs娱乐哦!"

@interface ShareApi ()
{
    NSArray *permissions;
    UserElement *userElement;
    NSString    *share_url;
}

@end

@implementation ShareApi

static ShareApi *shareApi;

+(ShareApi *)shareInstance
{
    if (shareApi == nil)
    {
        shareApi = [[ShareApi alloc] init];
        
    }
    return shareApi;
}

-(id)init
{
    if (self = [super init])
    {
        oauth = [[TencentOAuth alloc] initWithAppId:TENCENT_APP_ID andDelegate:self];
        
        //wxApi = [[WXApi alloc] init];
        [WXApi registerApp:WX_APP_ID];
        
        userElement = [[SharedUserDefault sharedInstance] getUserInfo];
        
        share_url = [NSString stringWithFormat:@"http://soft.weigee.net/invote.html?code=%@&1=1",userElement.inviteCode];
        
        permissions = [NSArray arrayWithObjects:
                         kOPEN_PERMISSION_GET_USER_INFO,
                         kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                         kOPEN_PERMISSION_ADD_ALBUM,
                         kOPEN_PERMISSION_ADD_IDOL,
                         kOPEN_PERMISSION_ADD_ONE_BLOG,
                         kOPEN_PERMISSION_ADD_PIC_T,
                         kOPEN_PERMISSION_ADD_SHARE,
                         kOPEN_PERMISSION_ADD_TOPIC,
                         kOPEN_PERMISSION_CHECK_PAGE_FANS,
                         kOPEN_PERMISSION_DEL_IDOL,
                         kOPEN_PERMISSION_DEL_T,
                         kOPEN_PERMISSION_GET_FANSLIST,
                         kOPEN_PERMISSION_GET_IDOLLIST,
                         kOPEN_PERMISSION_GET_INFO,
                         kOPEN_PERMISSION_GET_OTHER_INFO,
                         kOPEN_PERMISSION_GET_REPOST_LIST,
                         kOPEN_PERMISSION_LIST_ALBUM,
                         kOPEN_PERMISSION_UPLOAD_PIC,
                         kOPEN_PERMISSION_GET_VIP_INFO,
                         kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                         kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                         kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                         nil];
    }
    return self;
}

-(BOOL)handleOpenURL:(NSURL *)url
{
    if ([url.absoluteString hasPrefix:@"tencent"])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    else if ([url.absoluteString hasPrefix:@"wb"])
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    else
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
}

-(void)sendQQFriendMessage
{
    if ([oauth isSessionValid])
    {
        UIImage *img = [UIImage imageNamed:@"Icon.png"];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:share_url] title:SHARE_TITLE description:[NSString stringWithFormat:@"%@%@,%@",SHARE_CONTENT1,userElement.inviteCode,SHARE_CONTENT2] previewImageData:UIImagePNGRepresentation(img)];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        QQApiSendResultCode code = [QQApiInterface sendReq:req];
        if (code == EQQAPIQQNOTINSTALLED)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未检测到本机上安装QQ客户端" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在下载", nil];
            alertView.tag = ALERT_TAG + 1;
            [alertView show];
        }
    }
    else
    {
        [oauth authorize:permissions localAppId:TENCENT_APP_ID inSafari:YES];
    }
}

- (void)sendQQZoneMessage
{
    if ([oauth isSessionValid])
    {
        UIImage *img = [UIImage imageNamed:@"Icon.png"];
        
        QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:share_url] title:SHARE_TITLE description:[NSString stringWithFormat:@"%@%@,%@",SHARE_CONTENT1,userElement.inviteCode,SHARE_CONTENT2] previewImageData:UIImagePNGRepresentation(img)];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        QQApiSendResultCode code = [QQApiInterface SendReqToQZone:req];
        
        if (code == EQQAPIQQNOTINSTALLED)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未检测到本机上安装QQ客户端" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在下载", nil];
            alertView.tag = ALERT_TAG + 1;
            [alertView show];
        }
    }
    else
    {
        [oauth authorize:permissions localAppId:TENCENT_APP_ID inSafari:YES];
    }
}

- (void)sendWBMessage
{
    if ([oauth isSessionValid])
    {
        WeiBo_add_pic_t_POST *addPost = [[WeiBo_add_pic_t_POST alloc] init];
        addPost.param_content = [NSString stringWithFormat:@"%@%@,%@%@",SHARE_CONTENT1,userElement.inviteCode,SHARE_CONTENT2,share_url];
        addPost.param_pic = [UIImage imageNamed:@"Icon.png"];
        [oauth sendAPIRequest:addPost callback:self];
    }
    else
    {
        [oauth authorize:permissions localAppId:TENCENT_APP_ID inSafari:YES];
    }
}

-(void)sendWXZoneMessage
{
    if (![WXApi isWXAppInstalled])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未检测到本机上安装微信客户端" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在下载", nil];
        alertView.tag = ALERT_TAG + 2;
        [alertView show];
    }
    else
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = SHARE_TITLE;
        message.description = [NSString stringWithFormat:@"%@%@,%@",SHARE_CONTENT1,userElement.inviteCode,SHARE_CONTENT2];
        WXWebpageObject *object = [[WXWebpageObject alloc] init];
        object.webpageUrl = share_url;
        message.mediaObject = object;
        UIImage *img = [UIImage imageNamed:@"Icon.png"];
        message.thumbData = UIImagePNGRepresentation(img);
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.message = message;
        req.scene = WXSceneTimeline;
        [WXApi sendReq:req];
    }
}

-(void)sendWxFrienMessage
{
    if (![WXApi isWXAppInstalled])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未检测到本机上安装微信客户端" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在下载", nil];
        alertView.tag = ALERT_TAG + 2;
        [alertView show];
    }
    else
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = SHARE_TITLE;
        message.description = [NSString stringWithFormat:@"%@%@,%@",SHARE_CONTENT1,userElement.inviteCode,SHARE_CONTENT2];
        WXWebpageObject *object = [[WXWebpageObject alloc] init];
        object.webpageUrl = share_url;
        message.mediaObject = object;
        UIImage *img = [UIImage imageNamed:@"Icon.png"];
        message.thumbData = UIImagePNGRepresentation(img);
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.message = message;
        req.scene = WXSceneSession;
        [WXApi sendReq:req];
    }
}

-(void)sendSinaMessage
{
    if ([WeiboSDK isWeiboAppInstalled])
    {
        [WeiboSDK registerApp:SINA_APP_ID];
        WBMessageObject *messageObj = [WBMessageObject message];
        messageObj.text = [NSString stringWithFormat:@"%@%@,%@%@",SHARE_CONTENT1,userElement.inviteCode,SHARE_CONTENT2,share_url];
        WBImageObject *imgObj = [WBImageObject object];
        UIImage *img = [UIImage imageNamed:@"Icon.png"];
        imgObj.imageData = UIImagePNGRepresentation(img);
        messageObj.imageObject = imgObj;
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:messageObj];
        [WeiboSDK sendRequest:request];
    }
    else
    {
        
    }
}

- (void)showInvalidTokenOrOpenIDMessage{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"参数有误或者token失效，请检查参数或者重新登录" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark TCAPIRequestDelegate
- (void)cgiRequest:(TCAPIRequest *)request didResponse:(APIResponse *)response
{
    if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode)
    {
        NSMutableString *str=[NSMutableString stringWithFormat:@""];
        for (id key in response.jsonResponse)
        {
            [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil
                              
                                                       delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        NSString *errMsg = [NSString stringWithFormat:@"errorMsg:%@\n%@", response.errorMsg, [response.jsonResponse objectForKey:@"msg"]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:errMsg delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            if (alertView.tag - ALERT_TAG == 1)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[QQApiInterface getQQInstallUrl]]];
            }
            else if (alertView.tag - ALERT_TAG == 2)
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
            }
            break;
            
        default:
            break;
    }
}

- (void)payOrder:(NSString *)payInfo
{
    NSString *parternerId;
    NSString *prepayid;
    NSString *noncestr;
    NSString *timeStamp;
    NSString *package;
    NSString *sign;
    NSArray *array = [payInfo componentsSeparatedByString:@"&"];
    for (NSString *str in array) {
        NSArray *array1 = [str componentsSeparatedByString:@":"];
        if ([[array1 objectAtIndex:0] hasPrefix:@"noncestr"]) {
            noncestr = [array1 objectAtIndex:1];
            continue;
        }
        else if ([[array1 objectAtIndex:0] hasPrefix:@"package"]) {
            package = [array1 objectAtIndex:1];
            continue;
        }
        else if ([[array1 objectAtIndex:0] hasPrefix:@"partnerid"]) {
            parternerId = [array1 objectAtIndex:1];
            continue;
        }
        else if ([[array1 objectAtIndex:0] hasPrefix:@"prepayid"]) {
            prepayid = [array1 objectAtIndex:1];
            continue;
        }
        else if ([[array1 objectAtIndex:0] hasPrefix:@"sign"]) {
            sign = [array1 objectAtIndex:1];
            continue;
        }
        else if ([[array1 objectAtIndex:0] hasPrefix:@"timestamp"]) {
            timeStamp = [array1 objectAtIndex:1];
            continue;
        }
    }
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = parternerId;
    req.prepayId            = prepayid;
    req.nonceStr            = noncestr;
    req.timeStamp           = timeStamp.intValue;
    req.package             = package;
    req.sign                = sign;
    isPay                   = YES;
    [WXApi safeSendReq:req];
}

#pragma mark WXApiDelegate

- (void)onReq:(BaseReq *)req
{
    
}

- (void)onResp:(BaseResp *)resp
{
    //支付和分享成功之后都会调用同一个接口
    if (isPay) {
        if (resp.errCode == 0)
        {
            [self.delegate wxPayResult];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"感谢您的预定,消费码已通过短信下发到您的手机上了,请准时享受" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"支付失败,请稍后重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        isPay = NO;
    }
    else
    {
        
    }
}

#pragma mark WeiboSDKDelegate

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"%@",response);
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

#pragma mark 

- (void)tencentDidLogin
{
    NSLog(@"tencent did login");
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"tencent did not login");
}

- (void)tencentDidNotNetWork
{
    NSLog(@"tencent did not network");
}

@end
