//
//  AddDrinkResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AddDrinkResponse.h"

/*
 * 酒水添加响应类
 */
@implementation AddDrinkResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    [self setHeadData:inParam];
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
        NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
        if(bodyDic !=nil && [bodyDic isKindOfClass:[NSDictionary class]]){
            self.winAry = [[NSMutableArray alloc] init];
            NSArray *goodsAry = [bodyDic objectForKey:@"goods"];
            for (NSDictionary *goods in goodsAry) {
                WineElement *wineElement = [JsonUtils jsonWineElement:goods];
                [self.winAry addObject:wineElement];
            }
        }
    }
}

@end
