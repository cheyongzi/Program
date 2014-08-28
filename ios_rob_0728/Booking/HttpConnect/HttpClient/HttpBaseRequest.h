//
//  HttpBaseRequest.h
//  Booking
//
//  Created by jinchenxin on 14-4-14.
//  Copyright (c) 2014年 jinchenxin. All rights reserved.
//  网络请求单例类

#import <Foundation/Foundation.h>
#import "HttpRequestCommDelegate.h"
#import "AFHTTPClient.h"
#import "HttpRequestField.h"
#import "AFHTTPRequestOperation.h"

//@interface MyOperation : AFHTTPRequestOperation
//    @property (nonatomic) NSInteger tag;
//@end

@interface HttpBaseRequest : NSObject<NSXMLParserDelegate>{
    //id<HttpRequestCommDelegate> delegate ;
}

@property (weak ,nonatomic) id<HttpRequestCommDelegate> delegate;

@property (nonatomic) NSInteger reTag ;


//网络请求单例方法
+(HttpBaseRequest *) sharedInstance ;

//初始化方法
-(HttpBaseRequest *)initWithDelegate:(id) own ;

//网络请求实现方法
-(void)initRequestComm:(NSMutableDictionary *) params withURL:(NSString *) subUrl operationTag:(NSInteger ) tag ;

//微歌上传文件接口请求方法
-(void)initUploadFileRequest:(NSDictionary *)params withFilePath:(NSString *)imgPath operationTag:(NSInteger)tag;

//支付接口请求方法
-(void) initPayRequest:(NSDictionary *) params withURL:(NSString *) url operationTag:(NSInteger ) tag ;

@end
