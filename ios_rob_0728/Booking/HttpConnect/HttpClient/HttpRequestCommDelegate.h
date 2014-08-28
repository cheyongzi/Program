//
//  HttpRequestProtocolComm.h
//  Booking
//
//  Created by jinchenxin on 14-4-14.
//  Copyright (c) 2014年 jinchenxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpRequestCommDelegate <NSObject>

//网络请求成功协议的方法
-(void)httpRequestSuccessComm:(int) tagId withInParams:(id) inParam;

//网络请求失败协议方法
-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *) error ;

@end
