//
//  BusinessAreResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BusinessAreResponse.h"

@implementation BusinessAreResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
        NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
        if(bodyDic !=nil && [bodyDic isKindOfClass:[NSDictionary class]]){
            self.areAry = [[NSMutableArray alloc] init];
            NSArray *businessAry = [bodyDic objectForKey:@"business"];
            for (NSDictionary *areDic in businessAry) {
                [self.areAry addObject:areDic];
            }
        }
    }
}

@end
