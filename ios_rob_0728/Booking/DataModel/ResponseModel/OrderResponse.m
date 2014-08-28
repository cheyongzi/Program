//
//  OrderResponse.m
//  Booking
//
//  Created by 1 on 14-6-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "OrderResponse.h"

@implementation OrderResponse

- (void)setResultData:(id)inParam
{
    if (inParam != nil)
    {
        [self setHeadData:inParam];
        NSDictionary *bodyDic = [inParam objectForKey:@"body"];
        if (bodyDic != nil)
        {
            NSArray *orderArr = [bodyDic objectForKey:@"order"];
            if ([orderArr count] > 0&&orderArr!=nil)
            {
                self.mulArray = [JsonUtils jsonUserOrderElement:orderArr];
            }
        }
    }
}

@end
