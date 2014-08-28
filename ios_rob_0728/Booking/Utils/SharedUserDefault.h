//
//  ShareUserDefault.h
//  Booking
//
//  Created by jinchenxin on 14-4-11.
//  Copyright (c) 2014年 jinchenxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantField.h"
#import "UserElement.h"
#import "SystemParamResponse.h"


@interface SharedUserDefault : NSObject


+(SharedUserDefault *)sharedInstance;

/*
 * 设置用户是否是第一次启动app
 */
-(void)setFirstStartApp:(NSString *)isFirst;

/*
 * 判断用户是否是第一次启动app
 */
-(NSString *)isFirstStartApp;

/*
 * 判断用户是否登入状态
 */
-(BOOL)isLogin;

/**
 *  应用评论弹出框
 *
 *  @return 是否已经弹出过对话框
 *
 *  @since 1.0.0
 */
-(BOOL)isUserComment;

/**
 *  设置是否已应用弹出框
 *
 *  @param comment 是否已弹出对话框标识位
 *
 *  @since 1.0.0
 */
-(void)setUserComment:(NSString *)comment;

/*
 * 设置用户的登陆状态
 */
- (void)setLoginState:(NSString *)state;

/*
 * 存储用户的数据
 */
- (void)setUserInfo:(NSData *)userElement;

/*
 * 存储用户绑定的其他帐号的信息
 */
- (void)setUserBindInfo:(NSMutableDictionary *)infoDic withMemberId:(NSString *)memberId;

/*
 * 获取用户绑定的其他帐号的信息
 */
- (NSDictionary *)getUserBindInfo:(NSString*)memberId;


/*
 * 获取用户的数据
 */
- (UserElement *)getUserInfo;


/*
 * 用户退出登入状态
 */
-(void)exitLogin;

/*
 * 拿到用户的Id
 */
-(NSString *)getUserId;

/*
 * 拿到用户的名字
 */
-(NSString *)getUserName;

/*
 * 拿到用户的电话号码
 */
-(NSString *)getUserTel;

/*
 * 判断是否发送唯一标识及版本状态
 */
-(BOOL) isSendVersionIndentifier ;

/*
 * 设置城市的名称
 */
-(void) setCityName:(NSString *) cityName ;

/*
 * 拿到城市名称
 */
-(NSString *) getCityName;

/*
 * 设置当前位置的经，纬度
 */
-(void) setLatitudeAndLongitude:(NSString *) lat andLat:(NSString *) lon ;

/*
 * 拿到当前的经度
 */
-(NSString *) getLongitude ;

/*
 * 拿到当前纬度
 */
-(NSString *) getLatitude ;

/*
 * 设置定位的具体位置地址
 */
-(void) setCurrentAddress:(NSString *) address ;

/*
 * 拿到上一次定位后的具体地址
 */
-(NSString *) getCurrentAddress ;

/*
 * 是否开启仅通过Wi-Fi联网
 */
//-(BOOL) isOpenWifiNetWork ;
//-(void) setOpenWifiNetWork:(BOOL) state ;

/*
 * 省份文件的解析
 */
-(NSArray *) getProvincesList ;

/*
 * 城市文件的解析
 */
-(NSArray *) getCityList ;

/*
 * 省份城市列表
 */
-(NSMutableDictionary *) getProvinceCitysList ;

/*
 * 依据城市名查找城市编号
 */
-(NSString *) getCityCode:(NSString *) cityName ;

/*
 * 根据系统参数名获取该类数组
 * @param typeName 系统参数键值
 */
-(NSArray *) getSystemType:(NSString *) typeName ;

/*
 * 根据系统参数获取对应的参数值
 * @param typeName 系统参数键值
 * @param paramId 类型id
 */
-(NSString *) getSystemNameType:(NSString *) typeName andTypeKey:(NSString *) paramId ;

/*
 * 系统参数的保存数据
 */
-(void) saveSysetmParam:(id) inParam ;

/*
 * 系统参数的获取
 */
-(id) getSystemParam ;

/*
 * 清理图片缓存
 */
- (void)clearImgCache;

/*
 * 清理数据缓存
 */
- (void)clearDataCache;

@end
