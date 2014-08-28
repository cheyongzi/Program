//
//  KTVMesureViewController.h
//  Booking
//
//  Created by jinchenxin on 14-6-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"

/*
 * KTV 量贬VeiwController
 */
@interface KTVMesureViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) IBOutlet UITableView *tableView ;

@end
