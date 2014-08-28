//
//  HttpBaseRequest.m
//  Booking
//
//  Created by jinchenxin on 14-4-14.
//  Copyright (c) 2014年 jinchenxin. All rights reserved.
//

#import "HttpBaseRequest.h"
#import "HttpRequestCommDelegate.h"

static HttpBaseRequest *baseRequest ;

@implementation HttpBaseRequest {
    NSString * result ;
    NSMutableArray * resultArray;
    NSInteger *httpTag ;
}

@synthesize delegate;

//网络请求单例方法
+(HttpBaseRequest *) sharedInstance {
    if(baseRequest == nil){
        baseRequest = [[HttpBaseRequest alloc]init];
    }
    return baseRequest ;
}

//初始化方法
-(HttpBaseRequest *)initWithDelegate:(id) own {
    HttpBaseRequest *request = [[HttpBaseRequest alloc]init];
    request.delegate = own ;
    return request ;
}

//网络请求实现方法
-(void)initRequestComm:(NSMutableDictionary *) params withURL:(NSString *) subUrl operationTag:(NSInteger ) tag {
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:BASEURLPATH]];
    [client postPath:subUrl parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        self.reTag = tag ;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self.delegate httpRequestSuccessComm:tag withInParams:dic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
    }];
}

-(void)initUploadFileRequest:(NSDictionary *)params withFilePath:(NSString *)imgPath operationTag:(NSInteger)tag
{
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:FILESERVER]];
    NSMutableURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:UPLOAD_FILE parameters:params constructingBodyWithBlock:^(id formData){
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:imgPath] name:@"data" error:nil];
    }];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObj)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
         [self.delegate httpRequestSuccessComm:tag withInParams:dic];
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate httpRequestFailueComm:self.reTag withInParams:[error description]];
     }];
    [operation start];
}

//支付接口请求方法
-(void) initPayRequest:(NSDictionary *) params withURL:(NSString *) url operationTag:(NSInteger ) tag {
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:PAYBASEURLPATH]];
    [client postPath:url parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        self.reTag = tag ;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [self.delegate httpRequestSuccessComm:tag withInParams:dic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate httpRequestFailueComm:tag withInParams:[error description]];
    }];
}

@end
