//
//  ProviderResponse.m
//  Booking
//
//  Created by jinchenxin on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ProviderResponse.h"

@implementation ProviderResponse

-(void) setResultData:(id)inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if(paramDic != nil && [paramDic isKindOfClass:[NSDictionary class]]){
        [self setHeadData:inParam];
        NSDictionary *bodyDic = [paramDic objectForKey:@"body"];
        if(bodyDic !=nil && [bodyDic isKindOfClass:[NSDictionary class]]){
            NSArray *shopsAry = [bodyDic objectForKey:@"shops"];
            self.providerAry = [[NSMutableArray alloc] init];
            for (NSDictionary *shopDic in shopsAry) {
                ProviderElement *providerElement = [JsonUtils jsonProviderElement:shopDic];
                [self.providerAry addObject:providerElement];
            }
        }
    }
}

@end
