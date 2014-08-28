//
//  MerchatSelectController.h
//  Booking
//
//  Created by jinchenxin on 14-6-17.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "ProviderResponse.h"

@protocol MerchatSelectDelegate <NSObject>

- (void)shopShelect:(NSArray*)array;

@end

@interface MerchatSelectController : BaseViewController<UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate>

@property (strong ,nonatomic) IBOutlet UITableView *tableView ;
@property (strong ,nonatomic) IBOutlet UIButton *searchBtn ;
@property (strong ,nonatomic) IBOutlet UILabel *providerInfoLa ;
@property (strong ,nonatomic) IBOutlet UITextField *shopsNameTf ;

@property (nonatomic) NSInteger currentPage ;
@property (strong ,nonatomic) NSString *shopsName ;

@property (strong ,nonatomic) ProviderResponse *proResponse ;
@property (strong ,nonatomic) NSMutableArray *proAry ;
@property (strong ,nonatomic) NSMutableArray *selProAry ;
@property (strong ,nonatomic) NSMutableDictionary *paramDic ;
@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) NSString  *shopType;

@property (strong, nonatomic) id<MerchatSelectDelegate> delegate;


/*
 * 商家搜索事件
 */
-(IBAction)searchClickEvent:(id)sender ;

@end
