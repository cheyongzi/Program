//
//  AppLoadViewController.h
//  Booking
//
//  Created by 1 on 14-6-27.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppLoadViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    
    NSArray *array;
    
    UIPageControl *pageControl;
}
@end
