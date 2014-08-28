//
//  OrderSubmitCell.h
//  Booking
//
//  Created by jinchenxin on 14-7-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcceptOrderElement.h"
/*
 * 待确认UITableViewCell
 */
@interface OrderSubmitCell : UITableViewCell

@property (strong ,nonatomic) IBOutlet UIImageView *picImg ;
@property (strong ,nonatomic) IBOutlet UILabel *nameLa ;
@property (strong ,nonatomic) IBOutlet UILabel *shopTypeLa ;
@property (strong ,nonatomic) IBOutlet UILabel *hoursLa ;
@property (strong ,nonatomic) IBOutlet UILabel *minuteLa ;
@property (strong ,nonatomic) IBOutlet UIButton *drinkBtn ;
@property (strong ,nonatomic) IBOutlet UILabel *distanceLa ;
@property (strong ,nonatomic) IBOutlet UIButton *submitBtn ;
@property (strong ,nonatomic) IBOutlet UIImageView *arrowImg ;
@property (strong ,nonatomic) IBOutlet UIImageView *zhongbiaoImg ;
@property (strong ,nonatomic) IBOutlet UILabel *verityCodeLa ;
@property (strong ,nonatomic) IBOutlet UILabel *verityLa ;
@property (strong ,nonatomic) IBOutlet UIView *reduceTimeView ;
@property (strong ,nonatomic) IBOutlet UIButton *comHisBtn ;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;

@property (assign, nonatomic) BOOL      isCostCell;

/*
 * 设置Cell数据内容
 */
-(void) setSubmitCellData:(id) obj ;

@end
