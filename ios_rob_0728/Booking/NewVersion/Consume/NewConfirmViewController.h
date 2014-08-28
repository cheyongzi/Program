//
//  NewConfirmViewController.h
//  Booking
//
//  Created by 1 on 14-8-11.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NewConfirmViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) UIImageView *confirmBackImg;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *peopleCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *consumeTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeIntervalLabel;
@property (strong, nonatomic) IBOutlet UIView *confirmView;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *wineLabel;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSArray               *wineArray;
@property (assign, nonatomic) int                   shopCount;
@property (strong, nonatomic) NSString              *consumeTime;

- (id)initWithInfo:(NSMutableDictionary *)infoDic;
@end
