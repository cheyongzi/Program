//
//  CustomScrollView.m
//  RobClientSecond
//
//  Created by 1 on 13-7-19.
//  Copyright (c) 2013年 cheyongzi. All rights reserved.
//

#import "CustomHorizontalScrollView.h"
#import "ContentViewStyleOne.h"
#import "ConstantField.h"

#define VIEW_WITH   86
#define VIEW_HEIGHT 40
#define SCROLL_CONTENTOFFSET_X 107

@implementation CustomHorizontalScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化其中的UIScrollView
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [image setImage:[UIImage imageNamed:@"scrollerBg.png"]];
        [self addSubview:image];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.delegate = self;
        
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self.scrollView addGestureRecognizer:recognizer];
    }
    return self;
}

//点击事件
- (void)tapGestureAction:(UITapGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:gesture.view];
    
    for (int i= 0; i<[self.delegate numberOfViewsWithScrollView:self]; i++)
    {
        UIView *view = [[self.scrollView subviews] objectAtIndex:i];
        if (CGRectContainsPoint(view.frame, location))
        {
            if (self.selectIndex != i)
            {
                [self.scrollView setContentOffset:CGPointMake(VIEW_WITH*i, 0) animated:YES];
                [[[[self.scrollView subviews] objectAtIndex:self.selectIndex] backgroundImg]setHidden:YES];
                [[[[self.scrollView subviews] objectAtIndex:self.selectIndex] titleLab] setTextColor:[UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1]];
                [[[[self.scrollView subviews] objectAtIndex:self.selectIndex] secondTitleLab] setTextColor:[UIColor lightGrayColor]];
                [[[[self.scrollView subviews] objectAtIndex:i] backgroundImg] setHidden:NO];
                [[[[self.scrollView subviews] objectAtIndex:i] titleLab] setTextColor:[UIColor whiteColor]];
                [[[[self.scrollView subviews] objectAtIndex:i] secondTitleLab] setTextColor:[UIColor whiteColor]];
                self.selectIndex = i;
            }
            [self.delegate scrollView:self clickedAtIndex:i];
            break;
        }
    }
}

//加载UIScrollView中的内容
- (void)initContentInScrollView
{
    if (self.delegate == nil) return;
    
    if ([[self.scrollView subviews] count]!=0)
    {
        [[self.scrollView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
    }
    
    CGFloat viewOffsetX = 107;
    
    for (int i=0; i<[self.delegate numberOfViewsWithScrollView:self]; i++)
    {
        HorizontalScrollContentView *view = (HorizontalScrollContentView *)[self.delegate scrollView:self withIndex:i];
        if (i==self.selectIndex)
        {
            [view.backgroundImg setHidden:NO];
            [view.titleLab setTextColor:[UIColor whiteColor]];
            [view.secondTitleLab setTextColor:[UIColor whiteColor]];
        }
        
        view.frame = CGRectMake(viewOffsetX, 13, VIEW_WITH, VIEW_HEIGHT);
        
        [self.scrollView addSubview:view];
        
        viewOffsetX += VIEW_WITH;
    }
    [self.scrollView setContentSize:CGSizeMake(viewOffsetX+107, self.scrollView.frame.size.height)];
}

//UIScrollview中选中的View
- (void)selectedViewInScrollView
{
    int xPosition = self.scrollView.contentOffset.x;
    int indexPostion = xPosition / VIEW_WITH;
    if (xPosition>(indexPostion+0.5)*VIEW_WITH) {
        indexPostion++;
    }
    xPosition = indexPostion*VIEW_WITH;
    [self.scrollView setContentOffset:CGPointMake(xPosition, 0) animated:YES];
    [[[[self.scrollView subviews] objectAtIndex:self.selectIndex] backgroundImg]setHidden:YES];
    [[[[self.scrollView subviews] objectAtIndex:self.selectIndex] titleLab] setTextColor:[UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1]];
    [[[[self.scrollView subviews] objectAtIndex:self.selectIndex] secondTitleLab] setTextColor:[UIColor lightGrayColor]];
    [[[[self.scrollView subviews] objectAtIndex:indexPostion] backgroundImg] setHidden:NO];
    [[[[self.scrollView subviews] objectAtIndex:indexPostion] titleLab] setTextColor:[UIColor whiteColor]];
    [[[[self.scrollView subviews] objectAtIndex:indexPostion] secondTitleLab] setTextColor:[UIColor whiteColor]];
    self.selectIndex = indexPostion;
    [self.delegate scrollView:self clickedAtIndex:self.selectIndex];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self selectedViewInScrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self selectedViewInScrollView];
}

#pragma mark 重新加载滚动视图
- (void)reloadData
{
    [self initContentInScrollView];
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
