//
//  PriceConfirmViewController.m
//  Booking
//
//  Created by 1 on 13-7-21.
//  Copyright (c) 2013年 bluecreate. All rights reserved.
//

#import "PriceConfirmViewController.h"
#import "HorizontalScrollContentView.h"
#import "ContentViewStyleOne.h"
#import "ContentViewStyleSecond.h"
#import "SharedUserDefault.h"
#import "ParamElement.h"
#import "RobOrderResponse.h"
#import "UserLoadViewController.h"
#import "OrderCenterViewController.h"
#import "WineListViewController.h"
#import "DrinkViewController.h"

#define SCROLVIEW_TAG 1000
#define VIEW_TAG      2000

@interface PriceConfirmViewController ()
{
    NSArray         *titleArray;
    NSArray         *timeArray;
    NSMutableDictionary *dataDic;
    NSArray         *paramArray;
}
@end

@implementation PriceConfirmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithInfo:(NSMutableDictionary *)infoDic
{
    self = [super init];
    if (self) {
        // Custom initialization
        dataDic = infoDic;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.myVScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, APPLICATION_HEIGHT-100);
    self.myVScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 400);
    
    self.confirmView.frame = CGRectMake(0, APPLICATION_HEIGHT-100, SCREEN_WIDTH, 56);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"确认发布";
    
    if ([[SharedUserDefault sharedInstance] getSystemParam]!=nil)
    {
        paramArray = [[SharedUserDefault sharedInstance] getSystemType:@"ShopType"];
    }
    
    for (ParamElement *param in paramArray)
    {
        if (paramArray!=nil&&[paramArray count]!=0)
        {
            if (self.shopType == [param.paramterId integerValue])
            {
                if ([param.paramName isEqualToString:@"KTV"])
                {
                    self.shopTypeImage.image = [UIImage imageNamed:@"ktv"];
                }
                else if ([param.paramName isEqualToString:@"JB"])
                {
                    self.shopTypeImage.image = [UIImage imageNamed:@"bar_type"];
                }
                else if ([param.paramName isEqualToString:@"YC"])
                {
                    self.shopTypeImage.image = [UIImage imageNamed:@"midnight"];
                }
                break;
            }
        }
    }
    
    self.headerLabelOne.text = [[SharedUserDefault sharedInstance] getCurrentAddress];
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    [dateFor setDateFormat:@"MM月dd日"];
    self.headerLabelSecond.text = [NSString stringWithFormat:@"%@",[dateFor stringFromDate:[NSDate date]]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addDrinkRefresh:) name:ADDDRINKREFRESH object:nil];
    
    NSArray *array = [NSArray arrayWithObjects:self.shopView,self.winView,self.endTimeView,self.confirmView, nil];
    [self initViewWithArray:array];
    
    [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    
    [self initUserInfo];
    
    self.customScrollViewOne = [[CustomHorizontalScrollView alloc] initWithFrame:CGRectMake(10, 117, 300, 60)];
    self.customScrollViewOne.tag = SCROLVIEW_TAG + 1;
    self.customScrollViewOne.delegate = self;
    [self.myVScrollView addSubview:self.customScrollViewOne];
    [self.customScrollViewOne initContentInScrollView];
    
    self.customScrollViewSecond = [[CustomHorizontalScrollView alloc] initWithFrame:CGRectMake(10, 204, 300, 60)];
    self.customScrollViewSecond.tag = SCROLVIEW_TAG + 2;
    self.customScrollViewSecond.delegate = self;
    [self.myVScrollView addSubview:self.customScrollViewSecond];
    [self.customScrollViewSecond initContentInScrollView];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUserInfo
{
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",[dataDic objectForKey:@"offerPrice"]];
    for (ParamElement *element in [[SharedUserDefault sharedInstance] getSystemType:@"Volume"])
    {
        if ([[dataDic objectForKey:@"volumeId"] isEqualToString:[element paramterId]])
        {
            titleArray = [NSArray arrayWithObject:element.paramName];
            break;
        }
    }
    
    NSArray *timeArr = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"下午场",@"正晚场",@"晚晚场", @"自定义",nil],[NSArray arrayWithObjects:@"12:00-18:00",@"18:00-00:00",@"00:00-06:00",self.consumeTime, nil], nil];
    NSString *str1 = [[timeArr objectAtIndex:0] objectAtIndex:[[dataDic objectForKey:@"consumInterval"] integerValue]];
    NSString *str2 = [[timeArr objectAtIndex:1] objectAtIndex:[[dataDic objectForKey:@"consumInterval"] integerValue]];
    timeArray = [NSArray arrayWithObjects:str1,str2, nil];
    
    if ([self.shopArray count]>0)
    {
        self.shopLabel.text = [NSString stringWithFormat:@"已指定%d个商家",[self.shopArray count]];
    }
    
    if ([self.wineArray count]>0)
    {
        int count = 0;
        for (WineElement *element in self.wineArray)
        {
            count += [element.goodsNumber integerValue];
        }
        self.wineLabel.text = [NSString stringWithFormat:@"我需要的酒水/小吃(%d)",count];
        self.wineLabel.textColor = [UIColor blackColor];
    }
    
    NSString *endTimeStr = [dataDic objectForKey:@"endTime"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    NSDate *date = [formatter dateFromString:endTimeStr];
    
    NSTimeInterval time = [date timeIntervalSinceDate:[NSDate date]];
    int hour = ((int)time)/(3600*24)*24 + ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)%3600/60;
    self.endTimeLabelOne.text = hour/10==0?[NSString stringWithFormat:@"0%d",hour]:[NSString stringWithFormat:@"%d",hour];
    self.endTimeLabelSecond.text = minute/10==0?[NSString stringWithFormat:@"0%d",minute]:[NSString stringWithFormat:@"%d",minute];
}

