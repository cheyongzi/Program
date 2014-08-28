//
//  MessageResponse.m
//  Booking
//
//  Created by 1 on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "MessageResponse.h"

@implementation MessageResponse

- (void)setResultData:(id)inParam
{
    [self setHeadData:inParam];
    self.array = [JsonUtils jsonMessageWithData:[[inParam objectForKey:@"body"] objectForKey:@"news"]];
}

@end
