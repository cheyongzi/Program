//
//  CustomHorizontalScrollView.h
//  RobClientSecond
//
//  Created by 1 on 13-7-19.
//  Copyright (c) 2013年 cheyongzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomHorizontalScrollView;

@protocol CustomHorizontalScrollDelegate <NSObject>

@required

- (NSInteger)numberOfViewsWithScrollView:(CustomHorizontalScrollView *)scrollView;

- (UIView *)scrollView:(CustomHorizontalScrollView *)scrollView withIndex:(int)index;

- (void)scrollView:(CustomHorizontalScrollView *)scrollView clickedAtIndex:(int)index;

@end

@interface CustomHorizontalScrollView : UIView<UIScrollViewDelegate>

@property (weak, nonatomic) id<CustomHorizontalScrollDelegate> delegate;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) int   selectIndex;

- (void)initContentInScrollView;

- (void)reloadData;

@end
