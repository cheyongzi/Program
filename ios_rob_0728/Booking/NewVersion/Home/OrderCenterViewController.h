//
//  OrderCenterViewController.h
//  Booking
//
//  Created by jinchenxin on 14-7-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "RobRequireResponse.h"
#import "OrderResponse.h"

@interface OrderCenterViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) IBOutlet UITableView *tableView ;
@property (strong ,nonatomic) IBOutlet UITableView *conTableView ;
@property (strong ,nonatomic) IBOutlet UITableView *comTableView ;
@property (strong ,nonatomic) IBOutlet UITableView *comedTableView ;
@property (strong ,nonatomic) IBOutlet UITableView *hisTableView ;
@property (strong ,nonatomic) IBOutlet UIImageView *currentImg ;
@property (strong ,nonatomic) IBOutlet UIButton *wSubmitBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *wConsumeBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *wCommentBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *wCommentedBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *wHistoryBtn ;
@property (strong ,nonatomic) UIButton *currentBtn ;
@property (strong ,nonatomic) IBOutlet UIScrollView *scrollView ;
@property (nonatomic) NSInteger currentPosition ;
@property (strong ,nonatomic) NSMutableDictionary *conParamDic ;
@property (strong ,nonatomic) RobRequireResponse *robResponse ;
@property (strong ,nonatomic) NSMutableArray *robAry ;
@property (nonatomic) NSInteger currentRobPage ;
@property (strong ,nonatomic) OrderResponse *conResponse ;
@property (strong ,nonatomic) NSMutableArray *conAry ;
@property (nonatomic) NSInteger currentConPage ;

@property (strong ,nonatomic) NSMutableDictionary *comParamDic ;
@property (strong ,nonatomic) OrderResponse *comResponse ;
@property (strong ,nonatomic) NSMutableArray *comAry ;
@property (nonatomic) NSInteger currentComPage ;

@property (strong ,nonatomic) NSMutableDictionary *comedParamDic ;
@property (strong ,nonatomic) OrderResponse *comedResponse ;
@property (strong ,nonatomic) NSMutableArray *comedAry ;
@property (nonatomic) NSInteger currentComedPage ;

@property (strong ,nonatomic) RobRequireResponse *hisResponse ;
@property (strong ,nonatomic) NSMutableArray *hisAry ;
@property (nonatomic) NSInteger currentHisPage ;

@property (assign ,nonatomic) BOOL  isFromConfirOrder;

@property (strong ,nonatomic) UILabel        *infoLabel;


/*
 * 顶部菜单的选择按钮
 */
-(IBAction)menuClickEvent:(id)sender ;

@end
