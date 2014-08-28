//
//  JsonUtils.h
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequireElement.h"
#import "WineElement.h"
#import "UserElement.h"
#import "VerifyElement.h"
#import "ProviderElement.h"
#import "AcceptOrderElement.h"
#import "ParamElement.h"
#import "OrderElement.h"
#import "EvaluateElement.h"


/*
 * 数据模型Json解析工具类
 */
@interface JsonUtils : NSObject

/*
 * 抢单数据模型json解析
 */
+(RequireElement *) jsonRequireElement:(id) inParam ;

/*
 * 酒水数据模型json解析
 */
+(WineElement *) jsonWineElement:(id) inParam ;

/*
 * 用户数据模型json解析
 */
+(UserElement *) jsonUserElement:(id) inParam ;

/*
 * 获取验证码模型json解析
 */
+(VerifyElement *) jsonVerifyElement:(id) inParam;

/*
 * 提供商家模型的json解析
 */
+(ProviderElement *) jsonProviderElement:(id) inParam ;

/*
 * 应单对象
 */
+(AcceptOrderElement *) jsonAcceptOrderElement:(id) inParam ;

/*
 * 系统参数模型类
 */
+(ParamElement *) jsonParamElement:(id) inParam ;

/*
 * 用户订单数据解析
 */
+(NSMutableArray *) jsonUserOrderElement:(id) inParam;

/*
 * 用户订单详情数据解析
 */
+(NSMutableArray *) jsonUserOrderDetailElement:(id) inParam;

/*
 * 用户信息解析
 */
+(NSMutableArray *)jsonMessageWithData:(id) inParam;

/**
 *  已评价订单，评价信息解析
 *
 *  @since 1.0.0
 */
+(EvaluateElement*)jsonEvaluateWithData:(NSDictionary*) infoDic;

@end
