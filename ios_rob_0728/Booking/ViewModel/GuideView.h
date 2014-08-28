//
//  GuideView.h
//  Booking
//
//  Created by 1 on 14-8-26.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    HOME_GUIDE = 0,
    USERZONE_GUIDE,
    PRICE_GUIDE
}GuideTag;

@interface GuideView : UIView
{
    UIImageView* imageView;
    
    int          guide;
}

- (id)initWithFrame:(CGRect)frame withTag:(GuideTag)tag;

@end
