//
//  UserInfoChangeCell.h
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoChangeCell : UITableViewCell
{
    UILabel *contentLabel;
    
    UILabel *titleLabel;
}

@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *contentLabel;
@end
