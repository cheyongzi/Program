//
//  DrinkViewController.h
//  Booking
//
//  Created by jinchenxin on 14-6-28.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"

/*
 * 酒水列表
 */
@interface DrinkViewController : BaseViewController<UITableViewDataSource ,UITableViewDelegate>

@property (strong ,nonatomic) IBOutlet UITableView *tableView ;
@property (strong ,nonatomic) NSArray *drinkAry ;

@end
