//
//  MailRegisteViewController.h
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFiledBackgroundView.h"
#import "BaseViewController.h"
#import "VerifyResponse.h"

@interface MailRegisteViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *mailNum;
    UITextField *verificationCode;
    UITextField *password;
    UITextField *confirmPwd;
    
    UIButton *protocalBtn;
    
    TextFiledBackgroundView *backgroundView;
    
    BOOL isAgreeProtocal;
    
    VerifyResponse *verifyResponse;
    
    NSTimer *timer;
    
    UIButton *verifyCodeBtn;
    
    int time;
}
@end
