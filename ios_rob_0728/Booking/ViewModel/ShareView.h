//
//  ShareView.h
//  Booking
//
//  Created by 1 on 14-6-27.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareApi.h"

@interface ShareView : UIView
{
    ShareApi *shareApi;
    
    NSArray *array;
    NSArray *textArray;
    
    UIImageView *img;
    UIImageView *img2;
}

- (void)initContentView;
@end
