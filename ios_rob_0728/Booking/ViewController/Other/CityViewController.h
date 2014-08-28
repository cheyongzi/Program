//
//  CityViewController.h
//  Booking
//
//  Created by jinchenxin on 14-6-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"

@interface CityViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong ) IBOutlet UITableView *tableView ;
@property (strong ,nonatomic) NSArray *provincesAry ;
@property (strong ,nonatomic) NSArray *cityAry ;
@property (strong ,nonatomic) NSMutableDictionary *proCityListDic ;

@end
