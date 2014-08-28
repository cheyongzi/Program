//
//  PwdChangeViewController.h
//  Booking
//
//  Created by 1 on 14-6-25.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "TextFiledBackgroundView.h"
#import "UserElement.h"

@interface PwdChangeViewController : BaseViewController<UITextFieldDelegate>
{
    TextFiledBackgroundView *backgroundView;
    
    UITextField *oldPwdText;
    UITextField *newPwdText;
    UITextField *confirPwdText;
    
    UserElement *userElement;
}
@end
