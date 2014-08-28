//
//  SexSelectButton.h
//  Booking
//
//  Created by 1 on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexSelectButton : UIButton
{
    UIImageView *iconImg;
    UILabel *titleLabel;
}

@property (strong,nonatomic) UIImageView *iconImg;
@property (strong,nonatomic) UILabel *titleLabel;

@end
