//
//  CustomAlertView.h
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

typedef enum
{
    EditField_type = 0,
    SexChoice_type,
    
}CustomAlertType;

#import <UIKit/UIKit.h>
#import "ChoiceBtn.h"

@interface CustomAlertView : UIView<UITextFieldDelegate>
{
    UITextField *textField;
    
    NSInteger userSex;
    
    ChoiceBtn *mBtn;
    ChoiceBtn *fBtn;
    
    BOOL isMan;
    
    int alertType;
}

@property (assign,nonatomic) int index;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withPoint:(CGPoint)point withIndex:(int)index withStyle:(CustomAlertType)type withText:(NSString *)content;

@end
