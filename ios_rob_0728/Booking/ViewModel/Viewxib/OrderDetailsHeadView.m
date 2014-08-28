//
//  OrderDetailsHeadView.m
//  Booking
//
//  Created by jinchenxin on 14-7-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "OrderDetailsHeadView.h"
#import "ConUtils.h"
#import "BaseViewController.h"
#import "UIImageView+WebCache.h"
#import "SharedUserDefault.h"

@implementation OrderDetailsHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 * 设置头部数据的方法
 */
-(void) setHeadCellData:(RequireElement *) element {
    self.drinkBgImg.image = [ConUtils getImageScale:@"com_con_bg"];
    if ([[SharedUserDefault sharedInstance] getSystemParam]!=nil)
    {
        paramArray = [[SharedUserDefault sharedInstance] getSystemType:@"ShopType"];
    }
    
    if (paramArray!=nil&&[paramArray count]!=0)
    {
        for (ParamElement *param in paramArray)
        {
            if (element.shopType!=nil&&[element.shopType isEqualToString:param.paramterId])
            {
                if ([param.paramName isEqualToString:@"KTV"])
                {
                    self.picImg.image = [UIImage imageNamed:@"m_img_ktv"];
                }
                else if ([param.paramName isEqualToString:@"JB"])
                {
                    self.picImg.image = [UIImage imageNamed:@"m_img_bar"];
                }
                else if ([param.paramName isEqualToString:@"YC"])
                {
                    self.picImg.image = [UIImage imageNamed:@"m_img_night"];
                }
                break;
            }
        }
    }
    self.picImg.layer.cornerRadius = 3 ;
    self.picImg.clipsToBounds = YES ;
    self.dateLa.text = [ConUtils getDDMMTime:element.consumDate];
    NSString *countName = [[SharedUserDefault sharedInstance] getSystemNameType:@"Volume" andTypeKey:element.personId];
    self.countsLa.text = countName;
    
    NSString *consumeInterval = element.consumInterval ;
    NSString *time = @"";
    NSString *intervalTime =@"";
    NSString *arrivateTime = element.arriveTime ;
    
    NSString *reduceTime = @"";
    if([consumeInterval isEqualToString:@"0"]){
        time = @"下午场";
        intervalTime = @"12:00-18:00";
        reduceTime = @"12:00";
    }else if([consumeInterval isEqualToString:@"1"]){
        time = @"正晚场";
        intervalTime = @"18:00-00:00";
        reduceTime = @"18:00";
    }else if([consumeInterval isEqualToString:@"2"]){
        time = @"晚晚场";
        intervalTime = @"00:00-06:00";
        reduceTime = @"23:59";
    }else if([consumeInterval isEqualToString:@"3"])
    {
        if (arrivateTime != nil && ![arrivateTime isEqualToString:@""]) {
            time = @"自定义";
            intervalTime = [ConUtils getHHmmAddTime:element.arriveTime AndTimeLong:element.hours];
            reduceTime = element.arriveTime;
        }
    }
    
    //抢单倒计时的计算
    reduceTime = [NSString stringWithFormat:@"%@ %@",element.consumDate,reduceTime];
    //reduceTime = element.endTime;
    if(element.endTime != nil && ![element.endTime isEqualToString:@""])
    {
        reduceTime = element.endTime ;
    }
    reduceTime = [ConUtils getReduceTime:reduceTime];
    
    
    self.timesLa.text = time;
    self.intervalLa.text = intervalTime;
    self.priceLa.text = [NSString stringWithFormat:@"￥%@",element.offerPrice];
    
    //剩余时间的计算方法
    NSArray *reAry = [reduceTime componentsSeparatedByString:@","];
    if([reAry count]>1){
        self.hoursLa.text = [reAry objectAtIndex:0];
        self.minuneLa.text = [reAry objectAtIndex:1];
    }else{
        [self.reduceTimeView removeFromSuperview];
        self.comHisBtn.hidden = NO ;
        [self.comHisBtn setTitle:@" 已过期" forState:UIControlStateNormal];
        [self.comHisBtn setImage:[UIImage imageNamed:@"h_order_his"] forState:UIControlStateNormal];
    }
    self.shopCountsLa.text = element.count;
    
    NSMutableArray *winAry = element.winAry ;
    if(winAry != nil && [winAry count]>0) {
        NSString *drinkPrice = [ConUtils getAddDrinkTotalPrice:winAry];
        [self.drinkBtn setTitle:[NSString stringWithFormat:@"我需要的酒水小吃(%@元)",drinkPrice] forState:UIControlStateNormal];
    }
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
