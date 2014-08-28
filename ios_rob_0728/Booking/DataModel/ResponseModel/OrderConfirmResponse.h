//
//  OrderConfirmResponse.h
//  Booking
//
//  Created by jinchenxin on 14-7-7.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseResponse.h"

/*
 * 订单确认的响应类
 */
@interface OrderConfirmResponse : BaseResponse

@property (strong ,nonatomic) NSString *payInfo ;

@end
