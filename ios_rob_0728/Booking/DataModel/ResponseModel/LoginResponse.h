//
//  LoginResponse.h
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseResponse.h"
#import "UserElement.h"

@interface LoginResponse : BaseResponse

@property (strong,nonatomic) UserElement *userElement;

@end
