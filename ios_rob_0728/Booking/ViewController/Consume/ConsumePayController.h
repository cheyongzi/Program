//
//  ConsumePayController.h
//  Booking
//
//  Created by jinchenxin on 14-6-17.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "UPPayPlugin.h"
#import "UPPayPluginDelegate.h"

@interface ConsumePayController : BaseViewController<UPPayPluginDelegate,UIAlertViewDelegate>

@property (strong ,nonatomic) IBOutlet UIImageView *bgImg ;
@property (strong ,nonatomic) IBOutlet UIButton *ylBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *zfbBtn ;
@property (strong, nonatomic) IBOutlet UIButton *wxBtn;
@property (strong ,nonatomic) IBOutlet UILabel *priceLa ;
@property (strong ,nonatomic) NSString *price ;
@property (strong ,nonatomic) NSString *orderId ;
@property (strong ,nonatomic) NSString *shopName;
@property (strong ,nonatomic) NSString *roomType;
@property (nonatomic) NSInteger payPosition ;

/*
 * 支付方式事件
 */
-(IBAction)payClickEvent:(id)sender ;

@end
