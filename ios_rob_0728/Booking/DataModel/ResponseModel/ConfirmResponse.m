
//
//  ConfirmResponse.m
//  Booking
//
//  Created by jinchenxin on 14-7-7.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ConfirmResponse.h"

/*
 * 确认接单响应类
 */
@implementation ConfirmResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
        NSDictionary *body = [paramDic objectForKey:@"body"];
        self.orderNum = [NSString stringWithFormat:@"%@",[body objectForKey:@"orderNum"]];
    }
}

@end
