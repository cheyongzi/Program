//
//  TimeSelecteView.h
//  Booking
//
//  Created by jinchenxin on 14-7-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TimeSelecteViewDelegate <NSObject>

-(void) timeSelecteViewTime:(NSString *) time AndLong:(NSString *) timeLong ;

-(void) timeSelecteViewCancel ;

@end

@interface TimeSelecteView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) id<TimeSelecteViewDelegate> delegate ;
@property (strong ,nonatomic) IBOutlet UITableView *timeTableView ;
@property (strong ,nonatomic) IBOutlet UITableView *timeLongTableView ;
@property (strong ,nonatomic) NSMutableArray *timeAry ;
@property (strong ,nonatomic) NSMutableArray *timeLongAry ;
@property (nonatomic) BOOL isMove ;
@property (strong ,nonatomic) NSString *time ;
@property (strong ,nonatomic) NSString *timeLong ;

@property (assign ,nonatomic) NSInteger      selectIndexFirst;
@property (assign ,nonatomic) NSInteger      selectIndexSecond;


-(void) initData ;

/*
 * 确定或取消按钮事件
 */
-(IBAction) clickEvent:(id)sender ;

@end
