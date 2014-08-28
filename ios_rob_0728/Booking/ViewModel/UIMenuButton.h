//
//  UIMenuButton.h
//  Booking
//
//  Created by jinchenxin on 14-7-8.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 自定义的主界面的菜单Button
 */
@interface UIMenuButton : UIButton

@property (strong ,nonatomic) UIImageView *menuImg ;
@property (strong ,nonatomic) UIImage *image_n ;
@property (strong ,nonatomic) UIImage *image_s ;
@property (strong ,nonatomic) UIImageView *menuBgImg ;
@property (strong ,nonatomic) UIImage *image_bg_n ;
@property (strong ,nonatomic) UIImage *image_bg_s ;

-(void) setMenuSelectedState:(BOOL) state ;

@end
