//
//  BindEmailViewController.h
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "TextFiledBackgroundView.h"
#import "VerifyResponse.h"
#import "UserElement.h"
#import "LoginResponse.h"

@interface BindEmailViewController : BaseViewController<UITextFieldDelegate>
{
    TextFiledBackgroundView *backgroundView;
    
    UITextField *accountText;
    UITextField *verifyText;
    
    VerifyResponse *verifyResponse;
    
    UserElement *userElement;
    
    NSMutableDictionary *bindInfoDic;
    
    LoginResponse *loginResponse;
    
    NSTimer *timer;
    int time;
    UIButton *verifyCodeBtn;
}
@end
