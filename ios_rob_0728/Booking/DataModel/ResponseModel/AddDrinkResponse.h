//
//  AddDrinkResponse.h
//  Booking
//
//  Created by jinchenxin on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseResponse.h"
#import "WineElement.h"

/*
 * 酒水添加响应类
 */
@interface AddDrinkResponse : BaseResponse

@property (strong ,nonatomic) NSMutableArray *winAry ;

@end
