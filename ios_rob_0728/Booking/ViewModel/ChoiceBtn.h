//
//  ChoiceBtn.h
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceBtn : UIButton
{
    UIImageView *iconImg;
    
    UILabel *titleLabel;
}

@property (strong,nonatomic) UIImageView *iconImg;
@property (strong,nonatomic) UILabel *titleLabel;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title;
@end
