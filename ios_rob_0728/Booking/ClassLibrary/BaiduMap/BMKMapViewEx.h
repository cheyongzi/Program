//
//  BMKMapViewEx.h
//  Park
//
//  Created by xw on 13-5-27.
//  Copyright (c) 2013年 Wang Dean. All rights reserved.
//

#import "BMKMapView.h"
#import "KTVPointAnnotation.h"

@protocol CustomBubbleProtocol

- (UIView*)customBubbleForAnnotation:(KTVPointAnnotation*)annotation;

@end

@interface BMKMapViewEx : BMKMapView<BMKMapViewDelegate>

@property (nonatomic, assign) id<BMKMapViewDelegate> mapDelegate;
@property (nonatomic, assign) id<CustomBubbleProtocol> bubbleDelegate;


@end
