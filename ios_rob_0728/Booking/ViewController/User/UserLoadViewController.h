//
//  UserLoadViewController.h
//  Booking
//
//  Created by 1 on 11-12-31.
//  Copyright (c) 2011年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFiledBackgroundView.h"
#import "HttpRequestComm.h"
#import "BaseViewController.h"
#import "LoginResponse.h"
#import "UserElement.h"
#import "AlertInfoLabel.h"
#import "SVProgressHUD.h"

@interface UserLoadViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *accountField;
    UITextField *pwdField;
    
    TextFiledBackgroundView *backgroundView;
    
    HttpRequestComm *requestComm;
    
    LoginResponse *loginResponse;
    
    UserElement *userElement;
    
    //UIActivityIndicatorView *indicatorView;
}

@property (assign,nonatomic) BOOL loginTag;

@end
