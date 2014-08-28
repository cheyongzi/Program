//
//  BaseResponse.h
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonUtils.h"

/*
 * 数据响应基类
 */
@interface BaseResponse : NSObject

@property (nonatomic) NSInteger index ;
@property (nonatomic) NSInteger pageSize ;
@property (nonatomic) NSInteger code ;
@property (nonatomic) NSInteger totalPage ;
@property (nonatomic) NSInteger totalRecord ;
@property (strong ,nonatomic) NSString *message ;

-(void) setResultData:(id) inParam ;

-(void) setHeadData:(id) inParam ;

@end
