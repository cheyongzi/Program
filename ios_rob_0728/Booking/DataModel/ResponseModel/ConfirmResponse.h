//
//  ConfirmResponse.h
//  Booking
//
//  Created by jinchenxin on 14-7-7.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseResponse.h"

/*
 * 确认接单响应类
 */
@interface ConfirmResponse : BaseResponse

@property (strong ,nonatomic) NSString *orderNum ;

@end
