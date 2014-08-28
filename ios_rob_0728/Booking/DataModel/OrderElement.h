//
//  OrderElement.h
//  Booking
//
//  Created by 1 on 14-6-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderElement : NSObject

@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *amounts;
@property (strong,nonatomic) NSString *consumeDate;
@property (assign,nonatomic) NSInteger isCost;
@property (strong,nonatomic) NSString *orderId;
@property (strong,nonatomic) NSString *orderNum;
@property (strong,nonatomic) NSString *shopName;
@property (strong,nonatomic) NSString *submitTime;
@property (strong,nonatomic) NSString *userCostNum;
@property (strong,nonatomic) NSString *isEvaluate ;
@property (strong,nonatomic) NSString *typeId ;
@property (strong,nonatomic) NSString *count ;
@property (strong,nonatomic) NSString *consumInterval ;
@property (strong,nonatomic) NSString *volumeId ;
@property (strong,nonatomic) NSString *logo ;
@property (strong,nonatomic) NSString *robId ;
@property (strong,nonatomic) NSString *hours ;
@property (strong,nonatomic) NSString *arriveTime ;

@property (strong,nonatomic) NSMutableArray *mulArray;


@end
