//
//  HttpRequestField.h
//  Booking
//
//  Created by jinchenxin on 14-4-14.
//  Copyright (c) 2014年 jinchenxin. All rights reserved.
//
#define DEBUG 0
#if DEBUG
//正式服务器地址
#define BASEURLPATH @"http://music.app.weigee.net"
#define WEIGEEURLPATH @"http://center.app.weigee.net"
#define PAYBASEURLPATH @"http://pay.weigee.net"
#else
//测试服务器地址
#define BASEURLPATH @"http://center.wg.joomu.net/"
//#define BASEURLPATH @"http://weik.weigee.net"
//#define FILESERVER @"http://fileserver.wg.joomu.net"
#define FILESERVER @"http://file.weigee.net"
//#define PAYBASEURLPATH @"http://pay.weigee.net"
#define PAYBASEURLPATH @"http://pay.wg.joomu.net/"
#endif

//接口请求的子路径

#define USER_LOGIN @"/mobileUser/login.cmd" //用户登录
#define USER_REGISTER @"/mobileUser/register.cmd" //用户注册
#define USER_SMSCODE @"/mobileUser/sendSmsCode.cmd" //用户通过手机号获取验证码
#define USER_MAILCODE @"/mobileUser/sendEmailCode.cmd"//用户邮箱获取验证码
#define USER_SENDPWDCODE @"/mobileUser/sendPwdCode.cmd" //用户找回密码或绑定手机邮箱，获取验证码
#define USER_VERIFYCODE @"/mobileUser/verify.cmd" //找回用户密码或绑定手机邮箱，验证验证码
#define FIND_PWDCODE @"/mobileUser/findPwd.cmd" //找回密码，修改密码
#define USER_UPDATE @"/mobileUser/updateMember.cmd" //修改会员信息
#define USER_UPDATEPWD @"/mobileUser/updatePwd.cmd" //修改会员密码
#define USER_LOGOUT @"/mobileUser/logout.cmd" //退出登入
#define BUSSINESS_LIST @"/mobileShops/bussiness.cmd" //商圈列表
#define SHOP_NEARLIST @"/mobileShops/shopsList.cmd" //附近商家列表
#define FIND_ROOMLIST @"/mobileShops/roomList.cmd" //查询商家包房类型列表
#define ROB_ORDER @"/robOrder/order.cmd" //抢单管理
#define ROB_ORDERLIST @"/robOrder/orderList.cmd" //抢单列表
#define ROB_ORDERDETAIL @"/robOrder/robDetail.cmd" //抢单详情
#define ACCEPT_ORDER @"/robOrder/acceptOrder.cmd" //商家接单
#define SEARCH_DRINKLIST @"/mobileGoods/baseGoods.cmd" //系统商品（酒水）查询
#define GOODS_TYPELIST @"/mobileGoods/goodsType.cmd" //商品类型查询
#define COMM_PARAM @"/mobileCommon/commonParam.cmd" //公共参数查询
#define USER_ORDER_LIST @"/order/orderList.cmd"  //我的订单
#define COMMIT_SUGGESTION @"/mobileUser/feedback.cmd" //意见反馈
#define CONFIRM_ORDER @"/robOrder/confirm.cmd" //确认订单
#define UPLOAD_FILE @"uploadImg.cmd" //上传文件
#define MY_ORDER_DETAIL @"order/orderDetail.cmd" //我的订单详情
#define MY_MESSAGE @"/mobileCommon/listNews.cmd" //我的消息
#define PAY_SUBURL @"/gateway/index.cmd"
#define SUBMIT_COMMENT @"/order/addEvaluate.cmd" //评论的提交
#define PAY_METHOD @"/pay/paynotice.cmd"   //支付方式提交到服务器
#define QUERY_EVALUATE @"/order/queryEvaluate.cmd" //评论内容查询
#define SHOP_NOTICE @"/mobileCommon/queryMemberNotice.cmd"  //用户获取商家接单的信息

//Http请求接口标识
enum HTTPREQUESTTAG
{
    USERLOGIN = 0,
    USERREGISTER,
    SECURITYCODE,
    USERUPDATE,
    USERUPDATEPWD,
    USERLOGOUT,
    BUSINESSLIST,
    SHOPNEARLIST,
    FINDROOMLIST,
    ROBORDER,
    ROBORDERLIST,
    ROBORDERLIST0,
    ROBORDERLIST1,
    ROBORDERLIST2,
    ROBORDERLIST3,
    ROBORDERDETAIL,
    ACCEPTORDER,
    SEARCHDRINKLIST,
    GOODSTYPELIST,
    GETVERIFY,
    CHECKVERIFY,
    FINDPASSWORD,
    COMMPARAM,
    UNCOSTORDERLIST,
    COSTORDERLIST,
    SUGGESTION,
    CONFIRMORDER,
    UPLOADFILE,
    MYORDERDETAIL,
    MYMESSAGE,
    PAYCONST,
    MYORDERLIST0,
    MYORDERLIST1,
    MYORDERLIST2,
    MYORDERLIST3,
    SUBMITCOMMENT,
    PAYMETHOD,
    QUERYEVALUATE,
    SHOPNOTICE
};

//#define PAYKEYWORLD @"xNGG3i" //123456xNGG3i
#define PAYKEYWORLD @"wAg296"
//接口请求常量
#define USERCODE @"userCode"
#define PASSWORD @"passWord"
#define NEWPWD @"newPwd"
#define SID @"sid"
#define CITY @"city"
#define LATITUDE @"latitude"
#define LONGITUDE @"longitude"
#define INDEX @"index"
#define PAGESIZE @"pageSize"
#define TYPE @"type"
#define SHOPID @"shopId"
#define MEMBERID @"memberId"
#define PROVINCEID @"provinceId"
#define ROBTYPE @"robType"
#define VOLUMEID @"volumeId"
#define ARRIVETIME @"arriveTime"
#define CONSUMDURATION @"consumDuration"
#define CONSUMINTERVAL @"consumInterval"
#define CONSUMDATE @"consumDate"
#define ADDRESS @"address"
#define OFFERPRICE @"offerPrice"
#define CONTRACT @"contract"
#define MOBILE @"mobile"
#define SHOPTYPE @"shopType"
#define PARTYID @"partyId"
#define BUSINESSAREAID @"businessAreaId"
#define RANG @"rang"
#define GOODS @"goods"
#define APPOINTSHOPID @"appointShopId"
#define STATUS @"status"
#define ROBID @"robId"
#define ORDERRESOURCE @"orderResource"
#define ENDTIME @"endTime"
#define LEAVEWORD @"leaveWord"
#define TOTALPRICE @"totalPrice"
#define GOODSNAME @"goodsName"
#define TOPTYPE @"topType"
#define BRIEF @"brief"


@interface HttpRequestField : NSObject

@end
