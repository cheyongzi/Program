//
//  DetailsHeadView.h
//  Booking
//
//  Created by jinchenxin on 14-6-18.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequireElement.h"

@interface DetailsHeadView : UIView

@property (strong ,nonatomic) IBOutlet UIImageView *picImg  ;
@property (strong ,nonatomic) IBOutlet UILabel *nameLa ;
@property (strong ,nonatomic) IBOutlet UILabel *sendTimeLa ;
@property (strong ,nonatomic) IBOutlet UILabel *priceLa ;
@property (strong ,nonatomic) IBOutlet UILabel *sTimeLa ;
@property (strong ,nonatomic) IBOutlet UILabel *addressLa ;
@property (strong ,nonatomic) IBOutlet UILabel *typeLa ;
@property (strong ,nonatomic) IBOutlet UILabel *drinksLa ;
@property (strong ,nonatomic) IBOutlet UILabel *endTimeLa ;
@property (strong ,nonatomic) IBOutlet UIButton *goodfaithBtn ;
@property (strong ,nonatomic) IBOutlet UILabel *descripLa ;
@property (strong ,nonatomic) IBOutlet UILabel *countLa ;
@property (strong ,nonatomic) IBOutlet UIButton *drinkBtn ;
@property (strong ,nonatomic) IBOutlet UIImageView *poiImg ;
@property (strong ,nonatomic) IBOutlet UIView *contentView ;
@property (strong ,nonatomic) IBOutlet UIView *bottomView ;

-(void) setDetailsHeadData:(RequireElement *) requireElement ;

@end
