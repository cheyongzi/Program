//
//  MyOrderDetailResponse.m
//  Booking
//
//  Created by 1 on 14-6-30.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "MyOrderDetailResponse.h"

@implementation MyOrderDetailResponse

- (void)setResultData:(id)inParam
{
    [self setHeadData:inParam];
    
    self.mulArr = [JsonUtils jsonUserOrderDetailElement:[[inParam objectForKey:@"body"] objectForKey:@"details"]];
}

@end
