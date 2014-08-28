//
//  AccountCheckViewController.h
//  Booking
//
//  Created by 1 on 14-6-24.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "TextFiledBackgroundView.h"
#import "VerifyResponse.h"

@interface AccountCheckViewController : BaseViewController<UITextFieldDelegate>
{
    NSString *accountNumber;
    
    TextFiledBackgroundView *backgroundView;
    
    UITextField *accountText;
    UITextField *verifyText;
    
    VerifyResponse *verifyResponse;
    
    BOOL isUserPhoneType;
    
    UIButton *verifyCodeBtn;
    
    NSTimer *timer;
    int time;
}

- (id)initWithAccountNum:(NSString *)accountNum;
@end
