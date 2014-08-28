//
//  UserCenterMainViewController.h
//  Booking
//
//  Created by 1 on 14-6-19.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "HttpRequestCommDelegate.h"
#import "HttpRequestComm.h"
#import "UIImageView+AFNetworking.h"
#import "UserElement.h"
#import "ZoneBaseViewController.h"

@interface UserZoneMainViewController : ZoneBaseViewController
{
    UIImageView *userPicImg;
    
    UserElement *userElement;
    
    UILabel *nickNameLabel;
    UIImageView *sexImg;
    
    NSArray *buttonNorImgArr;
    NSArray *buttonTitleArr;
    
    UILabel *noticeLabel;
    UIImageView *noticeImage;
    
    UILabel *inviteCodeLabel;
}

@end
