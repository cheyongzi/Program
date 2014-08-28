//
//  MessageView.m
//  Booking
//
//  Created by 1 on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "MessageView.h"
#import "ConstantField.h"

@implementation MessageButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withType:(int)type
{
    if (self = [super initWithFrame:frame])
    {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
        [self.timeLabel setBackgroundColor:[UIColor clearColor]];
        [self.timeLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:self.timeLabel];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 80, 30)];
        [self.label setBackgroundColor:[UIColor clearColor]];
        [self.label setFont:[UIFont systemFontOfSize:14]];
        [self.label setTextColor:[UIColor redColor]];
        if (type == 0)
        {
            [self.label setText:@"查看详情 >"];
        }
        else if (type == 1)
        {
            [self.label setText:@"查看更多 v"];
        }
        [self addSubview:self.label];
    }
    return self;
}

@end

@implementation MessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withViewType:(int)type
{
    if (self = [super initWithFrame:frame])
    {
        self.type = type;
        
        self.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
        self.layer.borderWidth = 1;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        
        UILabel *seperateLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 300, 1)];
        [seperateLabel1 setBackgroundColor:LOAD_SEPERATE_COLOR];
        [self addSubview:seperateLabel1];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 300, 120)];
        [self.contentLabel setBackgroundColor:[UIColor clearColor]];
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentLabel.numberOfLines = 0;
        [self addSubview:self.contentLabel];
        
        self.seperateLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 169, 300, 1)];
        [self.seperateLabel2 setBackgroundColor:LOAD_SEPERATE_COLOR];
        [self addSubview:self.seperateLabel2];
        
        self.button = [[MessageButton alloc] initWithFrame:CGRectMake(0, frame.size.height-30, 300, 30) withType:type];
        [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
    }
    return self;
}

- (void)buttonClicked:(id)sender
{
    [self.delegate messageViewClicked:self.type withView:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate messageViewClicked:self.type withView:self];
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
