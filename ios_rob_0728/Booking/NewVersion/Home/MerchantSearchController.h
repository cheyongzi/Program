//
//  MerchantSearchController.h
//  Booking
//
//  Created by jinchenxin on 14-7-11.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "ProviderResponse.h"

/*
 * 搜索结果页面
 */
@interface MerchantSearchController : BaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) UIImageView *searchImg ;
@property (strong ,nonatomic) UIButton *searchBtn ;
@property (strong ,nonatomic) UITextField *searchTf ;
@property (strong ,nonatomic) NSMutableArray *proAry ;
@property (strong ,nonatomic) NSMutableDictionary *paramDic ;
@property (strong ,nonatomic) NSString *seaContent ;
@property (strong ,nonatomic) ProviderResponse *proResponse ;
@property (strong ,nonatomic) IBOutlet UITableView *tableView ;

@end
