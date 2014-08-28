//
//  DrinkCell.m
//  Booking
//
//  Created by jinchenxin on 14-6-28.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "DrinkCell.h"
#import "UIImageView+WebCache.h"
#import "HttpRequestField.h"
#import "ConUtils.h"

@implementation DrinkCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setDrinkCellData:(WineElement *) element {
    [ConUtils checkFileWithURLString:element.goodsImg withImageView:self.picImg withDirector:@"Wine" withDefaultImage:@"con_wear.png"];
//    [self.picImg setImageWithURL:[NSURL URLWithString:@"http://p0.55tuan.com/images/upload/newimage/201112/19/111219170145_475954_mguemlo80e8e.jpg"]];
    self.nameLa.text = [NSString stringWithFormat:@"%@ X %@",element.goodsName,element.goodsNumber];
    self.priceLa.text = [NSString stringWithFormat:@"单价:%@元",element.goodsPrice];
    NSInteger totalPrice = [element.goodsNumber integerValue] * [element.goodsPrice integerValue] ;
    self.totalPriceLa.text = [NSString stringWithFormat:@"总价:%d元",totalPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
