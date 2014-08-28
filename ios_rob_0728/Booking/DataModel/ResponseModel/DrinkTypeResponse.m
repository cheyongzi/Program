//
//  DrinkTypeResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-25.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "DrinkTypeResponse.h"

@implementation DrinkTypeResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
        NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
        if(bodyDic !=nil && [bodyDic isKindOfClass:[NSDictionary class]]){
            self.driTypeAry = [[NSMutableArray alloc] init];
            NSArray *typeAry = [bodyDic objectForKey:@"goodsType"];
            for (NSDictionary *typeDic in typeAry) {
                [self.driTypeAry addObject:typeDic];
            }
        }
    }
}

@end
