//
//  HttpRequestComm.m
//  Booking
//
//  Created by jinchenxin on 14-4-14.
//  Copyright (c) 2014年 jinchenxin. All rights reserved.
//

#import "HttpRequestComm.h"
#import "SharedUserDefault.h"
#import "UserElement.h"
#import "NSString+CheckUserInfo.h"

static HttpRequestComm *requestComm ;

@implementation HttpRequestComm

+(void)updateFile:(NSString*)imgPath withIsCompress:(NSString*)isCompress withDelegate:(id)own
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:isCompress forKey:@"isCompress"];
    [paramDic setObject:@"100,100,mobile" forKey:@"compressStr"];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initUploadFileRequest:paramDic withFilePath:imgPath operationTag:UPLOADFILE];
}

/*
 * 用户登录
 * @param userCode 用户名
 * @param password 密码
 * @param own 协议拥有者
 */
+(void)userLogin:(NSString *) userCode AndPassword:(NSString *) password withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:userCode forKey:USERCODE];
    [paramDic setObject:[password md5] forKey:PASSWORD];
    [paramDic setObject:@"1" forKey:@"loginType"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"]!=nil)
    {
        [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"] forKey:@"device"];
    }
    HttpBaseRequest *request = [[HttpBaseRequest alloc]initWithDelegate:own];
    [request initRequestComm:paramDic withURL:USER_LOGIN operationTag:USERLOGIN];
}

/*
 * 用户注册
 * @param paramDic 用户注册所以信息字典
 * @param own 协议拥有者
 */
+(void)userRegister:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:USER_REGISTER operationTag:USERREGISTER];
}

/*
 * 验证码的获取
 * @param userCode 用户名（手机号）
 */
+(void)getCecurityCode:(NSString *) userCode withDelegate:(id) own withFlag:(NSString *)flag{
    
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:userCode forKey:USERCODE];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    if (flag == nil)
    {
        [request initRequestComm:paramDic withURL:USER_SMSCODE operationTag:SECURITYCODE];
    }
    else
    {
        [request initRequestComm:paramDic withURL:USER_MAILCODE operationTag:SECURITYCODE];
    }
}

/*
 * 找回密码或绑定手机和邮箱是获取验证码，调用此方法
 *
 */
+(void)getVerifyCode:(NSDictionary *)dic withDelegate:(id) own
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:USER_SENDPWDCODE operationTag:GETVERIFY];
}

/*
 * 验证找回密码或绑定手机和邮箱验证码,调用此方法
 *
 */
+(void)checkVerifyCode:(NSMutableDictionary *)dic withDelegate:(id) own
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:USER_VERIFYCODE operationTag:CHECKVERIFY];
}

/*
 * 修改会员信息
 * @param paramDic 会员信息字典
 */
+(void)updateMemberInfo:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:USER_UPDATE operationTag:USERUPDATE];
}

+(void)findPassWord:(NSString *) newPwd andUserCount:(NSString *) account withDelegate:(id) own
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:account forKey:USERCODE];
    [paramDic setObject:newPwd forKey:PASSWORD];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:FIND_PWDCODE operationTag:FINDPASSWORD];
}

/*
 * 修改会员密码
 * @param newPwd 新密码
 * @param sid 会话Id
 */
+(void)updatePassWord:(NSMutableDictionary *)paramDic withDelegate:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:USER_UPDATEPWD operationTag:USERUPDATEPWD];
}

/*
 * 退出登录
 * @param own 协议拥有者
 */
+(void)userLogout:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    //[paramDic setObject:[[[SharedUserDefault sharedInstance] getUserInfo] userCode] forKey:USERCODE];
    [paramDic setObject:@"000" forKey:USERCODE];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:USER_LOGOUT operationTag:USERLOGOUT];
}

/*
 * 商圈列表
 * @param city(城市Id)
 * @param own 协议拥有者
 */
+(void)getBusinessList:(NSString *) cityId withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:cityId forKey:CITY];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:BUSSINESS_LIST operationTag:BUSINESSLIST];
}

/*
 * 附近商家列表
 * @param paramDic 参数详情
 * @param own 协议拥有者
 */
+(void)getNearShopList:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    [paramDic setObject:@"20" forKey:PAGESIZE];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:SHOP_NEARLIST operationTag:SHOPNEARLIST];
}

/*
 * 查询商家包房类型列表
 * @param shopId 商品Id
 * @param own 协议拥有者
 */
+(void)getShopRoomList:(NSString *) shopId withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:shopId forKey:SHOPID];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:FIND_ROOMLIST operationTag:FINDROOMLIST];
}

/*
 * 发布抢单
 * @param paramDic 抢单详情信息
 * @param own 协议拥有者
 */
