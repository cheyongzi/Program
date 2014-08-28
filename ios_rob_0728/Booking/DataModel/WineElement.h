//
//  WineElement.h
//  Booking
//
//  Created by jinchenxin on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 酒水数据模型
 */
@interface WineElement : NSObject

@property (strong ,nonatomic) NSString *goodsId ; //商品ID
@property (strong ,nonatomic) NSString *goodsImg ;//商品图片
@property (strong ,nonatomic) NSString *goodsName ;//商品名称
@property (strong ,nonatomic) NSString *goodsNumber ;//商品数量
@property (strong ,nonatomic) NSString *goodsPrice ;//商品单价
@property (strong ,nonatomic) NSString *unit ;//商家单位

@end
