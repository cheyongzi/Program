//
//  OrderCommentView.m
//  Booking
//
//  Created by jinchenxin on 14-7-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "OrderCommentView.h"
#import "ConUtils.h"
#import "SharedUserDefault.h"
#import "BaseViewController.h"
#import "UIImageView+WebCache.h"

@implementation OrderCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib {
    self.comBgImg.image = [ConUtils getImageScale:@"com_con_bg"];
    self.conBgImg.image = [ConUtils getImageScale:@"com_con_bg"];
    self.conTv.returnKeyType = UIReturnKeyDone ;
    self.conTv.delegate = self ;
    
    self.enStarRating = [[TQStarRatingView alloc] initWithFrame:CGRectMake(80, 144, 100, 20) numberOfStar:5];
    self.enStarRating.tag = 50 ;
    [self.enStarRating changeStarForegroundViewWithPoint:CGPointMake(80, self.enStarRating.frame.origin.y)];
    self.enStarRating.delegate = self;
    [self addSubview:self.enStarRating];
    
    self.seStarRating = [[TQStarRatingView alloc] initWithFrame:CGRectMake(80, 172, 100, 20) numberOfStar:5];
    self.seStarRating.tag = 51 ;
    [self.seStarRating changeStarForegroundViewWithPoint:CGPointMake(80, self.seStarRating.frame.origin.y)];
    self.seStarRating.delegate = self;
    [self addSubview:self.seStarRating];
    
    self.setRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(80, 202, 100, 20) numberOfStar:5];
    self.setRatingView.tag = 52 ;
    [self.setRatingView changeStarForegroundViewWithPoint:CGPointMake(80, self.setRatingView.frame.origin.y)];
    self.setRatingView.delegate = self;
    [self addSubview:self.setRatingView];
    
    
}

/*
 * 设置头部数据的方法
 */
-(void) setHeadCellData:(RequireElement *) element {
    self.drinkBgImg.image = [ConUtils getImageScale:@"com_con_bg"];
    [ConUtils checkFileWithURLString:element.logoUrl withImageView:self.picImg withDirector:@"Shop" withDefaultImage:@"defaultImg.png"];
    self.picImg.layer.cornerRadius = 3 ;
    self.picImg.clipsToBounds = YES ;
    self.dateLa.text = [ConUtils getDDMMTime:element.consumDate];
    NSString *countName = [[SharedUserDefault sharedInstance] getSystemNameType:@"Volume" andTypeKey:element.personId];
    self.countsLa.text = countName;
    
    NSString *consumeInterval = element.consumInterval ;
    NSString *time = @"";
    NSString *endTime = @"";
    if([consumeInterval isEqualToString:@"0"]){
        time = @"下午场";
        endTime = @"12:00-18:00";
    }else if([consumeInterval isEqualToString:@"1"]){
        time = @"正晚场";
        endTime = @"18:00-00:00";
    }else if([consumeInterval isEqualToString:@"2"]){
        time = @"晚晚场";
        endTime = @"00:00-06:00";
    }else if ([consumeInterval isEqualToString:@"3"])
    {
        time = @"自定义";
        endTime = [ConUtils getHHmmAddTime:element.arriveTime AndTimeLong:element.hours];
    }
    
    self.timesLa.text = time;
    self.intervalLa.text = endTime;
    self.priceLa.text = [NSString stringWithFormat:@"￥%@",element.offerPrice];
    self.shopCountsLa.text = element.count;
    
    NSMutableArray *winAry = element.winAry ;
    if(winAry != nil && [winAry count]>0) {
        NSString *drinkPrice = [ConUtils getAddDrinkTotalPrice:winAry];
        [self.drinkBtn setTitle:[NSString stringWithFormat:@"酒水总价：%@ 元",drinkPrice] forState:UIControlStateNormal];
    }
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score {
    NSInteger tagValue = view.tag ;
    switch (tagValue) {
        case 50:
            self.enLa.text = [NSString stringWithFormat:@"%.1f",10*score];
            break;
        case 51:
            self.seLa.text = [NSString stringWithFormat:@"%.1f",10*score];
            break;
        case 52:
            self.setLa.text = [NSString stringWithFormat:@"%.1f",10*score];
            break;
    }
}

/*
 *获取评论信息的方法
 */
-(NSMutableArray *) getCommentInfo {
    NSMutableArray *comAry = [[NSMutableArray alloc] init];
    [comAry addObject:self.enLa.text];
    [comAry addObject:self.seLa.text];
    [comAry addObject:self.setLa.text];
    [comAry addObject:self.conTv.text];
    return comAry ;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
