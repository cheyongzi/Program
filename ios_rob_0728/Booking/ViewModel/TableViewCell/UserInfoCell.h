//
//  UserInfoCell.h
//  Booking
//
//  Created by 1 on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SexSelectButton.h"

@interface UserInfoCell : UITableViewCell
{
    UILabel *titleLabel;
    
    UITextField *textField;
}

@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UITextField *textField;
@end
