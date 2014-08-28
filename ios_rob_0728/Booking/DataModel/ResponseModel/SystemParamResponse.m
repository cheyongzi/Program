//
//  SystemParamResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "SystemParamResponse.h"

/*
 * 系统参数响应类
 */
@implementation SystemParamResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
        NSDictionary *resultDic = [paramDic objectForKey:@"result"];
        self.code = [[resultDic objectForKey:@"code"] integerValue];
        self.message = [resultDic objectForKey:@"message"];
        NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
        if(bodyDic !=nil && [bodyDic isKindOfClass:[NSDictionary class]]){
            NSArray *paramAry = [bodyDic objectForKey:@"sysParam"];
            self.sysParamDic = [[NSMutableDictionary alloc] init];
            for (NSDictionary *paramDic in paramAry) {
                
                NSString *keyCode = [[paramDic allKeys] objectAtIndex:0];
                NSArray *params = [paramDic objectForKey:keyCode];
                NSMutableArray *paramElements = [[NSMutableArray alloc] init];
                ParamElement *element = [[ParamElement alloc] init];
                element.paramCode = keyCode;
                element.paramName = @"不限";
                element.paramterId = @"" ;
//                [paramElements addObject:element];
                for (NSDictionary *paramsDic in params) {
                    ParamElement *element = [JsonUtils jsonParamElement:paramsDic];
                    if(element != nil){
                      element.paramCode = keyCode ;
                        [paramElements addObject:element];
                    }
                }
                [self.sysParamDic setObject:paramElements forKey:keyCode];
            }
        }
    }
}

@end
