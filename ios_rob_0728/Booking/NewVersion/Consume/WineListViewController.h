//
//  WineListViewController.h
//  Booking
//
//  Created by 1 on 14-7-28.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"

@interface WineListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
}
@property (strong, nonatomic) NSMutableArray        *dataArray;

@end
