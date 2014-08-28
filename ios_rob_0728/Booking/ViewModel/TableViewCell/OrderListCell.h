//
//  OrderListCell.h
//  Booking
//
//  Created by jinchenxin on 14-7-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequireElement.h"

@interface OrderListCell : UITableViewCell
{
    NSArray *paramArray;
}

@property (strong ,nonatomic) IBOutlet UIImageView *bgImg ;
@property (strong ,nonatomic) IBOutlet UIImageView *picImg ;
@property (strong ,nonatomic) IBOutlet UILabel *nameLa ;
@property (strong ,nonatomic) IBOutlet UILabel *dateLa ;
@property (strong ,nonatomic) IBOutlet UILabel *countScopeLa ;
@property (strong ,nonatomic) IBOutlet UILabel *timesLa;
@property (strong ,nonatomic) IBOutlet UILabel *intervalLa ;
@property (strong ,nonatomic) IBOutlet UILabel *priceLa ;
@property (strong ,nonatomic) IBOutlet UILabel *countsLa ;
@property (strong ,nonatomic) IBOutlet UILabel *hoursLa ;
@property (strong ,nonatomic) IBOutlet UILabel *minuteLa ;
@property (strong ,nonatomic) IBOutlet UILabel *verifyCodeLa ;
@property (strong ,nonatomic) IBOutlet UILabel *verifyLa ;
@property (strong ,nonatomic) IBOutlet UIView *reduceTimeView ;
@property (strong ,nonatomic) IBOutlet UIButton *comHisBtn ;
@property (strong ,nonatomic) IBOutlet UIImageView *tagImg ;
@property (strong ,nonatomic) IBOutlet UIImageView *nameImg ;

@property (assign ,nonatomic) BOOL      isCostCell;

/*
 * 设置Cell数据内容
 */
-(void) setOrderListData:(RequireElement *) element ;

@end
