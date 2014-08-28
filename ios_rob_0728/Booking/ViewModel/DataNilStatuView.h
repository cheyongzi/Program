//
//  DataNilStatuView.h
//  Booking
//
//  Created by 1 on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataNilStatuView : UIView

@property (strong,nonatomic) UILabel *infoLabel;
@property (strong,nonatomic) UIImageView *img;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImage:(UIImage*)image;

@end
