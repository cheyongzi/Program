//
//  KTVPointAnnotation.h
//  Booking
//
//  Created by jinchenxin on 14-6-11.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BMKPointAnnotation.h"

@interface KTVPointAnnotation : BMKPointAnnotation {
    NSUInteger _tag ;
}

@property NSUInteger tag ;
@property NSUInteger shopType ;


@end
