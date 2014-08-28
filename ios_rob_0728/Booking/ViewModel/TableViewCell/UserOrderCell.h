//
//  UserOrderCell.h
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserOrderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *backImg;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderCashLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addrLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *consumeTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderState;
@property (strong, nonatomic) IBOutlet UILabel *consumeCodeLabel;
@property (strong, nonatomic) IBOutlet UIButton *orderDetail;

@end
