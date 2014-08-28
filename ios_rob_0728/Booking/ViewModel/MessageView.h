//
//  MessageView.h
//  Booking
//
//  Created by 1 on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageButton : UIButton

@property (strong,nonatomic) UILabel *timeLabel;
@property (strong,nonatomic) UILabel *label;

- (id)initWithFrame:(CGRect)frame withType:(int)type;

@end

@protocol MessageViewDelegate <NSObject>

- (void)messageViewClicked:(int)type withView:(id)view;

@end

@interface MessageView : UIView

@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UILabel *contentLabel;
@property (strong,nonatomic) UILabel *seperateLabel2;
@property (strong,nonatomic) MessageButton *button;
@property (assign,nonatomic) int type;
@property (assign,nonatomic) id<MessageViewDelegate> delegate;

//type取值0，1  0表示链接跳转 1表示展开更多内容
- (id)initWithFrame:(CGRect)frame withViewType:(int)type;

@end
