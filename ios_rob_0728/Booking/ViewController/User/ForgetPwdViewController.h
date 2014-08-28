//
//  ForgetPwdViewController.h
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TextFiledBackgroundView.h"
#import "VerifyResponse.h"

@interface ForgetPwdViewController : BaseViewController<UITextFieldDelegate>
{
    TextFiledBackgroundView *backgroundView;
    
    UITextField *accountText;
    UITextField *verifyText;
    
    BOOL isUserPhoneType;
    
    VerifyResponse *verifyResponse;
    
    NSTimer *timer;
    int time;
    UIButton *verifyCodeBtn;
    
    //UIActivityIndicatorView *indicator;
}
@end
