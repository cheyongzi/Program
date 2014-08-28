//
//  OrderDetailsViewController.h
//  Booking
//
//  Created by jinchenxin on 14-7-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderDetailsHeadView.h"
#import "OrderCommentView.h"
#import "OrderConsumeHeadView.h"
#import "AcceptOrderElement.h"
#import "AcceptOrderResponse.h"


@interface OrderDetailsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) IBOutlet UITableView *tableView ;
@property (strong ,nonatomic) OrderDetailsHeadView *headView ;
@property (strong ,nonatomic) OrderConsumeHeadView *consumeView ;
@property (strong ,nonatomic) OrderCommentView *commView ;
@property (strong ,nonatomic) OrderConsumeHeadView *hisView ;
@property (nonatomic) NSInteger currentPosition ;
@property (strong ,nonatomic) IBOutlet UIView *bottomView ;
@property (strong ,nonatomic) IBOutlet UIButton *nextBtn ;
@property (strong ,nonatomic) NSMutableArray *wineAry ;
@property (strong ,nonatomic) RequireElement *reElement ;
@property (strong ,nonatomic) AcceptOrderResponse *acResponse;
@property (strong ,nonatomic) NSMutableArray *acAry ;
@property (strong ,nonatomic) NSString *price ;

@end
