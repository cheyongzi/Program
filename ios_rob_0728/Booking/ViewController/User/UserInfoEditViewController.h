//
//  UserInfoEditViewController.h
//  Booking
//
//  Created by 1 on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "UserElement.h"
#import "LoginResponse.h"

@interface UserInfoEditViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *myFirTable;
    
    NSArray *userArr1;
    NSArray *accountArr1;
    NSArray *accountArr2;
    
    NSArray *paramArr;
    
    NSArray *alertType;
    
    LoginResponse *loginResponse;
    UserElement *userElement;
    
    //用于更新除头像之外的转动圈
    //UIActivityIndicatorView *indicatorView;
    //userTyp 用户注册的类型 0表示手机，1表示邮箱
    int userType;
    
    //UIActivityIndicatorView *indicatorView2;
    
    UIImageView *backImg;
}
@end
