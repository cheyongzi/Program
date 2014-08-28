//
//  OrderDetailsHeadView.h
//  Booking
//
//  Created by jinchenxin on 14-7-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequireElement.h"

@interface OrderDetailsHeadView : UIView
{
    NSArray *paramArray;
}

@property (strong ,nonatomic) IBOutlet UIImageView *picImg ;
@property (strong ,nonatomic) IBOutlet UILabel *dateLa ;
@property (strong ,nonatomic) IBOutlet UILabel *countsLa ;
@property (strong ,nonatomic) IBOutlet UILabel *timesLa ;
@property (strong ,nonatomic) IBOutlet UILabel *intervalLa ;
@property (strong ,nonatomic) IBOutlet UILabel *priceLa ;
@property (strong ,nonatomic) IBOutlet UILabel *hoursLa ;
@property (strong ,nonatomic) IBOutlet UILabel *minuneLa ;
@property (strong ,nonatomic) IBOutlet UILabel *shopCountsLa ;
@property (strong ,nonatomic) IBOutlet UIButton *drinkBtn ;
@property (strong ,nonatomic) IBOutlet UIImageView *drinkBgImg ;
@property (strong ,nonatomic) IBOutlet UIView *reduceTimeView ;
@property (strong ,nonatomic) IBOutlet UIButton *comHisBtn ;
@property (strong, nonatomic) IBOutlet UIImageView *tagImg;

/*
 * 设置头部数据的方法
 */
-(void) setHeadCellData:(RequireElement *) element ;

@end
