//
//  AddDrinkCell.h
//  Booking
//
//  Created by jinchenxin on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConUtils.h"
#import "BaseViewController.h"
#import "WineElement.h"

@interface AddDrinkCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goodImg;
@property (strong, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodPriceLabel;
@property (strong, nonatomic) IBOutlet UIButton *goodReduceBtn;
@property (strong, nonatomic) IBOutlet UILabel *goodCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *goodAddBtn;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImg;

@end
