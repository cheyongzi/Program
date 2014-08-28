//
//  MoreSettingViewController.h
//  Booking
//
//  Created by 1 on 14-6-20.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoneBaseViewController.h"

@interface MoreSettingViewController : ZoneBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    
    NSArray *imgArr;
    NSArray *titleArr;
}
@end
