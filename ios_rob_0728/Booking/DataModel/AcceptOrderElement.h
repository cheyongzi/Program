//
//  AcceptOrderElement.h
//  Booking
//
//  Created by jinchenxin on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 商家应单对象
 */
@interface AcceptOrderElement : NSObject

@property (strong ,nonatomic) NSString *acceptTime ;
@property (strong ,nonatomic) NSString *shopName ;
@property (strong ,nonatomic) NSString *latitude ;
@property (strong ,nonatomic) NSString *longitude ;
@property (strong ,nonatomic) NSString *endTime ;
@property (strong ,nonatomic) NSString *partyId ;
@property (strong ,nonatomic) NSString *shopsId ;
@property (strong ,nonatomic) NSString *status ;
@property (strong ,nonatomic) NSString *totalPrice ;
@property (strong ,nonatomic) NSString *volumeId ;
@property (strong ,nonatomic) NSString *payPrice ;
@property (strong ,nonatomic) NSString *logo ;
@property (strong ,nonatomic) NSMutableArray *winAry ;
@property (strong ,nonatomic) NSMutableArray *sendAry ;
@property (strong ,nonatomic) NSString *typeId;
@property (strong ,nonatomic) NSString *phoneNumber;
@property (strong ,nonatomic) NSString *mobileNumber;
@property (strong ,nonatomic) NSString *roomName;

@end
