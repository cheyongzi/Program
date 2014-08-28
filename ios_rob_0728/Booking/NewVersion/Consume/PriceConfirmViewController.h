//
//  PriceConfirmViewController.h
//  Booking
//
//  Created by 1 on 13-7-21.
//  Copyright (c) 2013年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomHorizontalScrollView.h"

@interface PriceConfirmViewController : BaseViewController<CustomHorizontalScrollDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *myVScrollView;
@property (strong, nonatomic) IBOutlet UIView *shopView;
@property (strong, nonatomic) IBOutlet UILabel *shopLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIView *winView;
@property (strong, nonatomic) IBOutlet UILabel *wineLabel;
@property (strong, nonatomic) IBOutlet UIView *endTimeView;
@property (strong, nonatomic) IBOutlet UIView *confirmView;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) IBOutlet CustomHorizontalScrollView *customScrollViewSecond;
@property (strong, nonatomic) IBOutlet CustomHorizontalScrollView *customScrollViewOne;
@property (strong, nonatomic) IBOutlet UILabel *headerLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *headerLabelSecond;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabelSecond;
@property (strong, nonatomic) IBOutlet UIImageView *shopTypeImage;

@property (strong, nonatomic) NSMutableArray *wineArray;
@property (strong, nonatomic) NSMutableArray *shopArray;
@property (assign, nonatomic) int             basePrice;
@property (assign, nonatomic) float           scale;
@property (strong, nonatomic) NSString       *consumeTime;
@property (assign, nonatomic) int              shopType;

- (id)initWithInfo:(NSMutableDictionary *)infoDic;

@end
