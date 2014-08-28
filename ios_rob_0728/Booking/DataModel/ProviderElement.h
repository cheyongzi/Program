//
//  ProviderElement.h
//  Booking
//
//  Created by jinchenxin on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 提供商家模型类
 */
@interface ProviderElement : NSObject

@property (strong ,nonatomic) NSString *shopId ;
@property (strong ,nonatomic) NSString *shopName ;
@property (strong ,nonatomic) NSString *shopAddress ;
@property (strong ,nonatomic) NSString *roomName ;
@property (strong ,nonatomic) NSString *volume ;
@property (strong ,nonatomic) NSString *longitude ;
@property (strong ,nonatomic) NSString *latitude ;
@property (strong ,nonatomic) NSString *endDate ;
@property (strong ,nonatomic) NSString *shopImgUrl ;
@property (strong ,nonatomic) NSString *selectState ;

@end
