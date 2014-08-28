//
//  PriceMySelfViewController.h
//  RobClientSecond
//
//  Created by 1 on 13-7-19.
//  Copyright (c) 2013年 cheyongzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomHorizontalScrollView.h"
#import "SelectUnitView.h"
#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PriceMySelfViewController : BaseViewController<CustomHorizontalScrollDelegate,SelectUnitDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *ktvSelectView;
@property (strong, nonatomic) IBOutlet UIImageView *shopTypeImageView;
@property (strong, nonatomic) IBOutlet UILabel *shopLabel;
@property (strong, nonatomic) IBOutlet UIView *wineAddView;
@property (strong, nonatomic) IBOutlet UILabel *winLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *myVerticalScroll;
@property (strong, nonatomic) IBOutlet CustomHorizontalScrollView *customScrollViewOne;
@property (strong, nonatomic) IBOutlet CustomHorizontalScrollView *customScrollViewSecond;
@property (strong, nonatomic) IBOutlet UIView *publishView;
@property (strong, nonatomic) IBOutlet UIButton *publishButton;
@property (strong, nonatomic) IBOutlet UIView *consumePriceView;
@property (strong, nonatomic) IBOutlet UIView *endTimeView;
@property (strong, nonatomic) IBOutlet UIView *personInfoView;
@property (strong, nonatomic) IBOutlet UIView *messageView;
@property (strong, nonatomic) IBOutlet UIImageView *consumePriceBackImg;
@property (strong, nonatomic) IBOutlet UIImageView *consumePriceSelImg;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel1;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel2;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel3;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel4;
@property (strong, nonatomic) IBOutlet UITextField *mobileTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UILabel *timeSelLabel;
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) IBOutlet UILabel *daySelLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateSelLabel;
@property (strong, nonatomic) IBOutlet UIImageView *consumeIconImg;
@property (strong, nonatomic) IBOutlet UITextField *consumePriceTextField;
@property (strong, nonatomic) IBOutlet UIView *priceStyleOne;
@property (strong, nonatomic) IBOutlet UILabel *headerLabelSecond;
@property (strong, nonatomic) IBOutlet UILabel *headerLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *winePriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopLabel1;
@property (strong, nonatomic) IBOutlet UILabel *shopLabel2;
@property (strong, nonatomic) IBOutlet UILabel *shopLabel3;
@property (strong, nonatomic) IBOutlet UIButton *priceStyleChangeBtn;

@property (strong, nonatomic) NSMutableArray  *shopArray;
@property (assign, nonatomic) int              shopType;
@property (assign, nonatomic) CLLocationCoordinate2D   locationCoordinate;

@property (assign, nonatomic) BOOL             isTextViewEdit;

@end
