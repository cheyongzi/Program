//
//  UserAccountEditViewController.h
//  Booking
//
//  Created by 1 on 13-7-23.
//  Copyright (c) 2013年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "SharedUserDefault.h"

@interface UserAccountEditViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *mySecTable;
    
    NSArray *userArr1;
    NSArray *accountArr1;
    NSArray *accountArr2;
    
    NSArray *paramArr;
    
    NSArray *alertType;
    UserElement *userElement;
    
    //用于更新除头像之外的转动圈
    //UIActivityIndicatorView *indicatorView;
    //userTyp 用户注册的类型 0表示手机，1表示邮箱
    int userType;
    
    //UIActivityIndicatorView *indicatorView2;
    
    UIScrollView *myScrollView;
    
    UIImageView *backImg;
    
    UITableView *myTableView;
    NSArray *imgArr;
    NSArray *titleArr;
}
@end
