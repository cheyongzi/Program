//
//  UIMenuButton.m
//  Booking
//
//  Created by jinchenxin on 14-7-8.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "UIMenuButton.h"
#import "ConUtils.h"

/*
 * 自定义的主界面的菜单Button
 */
@implementation UIMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addMenuView];
    }
    return self;
}

-(void) addMenuView {
    //self.titleEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    //[self setTitleColor:[UIColor colorWithRed:0.765 green:0.596 blue:0.996 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1] forState:UIControlStateNormal];
    
    [self bringSubviewToFront:self.titleLabel];
    
    self.adjustsImageWhenHighlighted = NO;
    
}

-(void) setImage:(UIImage *)image forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:{
            self.image_n = image;
            [super setImage:self.image_n forState:UIControlStateNormal];
        }
            break;
        case UIControlStateSelected:{
            self.image_s = image;
            //[super setImage:self.image_s forState:UIControlStateNormal];
        }
            break;
        case UIControlStateApplication:
        case UIControlStateDisabled:
        case UIControlStateHighlighted:
        case UIControlStateReserved:
            break;
    }
}

-(void) setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal:{
            self.image_bg_n = image ;
            //self.menuBgImg.image = [self.image_bg_n resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
            [super setBackgroundImage:[self.image_bg_n resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)] forState:UIControlStateNormal];
        }
            break;
        case UIControlStateSelected:{
            self.image_bg_s = image ;
            //self.menuBgImg.image = [self.image_bg_n resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
            //[super setBackgroundImage:[self.image_bg_s resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)] forState:UIControlStateSelected];
        }
            break;
        case UIControlStateApplication:
        case UIControlStateDisabled:
        case UIControlStateHighlighted:
        case UIControlStateReserved:
            break;
    }
}

-(void) setMenuSelectedState:(BOOL) selected {
    if(!selected){
        [super setImage:self.image_n forState:UIControlStateNormal];
        //self.menuBgImg.image = [self.image_bg_n resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
        [super setBackgroundImage:[self.image_bg_n resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)] forState:UIControlStateNormal];
    }else{
        [super setImage:self.image_s forState:UIControlStateNormal];
        //self.menuBgImg.image = [self.image_bg_s resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)];
        [super setBackgroundImage:[self.image_bg_s resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 20, 10)] forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
