//
//  KTVDetailsViewController.h
//  Booking
//
//  Created by jinchenxin on 14-6-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"

@interface KTVDetailsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) IBOutlet UITableView *tableView ;

@end