#pragma mark =======
- (void)initViewWithArray:(NSArray *)array
{
    for (UIView *view in array) {
        view.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
        view.layer.borderWidth = 1;
    }
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.winView addGestureRecognizer:gesture];
}

#pragma mark CustomHorizontalScrollDelegate
- (NSInteger)numberOfViewsWithScrollView:(CustomHorizontalScrollView *)scrollView
{
    switch (scrollView.tag - SCROLVIEW_TAG) {
        case 1:
            return [titleArray count];
            break;
        case 2:
            return [timeArray count]-1;
            break;
        default:
            return 0;
            break;
    }
}

- (UIView*)scrollView:(CustomHorizontalScrollView *)scrollView withIndex:(int)index
{
    HorizontalScrollContentView *view = nil;
    switch (scrollView.tag - SCROLVIEW_TAG) {
        case 1:
            view = [[ContentViewStyleOne alloc] initWithFrame:CGRectMake(0, 0, 86, 40) withTitle:[titleArray objectAtIndex:0] withImage:@"scrollerContentBg.png"];
            break;
        case 2:
            view = [[ContentViewStyleSecond alloc] initWithFrame:CGRectMake(0, 0, 86, 40) withTitle:[timeArray objectAtIndex:0] withSecondTitle:[timeArray objectAtIndex:1] withImage:@"scrollerContentBg.png"];
            break;
        default:
            break;
    }
    return view;
}

- (void)scrollView:(CustomHorizontalScrollView *)scrollView clickedAtIndex:(int)index
{
    
}

#pragma mark UITapGestureRecognizer
- (void)tapGestureAction:(UITapGestureRecognizer *)gesture
{
    WineListViewController *wineListController = [[WineListViewController alloc] init];
    wineListController.dataArray = self.wineArray;
    [self.navigationController pushViewController:wineListController animated:YES];
}
#pragma mark 酒水添加通知
-(void) addDrinkRefresh:(id) sender {
    NSNotification *notification = (NSNotification *)sender;
    self.wineArray = notification.object ;
    if([self.wineArray count]>0)
    {
        int count = 0;
        for (WineElement *element in self.wineArray)
        {
            count += [element.goodsNumber integerValue];
        }
        self.wineLabel.text = [NSString stringWithFormat:@"我需要的酒水/小吃(%d)",count];
        self.wineLabel.textColor = [UIColor colorWithRed:62.0f/255 green:62.0f/255 blue:62.0f/255 alpha:1];
    }
    else
    {
        self.wineLabel.text = @"添加酒水/小吃";
        self.wineLabel.textColor = [UIColor lightGrayColor];
    }
    int totalPrice = self.basePrice + ((int)(self.scale*[[self getAddDrinkTotalPrice] integerValue]))/10*10;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%d",totalPrice];
    [dataDic setObject:[NSString stringWithFormat:@"%d",totalPrice] forKey:@"offerPrice"];
}

-(NSString *) getAddDrinkTotalPrice {
    NSInteger totalPrice = 0;
    for (WineElement *wineElement in self.wineArray) {
        NSString *goodsNumber = wineElement.goodsNumber ;
        NSString *goodsPrice = wineElement.goodsPrice ;
        NSInteger number = [goodsNumber integerValue];
        NSInteger price = [goodsPrice integerValue];
        totalPrice = number * price +totalPrice;
    }
    return [NSString stringWithFormat:@"%d",totalPrice];
}
#pragma mark 确认发布按钮
- (IBAction)confirmAction:(id)sender
{
    if ([[SharedUserDefault sharedInstance] isLogin])
    {
        [SVProgressHUD show];
        [HttpRequestComm sendRobOrder:dataDic withDelegate:self];
    }
    else
    {
        UserLoadViewController *loginController = [[UserLoadViewController alloc] init];
        loginController.loginTag = YES;
        [self.navigationController pushViewController:loginController animated:YES];
    }
}
#pragma mark HttpBaseRequestDelegate
- (void)httpRequestSuccessComm:(int)tagId withInParams:(id)inParam
{
    [SVProgressHUD dismiss];
    RobOrderResponse *robResponse = [[RobOrderResponse alloc] init];
    [robResponse setResultData:inParam];
    if(robResponse.code == 0)
    {
        [self showToast:robResponse.message];
        
        [self performSelector:@selector(orderCenterAction) withObject:nil afterDelay:0.5];
    }
    else
    {
        [self showToast:robResponse.message];
    }
}

- (void)httpRequestFailueComm:(int)tagId withInParams:(NSString *)error
{
    [SVProgressHUD dismiss];
    [self showToast:@"网络异常，请稍后重试"];
}

- (void)orderCenterAction
{
    OrderCenterViewController *orderCenterController = [[OrderCenterViewController alloc] init];
    orderCenterController.isFromConfirOrder = YES;
    [self.navigationController pushViewController:orderCenterController animated:YES];
}
#pragma mark =====================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
