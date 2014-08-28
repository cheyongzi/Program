//
//  HttpRequestComm.h
//  Booking
//
//  Created by jinchenxin on 14-4-14.
//  Copyright (c) 2014年 jinchenxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpBaseRequest.h"
#import "HttpRequestField.h"

@interface HttpRequestComm : NSObject

/*
 *上传文件
 */
+(void)updateFile:(NSString*)imgPath withIsCompress:(NSString*)isCompress withDelegate:(id)own;

/*
 * 用户登录
 * @param userCode 用户名
 * @param password 密码
 * @param own 协议拥有者
 */
+(void)userLogin:(NSString *) userCode AndPassword:(NSString *) password withDelegate:(id) own ;

/*
 * 用户注册
 * @param paramDic 用户注册所以信息字典
 * @param own 协议拥有者
 */
+(void)userRegister:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 * 验证码的获取
 * @param userCode 用户名（手机号）
 */
+(void)getCecurityCode:(NSString *) userCode withDelegate:(id) own withFlag:(NSString *)flag;

/*
 * 找回密码或绑定手机和邮箱是获取验证码，调用此方法
 *
 */
+(void)getVerifyCode:(NSDictionary *)dic withDelegate:(id) own;

/*
 * 验证找回密码或绑定手机和邮箱验证码,调用此方法
 *
 */
+(void)checkVerifyCode:(NSMutableDictionary *)dic withDelegate:(id) own;

/*
 * 修改会员信息
 * @param paramDic 会员信息字典
 */
+(void)updateMemberInfo:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 *
 * 找回密码调用此方法
 */
+(void)findPassWord:(NSString *) newPwd andUserCount:(NSString *) account withDelegate:(id) own;

/*
 * 修改会员密码
 * @param newPwd 新密码
 * @param sid 会话Id
 */
+(void)updatePassWord:(NSMutableDictionary *)paramDic withDelegate:(id) own ;

/*
 * 退出登录
 * @param own 协议拥有者
 */
+(void)userLogout:(id) own ;

/*
 * 商圈列表
 * @param city(城市Id)
 * @param own 协议拥有者
 */
+(void)getBusinessList:(NSString *) cityId withDelegate:(id) own ;

/*
 * 附近商家列表
 * @param paramDic 参数详情
 * @param own 协议拥有者
 */
+(void)getNearShopList:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 * 查询商家包房类型列表
 * @param shopId 商品Id
 * @param own 协议拥有者
 */
+(void)getShopRoomList:(NSString *) shopId withDelegate:(id) own ;

/*
 * 发布抢单
 * @param paramDic 抢单详情信息
 * @param own 协议拥有者
 */
+(void)sendRobOrder:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 * 抢单列表
 * @param status 抢单状态
 * @param index 起始页
 * @param own 协议拥有者
 */
+(void) getRobOrderList:(NSString *) status atIndex:(NSString *) index withDelegate:(id) own ;

/*
 * 抢单正在进行列表
 * @param index 起始页
 * @param own 协议拥有者
 */
+(void) getrRobOrderDoingList:(NSInteger) index withUserFlag:(NSString *)flag withDelegate:(id) own ;

/*
 * 抢单已成交列表
 * @param index 起始页
 * @param own 协议拥有者
 */
+(void) getrRobOrderFinishList:(NSInteger) index withUserFlag:(NSString *)flag withDelegate:(id) own ;

/*
 * 抢单未成交列表
 * @param index 起始页
 * @param own 协议拥有者
 */
+(void) getrRobOrderUndoneList:(NSInteger) index withUserFlag:(NSString *)flag withDelegate:(id) own ;

/*
 * 会员抢单列表
 * @param status 抢单状态
 * @param memberId 会员id
 * @param index 起始页
 * @param own 协议拥有者
 */
//+(void) getRobOrderList:(NSString *)status atIndex:(NSString *)index AndmemberId:(NSString *) memberId withDelegate:(id)own;

/*
 * 抢单详情
 * @param robId 抢单Id
 * @param index 起始页
 */
+(void) findOrderDetail:(NSString *) robId atIndex:(NSString *) index withDelegate:(id) own ;

/*
 * 商家接单
 * @param paramDic 接单详情信息
 * @param own 协议拥有者
 */
+(void) shopAcceptOrder:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 * 系统用户抢单酒水查询
 * @param keyWord 搜索关键字
 * @param topType 搜索酒水类型
 * @param index 起始页
 */
+(void) getDrinksList:(NSString *) keyWord andTopType:(NSString *) topType atIndex:(NSInteger) index withDelegate:(id) own ;

/*
 * 商品类型查询
 * @param own 协议拥有者
 */
+(void) getGoodsTypeList:(id) own ;

/*
 * 公共参数查询
 */
+(void) getCommonparamsList:(id) own ;

/*
 * 用户订单列表
 * status 0表示未消费  1表示已消费
 */
+(void) getUserOrderListWithStatus:(NSString *)status withIndex:(NSString *)index withDelegate:(id)own;

/*
 * 订单详情
 */
+(void) getUserOrderDetailWithId:(NSString *)orderId withPageIndex:(NSInteger)index withDelegate:(id)own;

/*
 * 用户订单列表
 * status 0表示未消费  1表示已消费
 */
+(void)commitSuggestion:(NSString *)content withDelegate:(id)own;

/*
 * 确认订单
 * @param robId 抢单Id
 * @param shopId 商品Id
 * @param own协议拥有者
 */
+(void) confirmOrder:(NSString *) robId andShopId:(NSString *) shopId withDelegate:(id) own ;

/*
 * 获取用户消息
 */
+(void) getUserMessageWithMemId:(NSString*)memId withPageIndex:(NSInteger)index withDelegate:(id) own;

/*
 * 支付方法
 */
+(void) payAcceptOrderCost:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 * 条件筛选订单
 */
+(void) condictionOrderList:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 * 商家配单完成
 */
//+(void) acceptOrderFinish:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 * 我的订单列表
 */
+(void) myOrderList:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/*
 * 评论列表的提交
 */
+(void) submitCommentInfo:(NSMutableDictionary *) paramDic withDelegate:(id) own ;

/**
 *  提交用户支付的方式到服务器
 *
 *  @param paramDic  服务器传送的参数
 *  @param own       代理
 *
 *  @since 1.0.0
 */
+(void) submitPayMethod:(NSMutableDictionary *)paramDic withDelegate:(id)own;

/**
 *  查询已评论的订单信息
 *
 *  @param paramDic 服务器传送的参数
 *  @param own      delegate
 *
 *  @since 1.0.0
 */
+(void) queryEvaluate:(NSMutableDictionary*)paramDic withDelegate:(id)own;

/**
 *  用户查询商家接单的数目
 *
 *  @param paramDic 服务器传递参数
 *  @param own      delegate
 *
 *  @since 1.0.0
 */
+(void) queryMemberNotice:(NSMutableDictionary*)paramDic withDelegate:(id)own;

@end