+(void)sendRobOrder:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    UserElement *element = [[SharedUserDefault sharedInstance] getUserInfo];
    [paramDic setObject:element.memberId forKey:MEMBERID];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:ROB_ORDER operationTag:ROBORDER];
}

/*
 * 抢单列表
 */
+(void) getRobOrderList:(NSString *) status atIndex:(NSString *) index withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:status forKey:STATUS];
    [paramDic setObject:index forKey:INDEX];
    [paramDic setObject:@"10" forKey:PAGESIZE];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:ROB_ORDERLIST operationTag:ROBORDERLIST];
}

/*
 * 抢单正在进行列表
 * @param index 起始页
 * @param own 协议拥有者
 */
+(void) getrRobOrderDoingList:(NSInteger) index withUserFlag:(NSString *)flag withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:@"0" forKey:STATUS];
    [paramDic setObject:[NSString stringWithFormat:@"%d",index] forKey:INDEX];
    [paramDic setObject:@"10" forKey:PAGESIZE];
    if (flag != nil&&![flag isEqualToString:@""]) {
        UserElement *userElement = [[SharedUserDefault sharedInstance] getUserInfo];
        if ([userElement.memberId integerValue] != 0) {
            [paramDic setObject:userElement.memberId forKey:MEMBERID];
            //测试memberID为21
            //[paramDic setObject:@"21" forKey:MEMBERID];
        }
    }
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:ROB_ORDERLIST operationTag:ROBORDERLIST0];
}

/*
 * 抢单已成交列表
 * @param index 起始页
 * @param own 协议拥有者
 */
+(void) getrRobOrderFinishList:(NSInteger) index withUserFlag:(NSString *)flag withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:@"1" forKey:STATUS];
    [paramDic setObject:[NSString stringWithFormat:@"%d",index] forKey:INDEX];
    [paramDic setObject:@"10" forKey:PAGESIZE];
    if (flag != nil&&![flag isEqualToString:@""]) {
        UserElement *userElement = [[SharedUserDefault sharedInstance] getUserInfo];
        if ([userElement.memberId integerValue] != 0) {
            [paramDic setObject:userElement.memberId forKey:MEMBERID];
            //测试memberID为21
            //[paramDic setObject:@"21" forKey:MEMBERID];
        }
    }
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:ROB_ORDERLIST operationTag:ROBORDERLIST1];
}

/*
 * 抢单未成交列表
 * @param index 起始页
 * @param own 协议拥有者
 */
+(void) getrRobOrderUndoneList:(NSInteger) index withUserFlag:(NSString *)flag withDelegate:(id)own{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:@"2" forKey:STATUS];
    [paramDic setObject:[NSString stringWithFormat:@"%d",index] forKey:INDEX];
    [paramDic setObject:@"10" forKey:PAGESIZE];
    if (flag != nil&&![flag isEqualToString:@""]) {
        UserElement *userElement = [[SharedUserDefault sharedInstance] getUserInfo];
        if ([userElement.memberId integerValue] != 0) {
            [paramDic setObject:userElement.memberId forKey:MEMBERID];
            //测试memberID为21
            //[paramDic setObject:@"21" forKey:MEMBERID];
        }
    }
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:ROB_ORDERLIST operationTag:ROBORDERLIST2];
}

/*
 * 抢单详情
 * @param robId 抢单Id
 * @param index 起始页
 */
+(void) findOrderDetail:(NSString *) robId atIndex:(NSString *) index withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:robId forKey:ROBID];
    [paramDic setObject:index forKey:INDEX];
    [paramDic setObject:@"100" forKey:PAGESIZE];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:ROB_ORDERDETAIL operationTag:ROBORDERDETAIL];
}

/*
 * 商家接单
 * @param paramDic 接单详情信息
 * @param own 协议拥有者
 */
+(void) shopAcceptOrder:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own ];
    [request initRequestComm:paramDic withURL:ACCEPT_ORDER operationTag:ACCEPTORDER];
}

/*
 * 系统用户抢单酒水查询
 * @param keyWord 搜索关键字
 * @param topType 搜索酒水类型
 * @param index 起始页
 */
+(void) getDrinksList:(NSString *) keyWord andTopType:(NSString *) topType atIndex:(NSInteger) index withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:keyWord forKey:GOODSNAME];
    [paramDic setObject:topType forKey:TOPTYPE];
    [paramDic setObject:[NSString stringWithFormat:@"%d",index] forKey:INDEX];
    [paramDic setObject:@"10" forKey:PAGESIZE];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:SEARCH_DRINKLIST operationTag:SEARCHDRINKLIST];
}

/*
 * 商品类型查询
 * @param own 协议拥有者
 */
+(void) getGoodsTypeList:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:nil withURL:GOODS_TYPELIST operationTag:GOODSTYPELIST];
}
/*
 * 公共参数查询
 */
