//
//  CustomAlertView.m
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "CustomAlertView.h"
#import "ConstantField.h"

#define ALERT_BUTTON_TAG 1000

@implementation CustomAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 * frame 弹出框整体的大小
 * title 弹出框标题
 * point 弹出框位置
 * index UITableView点击的行数
 * type  弹出框的类型
 */
- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withPoint:(CGPoint)point withIndex:(int)index withStyle:(CustomAlertType)type withText:(NSString *)content;
{
    if (self = [super initWithFrame:frame])
    {
        self.index = index;
        
        alertType = type;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameTextEdit:) name:@"UITextFieldTextDidChangeNotification" object:textField];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
        [img setBackgroundColor:ALERT_BACKGROUND_COLOR];
        [img setAlpha:0.2];
        [img setUserInteractionEnabled:YES];
        [self addSubview:img];
        
        [self initHeaderWithTitle:title withPoint:point];
        
        switch (type) {
            case EditField_type:
                [self initEditStyleWithPoint:point withTitle:title withContent:content];
                break;
            case SexChoice_type:
                [self initChoiceStyleWithPoint:point];
                break;
                
            default:
                break;
        }
    }
    return self;
}

//初始化输入框类型的中间内容
- (void)initEditStyleWithPoint:(CGPoint)point withTitle:(NSString *)title withContent:(NSString *)content
{
    NSString *str = [[NSString alloc] initWithFormat:@"请输入您的%@",title];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(point.x+20, point.y+60, 220, 40)];
    [textField setFont:[UIFont systemFontOfSize:14]];
    textField.returnKeyType = UIReturnKeyDone;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
    if (content == nil || [content isEqualToString:@""])
    {
        textField.placeholder = str;
    }
    else
    {
        textField.text = content;
    }
    
    textField.delegate = self;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:textField];
}

//初始化选择类型的中间内容
- (void)initChoiceStyleWithPoint:(CGPoint)point
{
    isMan = YES;
    userSex = 0;
    mBtn = [[ChoiceBtn alloc] initWithFrame:CGRectMake(point.x + 20, point.y+60, 100, 40) withTitle:@"男"];
    mBtn.tag = 1;
    [mBtn addTarget:self action:@selector(choiceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    fBtn = [[ChoiceBtn alloc] initWithFrame:CGRectMake(point.x + 150, point.y+60, 100, 40) withTitle:@"女"];
    fBtn.tag = 2;
    [fBtn addTarget:self action:@selector(choiceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (isMan)
    {
        [fBtn.iconImg setImage:[UIImage imageNamed:@"protocalUnSel.png"]];
        [fBtn.titleLabel setTextColor:TITLE_LABEL_COLOR];
    }
    [self addSubview:mBtn];
    [self addSubview:fBtn];
}

//初始化公共的Header，确认和取消按钮
- (void)initHeaderWithTitle:(NSString *)title withPoint:(CGPoint)point
{
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(point.x,point.y, 260, 40)];
    [headerLabel setBackgroundColor:ALERT_HEADER_COLOR];
    [headerLabel setText:title];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:headerLabel];
    
    UIImageView *contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y+40, 260, 80)];
    [contentImg setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:contentImg];
    
    UIButton *confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirBtn setFrame:CGRectMake(point.x, point.y+120, 130, 40)];
    [confirBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirBtn setBackgroundColor:ALERT_CONFIRM_COLOR];
    [confirBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    confirBtn.tag = ALERT_BUTTON_TAG + 1;
    [self addSubview:confirBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(point.x+130, point.y+120, 130, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = ALERT_BUTTON_TAG + 2;
    [cancelBtn setBackgroundColor:ALERT_CANCEL_COLOR];
    [self addSubview:cancelBtn];
    
}

//弹出框确认和取消按钮单机事件
- (void)buttonClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag - ALERT_BUTTON_TAG) {
        case 1:
            if (alertType == EditField_type)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UserInfoChange" object:[NSNumber numberWithInt:self.index] userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[textField text],@"UserName", nil]];
            }
            else if (alertType == SexChoice_type)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UserInfoChange" object:[NSNumber numberWithInt:self.index] userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:userSex],@"UserName", nil]];
            }
            break;
        case 2:
            break;
            
        default:
            break;
    }
    [self removeFromSuperview];
}

//性别选择事件
- (void)choiceButtonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1:
            if (userSex != 0)
            {
                userSex = 0;
                [self setChociceWithFirst:mBtn withSecond:fBtn];
            }
            break;
        case 2:
            if (userSex != 1) {
                userSex = 1;
                [self setChociceWithFirst:fBtn withSecond:mBtn];
            }
            break;
            
        default:
            break;
    }
}

- (void)setChociceWithFirst:(ChoiceBtn *)firstBtn withSecond:(ChoiceBtn *)secondBtn
{
    [firstBtn.iconImg setImage:[UIImage imageNamed:@"protocal.png"]];
    [firstBtn.titleLabel setTextColor:[UIColor blackColor]];
    [secondBtn.iconImg setImage:[UIImage imageNamed:@"protocalUnSel.png"]];
    [secondBtn.titleLabel setTextColor:TITLE_LABEL_COLOR];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [self endEditing:YES];
}

- (void)nameTextEdit:(NSNotification *)notification
{
    UITextField *field = (UITextField *)notification.object;
    if (field == textField)
    {
        NSString * nameString = textField.text;
        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
        if ([lang isEqualToString:@"zh-Hans"])
        {
            UITextRange *selectedRange = [textField markedTextRange];
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                if (nameString.length > 8)
                {
                    textField.text = [nameString substringToIndex:8];
                }
            }
        }
        else
        {
            if (nameString.length > 8) {
                textField.text = [nameString substringToIndex:8];
            }
        }
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
