//
//  OrderCommentView.h
//  Booking
//
//  Created by jinchenxin on 14-7-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequireElement.h"
#import "TQStarRatingView.h"
@interface OrderCommentView : UIView<StarRatingViewDelegate,UITextViewDelegate>

@property (strong ,nonatomic) IBOutlet UIImageView *picImg ;
@property (strong ,nonatomic) IBOutlet UILabel *dateLa ;
@property (strong ,nonatomic) IBOutlet UILabel *countsLa ;
@property (strong ,nonatomic) IBOutlet UILabel *timesLa ;
@property (strong ,nonatomic) IBOutlet UILabel *intervalLa ;
@property (strong ,nonatomic) IBOutlet UILabel *priceLa ;
@property (strong ,nonatomic) IBOutlet UILabel *hoursLa ;
@property (strong ,nonatomic) IBOutlet UILabel *minuneLa ;
@property (strong ,nonatomic) IBOutlet UILabel *shopCountsLa ;
@property (strong ,nonatomic) IBOutlet UIButton *drinkBtn ;
@property (strong ,nonatomic) IBOutlet UIImageView *drinkBgImg ;

@property (strong ,nonatomic) IBOutlet UIImageView *comBgImg ;
@property (strong ,nonatomic) IBOutlet UIImageView *conBgImg ;
@property (strong ,nonatomic) IBOutlet UITextView *conTv ;

@property (strong ,nonatomic) IBOutlet UILabel *enLa ;
@property (strong ,nonatomic) IBOutlet UILabel *seLa ;
@property (strong ,nonatomic) IBOutlet UILabel *setLa ;
@property (strong, nonatomic) IBOutlet UIView *commentView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *titleButton;

@property (strong ,nonatomic) TQStarRatingView *setRatingView;
@property (strong ,nonatomic) TQStarRatingView *enStarRating;
@property (strong ,nonatomic) TQStarRatingView *seStarRating;

/*
 * 设置头部数据的方法
 */
-(void) setHeadCellData:(RequireElement *) element ;

/*
 *获取评论信息的方法
 */
-(NSMutableArray *) getCommentInfo ;


@end
