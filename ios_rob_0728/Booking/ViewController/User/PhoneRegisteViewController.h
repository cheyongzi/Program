//
//  PhoneRegisteViewController.h
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFiledBackgroundView.h"
#import "HttpRequestComm.h"
#import "BaseViewController.h"
#import "VerifyResponse.h"

@interface PhoneRegisteViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *phoneNum;
    UITextField *verificationCode;
    UITextField *password;
    UITextField *confirmPwd;
    UITextField *inviteCode;
    
    UIButton *protocalBtn;
    
    TextFiledBackgroundView *backgroundView;
    
    BOOL isAgreeProtocal;
    
    VerifyResponse *verifyResponse;
    
    NSTimer *timer;
    int time;
    UIButton *verifyCodeBtn;
    
    //UIActivityIndicatorView *indicator;
}
@end
