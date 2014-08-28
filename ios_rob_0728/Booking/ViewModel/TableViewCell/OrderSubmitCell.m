//
//  OrderSubmitCell.m
//  Booking
//
//  Created by jinchenxin on 14-7-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "OrderSubmitCell.h"
#import "WineElement.h"
#import "ConUtils.h"
#import "SharedUserDefault.h"
#import "BaseViewController.h"
#import "UIImageView+WebCache.h"

/*
 * 待确认UITableViewCell
 */
@implementation OrderSubmitCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 * 设置Cell数据内容
 */
-(void) setSubmitCellData:(AcceptOrderElement *) element {
    [ConUtils checkFileWithURLString:element.logo withImageView:self.picImg withDirector:@"Shop" withDefaultImage:@"defaultImg.png"];
    self.picImg.layer.cornerRadius = 3 ;
    self.picImg.clipsToBounds = YES ;
    
    self.nameLa.text = element.shopName;
    NSString *typeName = [[SharedUserDefault sharedInstance] getSystemNameType:@"RoomType" andTypeKey:element.typeId];
    if (element.roomName!=nil&&![element.roomName isEqualToString:@""]) {
        self.shopTypeLa.text = [NSString stringWithFormat:@"%@(%@)",typeName,element.roomName];
    }
    else
    {
        self.shopTypeLa.text = typeName;
    }
    
    if (!self.isCostCell) {
        //NSString *timeStr = [self getAddReduceTime:element.endTime];
        NSString *reduceTime = [ConUtils getReduceTime:element.endTime];
        //剩余时间的计算方法
        
        NSArray *reAry = [reduceTime componentsSeparatedByString:@","];
        if([reAry count]>1){
            self.hoursLa.text = [reAry objectAtIndex:0];
            self.minuteLa.text = [reAry objectAtIndex:1];
        }else{
            [self.reduceTimeView removeFromSuperview];
            self.comHisBtn.hidden = NO ;
            [self.comHisBtn setTitle:@" 已过期" forState:UIControlStateNormal];
            [self.comHisBtn setImage:[UIImage imageNamed:@"h_order_his"] forState:UIControlStateNormal];
        }
    }
    else
    {
        [self.reduceTimeView removeFromSuperview];
    }
    
    NSString *distance = [ConUtils getDistanceLatA:[element.latitude floatValue] lngA:[element.longitude floatValue]];
    self.distanceLa.text = distance;
    
    NSMutableArray *drinkAry = element.winAry ;
    if(drinkAry != nil && [drinkAry count]>0){
        NSInteger counts = [ConUtils getDrinkTotalCounts:drinkAry];
        [self.drinkBtn setTitle:[NSString stringWithFormat:@"有酒水(%d)",counts] forState:UIControlStateNormal];
        
    }else{
       [self.drinkBtn setTitle:@"无酒水" forState:UIControlStateNormal];
        self.arrowImg.hidden = YES ;
    }
    
    NSString *state = element.status ;
    if([state isEqualToString:@"1"])
    {
        self.zhongbiaoImg.hidden = NO ;
        self.verityCodeLa.hidden = NO ;
        self.verityLa.hidden = NO ;
    }
}
- (IBAction)phoneButtonAction:(id)sender
{
    NSString *phoneNumber = self.phoneButton.titleLabel.text;
    NSString *phoneString = [NSString stringWithFormat:@"telprompt:%@",phoneNumber];
    NSURL    *phoneUrl    = [NSURL URLWithString:phoneString];
    [[UIApplication sharedApplication] openURL:phoneUrl];
}

-(NSString *) getAddReduceTime:(NSString *) dateTime
{
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [matter dateFromString:dateTime];
    NSDate *otherDate = [NSDate dateWithTimeInterval:-5*60 sinceDate:date];
    NSString *time = [matter stringFromDate:otherDate];
    return time ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
