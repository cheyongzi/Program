//
//  ConsumePayController.m
//  Booking
//
//  Created by jinchenxin on 14-6-17.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#define KMessage @"感谢您的预定,消费码已通过短信下发到您的手机上了,请准时享受"
#define kMode @"00"

#import "ConsumePayController.h"
#import "AlixLibService.h"
#import "UPPayPlugin.h"
#import "NSString+CheckUserInfo.h"
#import "OrderConfirmResponse.h"
#import "UserZoneMainViewController.h"
#import "ShareApi.h"

@interface ConsumePayController ()<ShareApiDelegate>

@end

@implementation ConsumePayController

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
    self.title = @"支付";
    self.bgImg.image = [[UIImage imageNamed:@"con_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    if(self.price == nil || [self.price isEqualToString:@""]) self.price = @"0";
    self.priceLa.text = [NSString stringWithFormat:@"%@元",self.price];
    
    //注册广播通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvBcast:) name:PAYRESULTINFO object:nil];
}

- (void)popViewController
{
    [super popViewController];
    [SVProgressHUD dismiss];
}

-(void)recvBcast:(id) obj
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"预定成功!" message:KMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = 100 ;
    [alert show];
}


/*
 * 支付方式事件
 */
-(IBAction)payClickEvent:(id)sender {
    /*
     * 100 支付宝支付
     * 101 银联支付
     * 102 微信支付
     */
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ConstanStringFile" ofType:@"strings"];
//    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//    NSString *payInfo = [dic objectForKey:@"pay_info"];
    UIButton *btn = (UIButton *)sender ;
    NSInteger valueTag = btn.tag ;
    //支付参数
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    //[paramDic setObject:@"a5bfac64-dd25-459f-b01c-8ec0fa7566a7" forKey:@"merchId"];
    [paramDic setObject:@"m123" forKey:@"merchId"];
    [paramDic setObject:self.orderId forKey:@"requestId"];
    [paramDic setObject:self.price forKey:@"amount"];
    [paramDic setObject:[NSString stringWithFormat:@"%@(%@)",self.shopName,self.roomType] forKey:@"subject"];
    [paramDic setObject:@"http://192.168.1.95:8080/weigee" forKey:@"backUrl"];
    [paramDic setObject:@"订单详情说明" forKey:@"detail"];
    if(valueTag == 100){
       [paramDic setObject:@"alimobile" forKey:@"providerId"];
        self.payPosition = 100 ;
    }else if(valueTag == 101){
       [paramDic setObject:@"unmpay" forKey:@"providerId"];
        self.payPosition = 101 ;
    }else if (valueTag == 102)
    {
        self.payPosition = 102;
        //[paramDic setObject:[NSString stringWithFormat:@"%d",[self.price intValue]*100] forKey:@"amount"];
        [paramDic setObject:@"weChatPay" forKey:@"providerId"];
    }
    
    //支付参数按字符大小排序
    NSString *sigStr = [ConUtils stingSort:paramDic];
    //MD5加密sig字符串
    NSString *parSig = [sigStr md5];
    parSig = [NSString stringWithFormat:@"%@%@",parSig,@"123456"];
    parSig = [parSig md5];
    
    [paramDic setObject:parSig forKey:@"sig"];
    [paramDic setObject:@"3" forKey:@"type"];
    [HttpRequestComm payAcceptOrderCost:paramDic withDelegate:self];
    [SVProgressHUD show];

}

/*
 * 支付宝支付方法
 */
-(void) payOrder:(NSString *) info {
    //返回的info请求参数调用支付宝sdk的支付接口
    [AlixLibService payOrder:info AndScheme:@"Booking" seletor:@selector(payResult:) target:self];
}

