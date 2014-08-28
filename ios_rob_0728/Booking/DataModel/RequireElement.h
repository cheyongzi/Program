//
//  RequireElement.h
//  Booking
//
//  Created by jinchenxin on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserElement.h"

/*
 * 用户订单需求数据模型
 */
@interface RequireElement : NSObject

@property (strong ,nonatomic) NSString *requiredId ; //需求ID
@property (strong ,nonatomic) NSString *robId ;
@property (strong ,nonatomic) NSString *memberId ;//发布人Id
@property (strong ,nonatomic) NSString *shopType ;
@property (strong ,nonatomic) NSString *logoUrl ;
@property (strong ,nonatomic) NSString *personId ; //人数（1：2～3人 2：）
@property (strong ,nonatomic) NSString *providerType ; //商家类型
@property (strong ,nonatomic) NSString *meetType ; //聚会类型（1：朋友聚会 2：）
@property (strong ,nonatomic) NSString *robType ; //抢单类型（1：快捷抢单 2：精准抢单）
@property (strong ,nonatomic) NSString *count ; //抢单人数
@property (strong ,nonatomic) NSString *consumDate ; //消费日期
@property (strong ,nonatomic) NSString *arriveTime ; //到店时间
@property (strong ,nonatomic) NSString *hours ; //消费时长
@property (strong ,nonatomic) NSString *consumInterval ; //消费时段（1：下午场 2：正晚场 3：晚晚场）
@property (strong ,nonatomic) NSString *rejectDate ; //抢单结束时间
@property (strong ,nonatomic) NSString *publishDate ; //发布日期
@property (strong ,nonatomic) NSString *cityCode ; //城市ID
@property (strong ,nonatomic) NSString *latitude ; //纬度
@property (strong ,nonatomic) NSString *longitude ; //经度
@property (strong ,nonatomic) NSString *busCode ; //商圈ID
@property (strong ,nonatomic) NSString *radius ; //半径
@property (strong ,nonatomic) NSString *address ; //地址
@property (strong ,nonatomic) NSString *offerPrice ; //我出价
@property (strong ,nonatomic) NSString *contact ; //联系人
@property (strong ,nonatomic) NSString *mobile ; //手机号
@property (strong ,nonatomic) NSString *payment ; //预付金额
@property (strong ,nonatomic) NSString *sex ; //性别
@property (strong ,nonatomic) NSString *targeProvider ; //意向商家
@property (strong ,nonatomic) NSString *goods ; // 酒水
@property (strong ,nonatomic) NSString *brief ;
@property (strong ,nonatomic) NSString *verifyCode ;
@property (strong ,nonatomic) NSString *endTime ;

@property (strong ,nonatomic) UserElement *userElement ; //用户信息
@property (strong ,nonatomic) NSMutableArray *winAry ; //酒水列表


@end
