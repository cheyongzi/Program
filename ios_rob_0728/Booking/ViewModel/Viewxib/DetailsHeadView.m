//
//  DetailsHeadView.m
//  Booking
//
//  Created by jinchenxin on 14-6-18.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "DetailsHeadView.h"
#import "WineElement.h"
#import "ConUtils.h"
#import "DrinkViewController.h"
#import "UIImageView+WebCache.h"

@implementation DetailsHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setDetailsHeadData:(RequireElement *) requireElement {
    
    self.nameLa.text = requireElement.contact;
    self.sendTimeLa.text = [ConUtils getSendTime:requireElement.publishDate];
    self.priceLa.text = [NSString stringWithFormat:@"%@元",requireElement.offerPrice];
    NSString *picUrl = [NSString stringWithFormat:@"%@/mobile%@",FILESERVER,requireElement.logoUrl];
    [self.picImg setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"defaultImg.png"]];
    self.picImg.layer.cornerRadius = 3 ;
    self.picImg.clipsToBounds = YES ;
    //抢单结束时间
    NSString *endTime = @"" ;
    NSString *arrivateTime = requireElement.arriveTime ;
    if(arrivateTime != nil && ![arrivateTime isEqualToString:@""]){
        self.sTimeLa.text = [NSString stringWithFormat:@"%@ %@ (%@小时)",requireElement.consumDate,requireElement.arriveTime,requireElement.hours] ;//requireElement.hours
        endTime = self.sTimeLa.text ;
    }else{
        NSString *consumeInterval = requireElement.consumInterval ;
        NSString *time = @"";
        if([consumeInterval isEqualToString:@"0"]){
            time = @"下午场 (12:00-18:00)";
            endTime = [NSString stringWithFormat:@"%@ %@",requireElement.consumDate,@"12:00"];
        }else if([consumeInterval isEqualToString:@"1"]){
            time = @"正场场 (18:00-00:00)";
            endTime = [NSString stringWithFormat:@"%@ %@",requireElement.consumDate,@"18:00"];
        }else if([consumeInterval isEqualToString:@"2"]){
            time = @"晚晚场 (00:00-06:00)";
            endTime = [NSString stringWithFormat:@"%@ %@",requireElement.consumDate,@"23:59"];
        }
        self.sTimeLa.text = [NSString stringWithFormat:@"%@ %@",requireElement.consumDate,time] ;//requireElement.hours
    }
    
    self.addressLa.text = requireElement.address;
    self.typeLa.text = [ConUtils convertTypeDetails:requireElement];
    self.drinksLa.text = [self getDrinkInfo:requireElement.winAry];

    endTime = [[endTime componentsSeparatedByString:@"("] objectAtIndex:0];
    self.endTimeLa.text = [ConUtils getReduceTime:endTime];
    
    [self.goodfaithBtn setTitle:[NSString stringWithFormat:@"诚意金:%@元",requireElement.payment] forState:UIControlStateNormal];
    
     self.descripLa.text =requireElement.brief;
 
    CGFloat height = [ConUtils cellHeight:requireElement.brief withWidth:self.descripLa.frame.size.width withFont:self.descripLa.font];
    if(height >16){
        
       self.bottomView.frame = CGRectMake(self.bottomView.frame.origin.x, self.bottomView.frame.origin.y+(height-15), self.bottomView.frame.size.width, self.bottomView.frame.size.height);
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height+(height -15));
        self.poiImg.frame = CGRectMake(self.poiImg.frame.origin.x, self.poiImg.frame.origin.y+(height-15), self.poiImg.frame.size.width, self.poiImg.frame.size.height);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+height-15);
        self.descripLa.frame = CGRectMake(self.descripLa.frame.origin.x, self.descripLa.frame.origin.y, self.descripLa.frame.size.width, height);
    }
}


/*
 * 酒水的拼装方法
 */
-(NSString *) getDrinkInfo :(NSMutableArray *) winAry {
    NSString *drinkInfo = @"";
    for (WineElement *element in winAry) {
        drinkInfo = [NSString stringWithFormat:@"%@%@瓶 %@",element.goodsName,element.goodsNumber,drinkInfo];
    }    
    return drinkInfo ;
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