-(void)payResult:(id)sender{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *statue = [userDefault objectForKey:@"payStute"];
    if([@"1" isEqualToString:statue])
    {
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:self.orderId forKey:@"orderNum"];
        [mulDic setObject:@"ZFB" forKey:@"payCode"];
        NSString *sigStr = [ConUtils stingSort:mulDic];
        NSString *parSig = [sigStr md5];
        parSig = [NSString stringWithFormat:@"%@%@",parSig,PAYKEYWORLD];
        parSig = [parSig md5];
        [mulDic setObject:parSig forKey:@"sig"];
        [HttpRequestComm submitPayMethod:mulDic withDelegate:self];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"支付结果" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"", nil];
        [alert show];
    }else{
        [self showToast:@"支付失败！"];
    }
}

//银联支付
-(void)startPay:(NSString *)info{
    [UPPayPlugin startPay:info mode:kMode viewController:self delegate:self];
}

#pragma mark -UPPayDelegate
-(void)UPPayPluginResult:(NSString *)result{
    // success、fail、cancel 三种支付结果状态
    if([@"success" isEqualToString:result])
    {
        NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
        [mulDic setObject:self.orderId forKey:@"orderNum"];
        [mulDic setObject:@"YL" forKey:@"payCode"];
        NSString *sigStr = [ConUtils stingSort:mulDic];
        NSString *parSig = [sigStr md5];
        parSig = [NSString stringWithFormat:@"%@%@",parSig,PAYKEYWORLD];
        parSig = [parSig md5];
        [mulDic setObject:parSig forKey:@"sig"];
        [HttpRequestComm submitPayMethod:mulDic withDelegate:self];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"预定成功!" message:KMessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self showToast:@"支付失败,请重新尝试!"];
    }
}

/**
 *  微信支付
 *
 *  @param payInfo 服务器返回的支付信息
 *
 *  @since 1.0.0
 */
- (void)wxPay:(NSString*)payInfo
{
    [[ShareApi shareInstance] payOrder:payInfo];
}

- (void)wxPayResult
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    [mulDic setObject:self.orderId forKey:@"orderNum"];
    [mulDic setObject:@"WECHAT" forKey:@"payCode"];
    NSString *sigStr = [ConUtils stingSort:mulDic];
    NSString *parSig = [sigStr md5];
    parSig = [NSString stringWithFormat:@"%@%@",parSig,PAYKEYWORLD];
    parSig = [parSig md5];
    [mulDic setObject:parSig forKey:@"sig"];
    [HttpRequestComm submitPayMethod:mulDic withDelegate:self];
}

#pragma mark -HttpRequestCommDelegate
-(void) httpRequestSuccessComm:(int)tagId withInParams:(id)inParam
{
    switch (tagId) {
        case PAYCONST:
        {
            [SVProgressHUD dismiss];
            OrderConfirmResponse *orderConResonse = [[OrderConfirmResponse alloc] init];
            [orderConResonse setResultData:inParam];
            if(orderConResonse.code == 0){
                NSString *payInfo = orderConResonse.payInfo ;
                if(![payInfo isEqualToString:@""]){
                    if(self.payPosition == 100)
                    {
                        [self payOrder:payInfo];
                    }else if(self.payPosition == 101)
                    {
                        [self startPay:payInfo];
                    }
                    else if (self.payPosition == 102)
                    {
                        [self wxPay:payInfo];
                    }
                }
            }
            //[self showToast:orderConResonse.message];
        }
            break;
        case PAYMETHOD:
            
            break;
            
        default:
            break;
    }
    
}

-(void) httpRequestFailueComm:(int)tagId withInParams:(NSString *)error {
    switch (tagId) {
        case PAYCONST:
            [SVProgressHUD dismiss];
            [self showToast:@"网络异常，请稍后重试"];
            break;
        case PAYMETHOD:
            break;
        default:
            break;
    }
}

#pragma mark -AlertViewDelegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger tagValue = alertView.tag ;
    if(tagValue == 100) {
        UserZoneMainViewController *zoneMainCon = [[UserZoneMainViewController alloc] init];
        [self.navigationController pushViewController:zoneMainCon animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
