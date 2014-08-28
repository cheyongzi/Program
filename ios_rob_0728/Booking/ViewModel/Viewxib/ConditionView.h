//
//  ConditionView.h
//  Booking
//
//  Created by jinchenxin on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol dismissViewDelegate <NSObject>

-(void) conditionViewDismiss ;

@end

@interface ConditionView : UIView
@property (strong ,nonatomic) id<dismissViewDelegate> delegate ;
@property (strong ,nonatomic) IBOutlet UIView *conView ;
@property (strong ,nonatomic) IBOutlet UIImageView *picImg ;
@property (strong ,nonatomic) IBOutlet UIImageView *timeImg ;
@property (strong ,nonatomic) IBOutlet UIImageView *countImg ;
@property (strong ,nonatomic) IBOutlet UIImageView *moneyImg ;
@property (strong ,nonatomic) IBOutlet UIScrollView *timeScrollView ;
@property (strong ,nonatomic) IBOutlet UIScrollView *countScrollView ;
@property (strong ,nonatomic) UIView *countTagView ;
@property (strong ,nonatomic) UIView *timeTagView ;
@property (strong ,nonatomic) UIView *moneyTagView ;
@property (strong ,nonatomic) IBOutlet UIScrollView *moneyScrollView ;
@property (strong ,nonatomic) UIButton *curCountBtn ;
@property (strong ,nonatomic) UIButton *curTimeBtn ;
@property (strong ,nonatomic) UIButton *curMoneyBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *submitBtn ;


-(void) initConditionView  ;

-(void) dismissConditionView ;

-(IBAction) submitClickEvent:(id) sender ;
    
@end
