//
//  AddDrinkViewController.h
//  Booking
//
//  Created by jinchenxin on 14-6-17.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "BaseViewController.h"
#import "AddDrinkResponse.h"
#import "LoadingView.h"
#import "AddDrinkCell.h"
#import "DrinkTypeResponse.h"

@protocol AddDrinkDelegate <NSObject>

- (void)addDrink:(NSArray *)array;

@end

@interface AddDrinkViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong ,nonatomic) IBOutlet UIButton *searchBtn ;
@property (strong ,nonatomic) IBOutlet UITableView *tableView ;
@property (strong ,nonatomic) IBOutlet UIButton *currentSelBtn ;
@property (strong ,nonatomic) IBOutlet UITextField *keywordTF ;
@property (strong ,nonatomic) IBOutlet UILabel *totalLa ;
@property (strong ,nonatomic) IBOutlet UILabel *addDrinkInfoLa ;
@property (strong ,nonatomic) NSString *searchType ;
@property (strong ,nonatomic) NSString *keyword ;
@property (strong ,nonatomic) AddDrinkResponse *drinkResponse ;
@property (strong ,nonatomic) NSMutableArray *winAry ;
@property (strong ,nonatomic) NSMutableArray *addWineAry ;
@property (strong ,nonatomic) NSMutableArray *existAry ;
@property (strong ,nonatomic) IBOutlet UIScrollView *scrollView ;
@property (strong ,nonatomic) UIImageView *tagView ;
@property (strong ,nonatomic) IBOutlet UIImageView *conImg ;
@property (nonatomic) BOOL isExistDrink ;

@property (nonatomic) NSInteger currentPage ;
@property (nonatomic ,strong) DrinkTypeResponse *typeResponse ;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomBakImage;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabelSecond;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@property (strong, nonatomic) id<AddDrinkDelegate> delegate;

/*
 * 酒水的搜索
 */
-(IBAction)searchClickEvent:(id)sender ;

@end
