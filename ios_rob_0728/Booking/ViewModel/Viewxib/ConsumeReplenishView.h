//
//  ConsumeReplenishView.h
//  Booking
//
//  Created by jinchenxin on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsumeReplenishView : UIView

@property (strong ,nonatomic) IBOutlet UITextField *priceTf ;
@property (strong ,nonatomic) IBOutlet UITextField *telphoneTf ;
@property (strong ,nonatomic) IBOutlet UITextField *nameTf ;
@property (strong ,nonatomic) IBOutlet UITextView *replenishTv ;
@property (strong ,nonatomic) IBOutlet UIImageView *fBgImage ;
@property (strong ,nonatomic) IBOutlet UIImageView *sBgImage ;

-(void) setBackgroundImage ;

@end
