//
//  LoadingView.h
//  Booking
//
//  Created by jinchenxin on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConUtils.h"
#import "BaseViewController.h"

@interface LoadingView : UIView

-(id) initType:(NSInteger) type ;

@property (strong ,nonatomic) UIView *sbgView ;
@property (strong ,nonatomic) UILabel *desLa ;
@property (nonatomic) NSInteger pointCounts ;

@end
