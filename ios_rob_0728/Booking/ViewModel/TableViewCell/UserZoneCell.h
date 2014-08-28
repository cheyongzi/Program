//
//  UserZoneCell.h
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserZoneCell : UITableViewCell
{
    UIImageView *iconImg;
    UILabel *textLabel;
    UIImageView *backgroundImg;
}

@property (strong,nonatomic) UIImageView *iconImg;
@property (strong,nonatomic) UILabel *textLabel;
@property (strong,nonatomic) UIImageView *backgroundImg;

@end