+(void) getCommonparamsList:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:nil withURL:COMM_PARAM operationTag:COMMPARAM];
}

/*
 * 用户订单列表
 */
+(void) getUserOrderListWithStatus:(NSString *)status withIndex:(NSString *)index withDelegate:(id)own
{
    UserElement *userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    [mulDic setObject:status forKey:@"isCost"];
    [mulDic setObject:index forKey:INDEX];
    [mulDic setObject:@"10" forKey:PAGESIZE];
    [mulDic setObject:userElement.memberId forKey:MEMBERID];
    //[mulDic setObject:@"21" forKey:MEMBERID];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    if ([status integerValue] == 0)
    {
        [request initRequestComm:mulDic withURL:USER_ORDER_LIST operationTag:UNCOSTORDERLIST];
    }
    else if ([status integerValue] == 1)
    {
        [request initRequestComm:mulDic withURL:USER_ORDER_LIST operationTag:COSTORDERLIST];
    }
    
}

/*
 * 订单详情
 */
+(void) getUserOrderDetailWithId:(NSString *)orderId withPageIndex:(NSInteger)index withDelegate:(id)own
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    [mulDic setObject:orderId forKey:@"orderId"];
    //[mulDic setObject:@"206" forKey:@"orderId"];
    [mulDic setObject:[NSNumber numberWithInteger:index] forKey:@"index"];
    [mulDic setObject:@"20" forKey:@"pageSize"];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:mulDic withURL:MY_ORDER_DETAIL operationTag:MYORDERDETAIL];
}

/*
 * 获取用户消息
 */
+(void)getUserMessageWithMemId:(NSString*)memId withPageIndex:(NSInteger)index withDelegate:(id) own
{
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    [mulDic setObject:memId forKey:@"memberId"];
    //[mulDic setObject:@"21" forKey:@"memberId"];
    [mulDic setObject:[NSNumber numberWithInteger:index] forKey:@"index"];
    [mulDic setObject:@"20" forKey:@"pageSize"];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:mulDic withURL:MY_MESSAGE operationTag:MYMESSAGE];
}

+(void)commitSuggestion:(NSString *)content withDelegate:(id)own
{
    UserElement *userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
    [mulDic setObject:content forKey:@"content"];
    [mulDic setObject:userElement.memberId forKey:MEMBERID];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:mulDic withURL:COMMIT_SUGGESTION operationTag:SUGGESTION];
}

/*
 * 确认订单
 * @param robId 抢单Id
 * @param shopId 商品Id
 * @param own协议拥有者
 */
+(void) confirmOrder:(NSString *) robId andShopId:(NSString *) shopId withDelegate:(id) own {
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:robId forKey:ROBID];
    [paramDic setObject:shopId forKey:SHOPID];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:CONFIRM_ORDER operationTag:CONFIRMORDER];
}

/*
 * 支付方法
 */
+(void) payAcceptOrderCost:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initPayRequest:paramDic withURL:PAY_SUBURL operationTag:PAYCONST];
}

/*
 * 条件筛选订单
 */
+(void) condictionOrderList:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc]initWithDelegate:own ];
    [paramDic setObject:@"10" forKey:PAGESIZE];
    [request initRequestComm:paramDic withURL:ROB_ORDERLIST operationTag:0];
}

/*
 * 我的订单列表
 */
+(void) myOrderList:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    UserElement *element = [[SharedUserDefault sharedInstance] getUserInfo];
    [paramDic setObject:element.memberId forKey:MEMBERID];
    [paramDic setObject:@"10" forKey:PAGESIZE];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    NSInteger tagId = [[paramDic objectForKey:@"tagId"] integerValue];
    [request initRequestComm:paramDic withURL:USER_ORDER_LIST operationTag:tagId];
}

/*
 * 评论列表的提交
 */
+(void) submitCommentInfo:(NSMutableDictionary *) paramDic withDelegate:(id) own {
    UserElement *element = [[SharedUserDefault sharedInstance] getUserInfo];
    [paramDic setObject:element.memberId forKey:MEMBERID];
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:SUBMIT_COMMENT operationTag:SUBMITCOMMENT];
}

+(void) submitPayMethod:(NSMutableDictionary *)paramDic withDelegate:(id)own
{
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initPayRequest:paramDic withURL:PAY_METHOD operationTag:PAYMETHOD];
}

+(void) queryEvaluate:(NSMutableDictionary*)paramDic withDelegate:(id)own
{
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:QUERY_EVALUATE operationTag:QUERYEVALUATE];
}

+(void) queryMemberNotice:(NSMutableDictionary*)paramDic withDelegate:(id)own
{
    HttpBaseRequest *request = [[HttpBaseRequest alloc] initWithDelegate:own];
    [request initRequestComm:paramDic withURL:SHOP_NOTICE operationTag:SHOPNOTICE];
}


@end
