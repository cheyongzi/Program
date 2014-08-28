//
//  AddDrinkCell.m
//  Booking
//
//  Created by jinchenxin on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AddDrinkCell.h"
#import "UIImageView+WebCache.h"

@implementation AddDrinkCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //[self addDrinkMenuCellView];
        self = [[[NSBundle mainBundle] loadNibNamed:@"AddDrinkCell" owner:self options:nil] objectAtIndex:0];
        
        self.backgroundImg.image = [[UIImage imageNamed:@"com_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
