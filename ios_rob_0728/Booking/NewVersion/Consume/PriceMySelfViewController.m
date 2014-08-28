//
//  PriceMySelfViewController.m
//  RobClientSecond
//
//  Created by 1 on 13-7-19.
//  Copyright (c) 2013年 cheyongzi. All rights reserved.
//

#import "PriceMySelfViewController.h"
#import "ContentViewStyleOne.h"
#import "ContentViewStyleSecond.h"
#import "ConstantField.h"
#import "SharedUserDefault.h"
#import "RobOrderResponse.h"
#import "AddDrinkViewController.h"
#import "MerchatSelectController.h"
#import "PriceConfirmViewController.h"
#import "NSString+CheckUserInfo.h"
#import "TimeSelecteView.h"
#import "Reachability.h"
#import "NewConfirmViewController.h"
#import "GuideView.h"

#define SCROLVIEW_TAG 1000
#define VIEW_TAG      2000

@interface PriceMySelfViewController ()<UITextFieldDelegate,TimeSelecteViewDelegate,MerchatSelectDelegate,AddDrinkDelegate>
{
    NSArray         *titleArray;
    NSMutableArray  *timeArray;
    //价格标签数组
    NSArray         *priceLabelArray;
    //不同价格x位置
    NSArray         *locationXArray;
    //消费价格数组
    NSArray         *priceArray;
    //不同时间默认选择的消费价格下标
    NSArray         *priceSelect;
    NSString        *priceString;
    //酒水优惠
    NSArray         *scaleArray;
    //视图数组，用于给视图加边框
    NSArray         *viewArray;
    //到店时间数组
    NSArray         *arriveTimeArray;
    //当前时间场次选择下标
    int             timeSelectIndex;
    //价格选择小标
    int             orignPriceSelectIndex;
    int             priceSelectIndex;
    UIView          *tempView;
    
    NSArray         *selectTimeArray;
    int             consumeStyle;
    
    NSMutableDictionary *paramDic;
    
    NSMutableArray  *wineArray;
    //输入框开始输入时的contentoffset
    float           contentOffsetY;
    
    BOOL            isFirst;
    
    UserElement     *userElement;
    
    NSString        *consumeTime;
    NSString        *arriveTime;
    NSString        *timeDuration;
    
    NSArray         *paramArray;
    
    GuideView       *guideView;
}
@end

@implementation PriceMySelfViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PRICEGUIDE"] == nil)
    {
        guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APPLICATION_HEIGHT) withTag:PRICE_GUIDE];
        [self.view addSubview:guideView];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppearanceAction:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppearanceAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHiddenAction:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCustomViewOne:) name:kReachabilityChangedNotification object:nil];
    
    if (!isFirst)
    {
        if (userElement!=nil) {
            if (userElement.mobile!=nil&&![userElement.mobile isEqualToString:@""])
            {
                self.mobileTextField.text = userElement.mobile;
            }
            if (userElement.contact!=nil&&![userElement.contact isEqualToString:@""])
            {
                self.nameTextField.text = userElement.contact;
            }
        }
        
        if ([[SharedUserDefault sharedInstance] getSystemParam]!=nil)
        {
            paramArray = [[SharedUserDefault sharedInstance] getSystemType:@"ShopType"];
        }
        if (paramArray!=nil&&[paramArray count]!=0)
        {
            for (ParamElement *param in paramArray)
            {
                if (self.shopType == [param.paramterId integerValue])
                {
                    if ([param.paramName isEqualToString:@"KTV"])
                    {
                        self.shopTypeImageView.image = [UIImage imageNamed:@"ktv"];
                    }
                    else if ([param.paramName isEqualToString:@"JB"])
                    {
                        self.shopTypeImageView.image = [UIImage imageNamed:@"bar_type"];
                    }
                    else if ([param.paramName isEqualToString:@"YC"])
                    {
                        self.shopTypeImageView.image = [UIImage imageNamed:@"midnight"];
                    }
                    break;
                }
            }
        }
        
        if(self.shopArray!=nil&&[self.shopArray count]>0)
        {
            self.shopLabel.hidden = YES;
            self.shopLabel1.hidden = NO;
            self.shopLabel2.hidden = NO;
            self.shopLabel3.hidden = NO;
            self.shopLabel2.text = [NSString stringWithFormat:@"%d",[[self shopArray] count]];
        }
        
        self.myVerticalScroll.frame = CGRectMake(0, 0, SCREEN_WIDTH, APPLICATION_HEIGHT-100);
        self.myVerticalScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 665);
        
        self.publishView.frame = CGRectMake(0, APPLICATION_HEIGHT-100, SCREEN_WIDTH, 56);
        
        priceSelectIndex = orignPriceSelectIndex;
        priceString = [(NSArray *)[priceArray objectAtIndex:timeSelectIndex] objectAtIndex:priceSelectIndex];
        
        [self initConsumePriceWithPriceArray:[priceArray objectAtIndex:timeSelectIndex] withSelectIndex:priceSelectIndex];
        
        [self initViewWithArray:viewArray];
        
        [self initEndTimeWithDate:[[NSDate alloc] initWithTimeIntervalSinceNow:45*60] withDay:@"今天" withTimeStr:nil];
        
        self.customScrollViewOne = [[CustomHorizontalScrollView alloc] initWithFrame:CGRectMake(10, 117, 300, 60)];
        self.customScrollViewOne.tag = SCROLVIEW_TAG + 1;
        self.customScrollViewOne.delegate = self;
        [self.myVerticalScroll addSubview:self.customScrollViewOne];
        [self.customScrollViewOne initContentInScrollView];
        
        self.customScrollViewSecond = [[CustomHorizontalScrollView alloc] initWithFrame:CGRectMake(10, 204, 300, 60)];
        self.customScrollViewSecond.tag = SCROLVIEW_TAG + 2;
        self.customScrollViewSecond.delegate = self;
        [self.myVerticalScroll addSubview:self.customScrollViewSecond];
        [self.customScrollViewSecond initContentInScrollView];
        
        [self.publishButton setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        //[self.publishButton setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateHighlighted];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(consumePriceBackImgTapAction:)];
        [self.consumePriceBackImg addGestureRecognizer:tapGesture];
        
        isFirst = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的定价";
    
    if (![ConUtils checkUserNetwork])
    {
        [self showToast:@"当前无可用网络"];
    }

    orignPriceSelectIndex = 2;
    
    arriveTime = @"12:00";
    timeDuration = @"6";
    
    userElement = [[SharedUserDefault sharedInstance] getUserInfo];
    if ([[SharedUserDefault sharedInstance] getCurrentAddress]==nil)
    {
        self.headerLabelOne.text = @"未获取到位置";
    }
    else
    {
        self.headerLabelOne.text = [[SharedUserDefault sharedInstance] getCurrentAddress];
    }
    NSDateFormatter *dateFor = [[NSDateFormatter alloc] init];
    [dateFor setDateFormat:@"MM月dd日"];
    self.headerLabelSecond.text = [NSString stringWithFormat:@"%@",[dateFor stringFromDate:[NSDate date]]];
    
    [self.priceStyleChangeBtn setBackgroundImage:[[UIImage imageNamed:@"consumeArrow"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];

    if ([[SharedUserDefault sharedInstance] getSystemParam]!=nil)
    {
        titleArray = [[SharedUserDefault sharedInstance] getSystemType:@"Volume"];
    }
    
    timeArray = [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithObjects:@"下午场",@"正晚场",@"晚晚场",@"自定义", nil],[NSMutableArray arrayWithObjects:@"12:00-18:00",@"18:00-00:00",@"00:00-06:00",@"", nil], nil];
    
    priceLabelArray = [NSArray arrayWithObjects:self.priceLabel1,self.priceLabel2,self.priceLabel3,self.priceLabel4, nil];
    
    arriveTimeArray = [NSArray arrayWithObjects:@"12:00",@"18:00",@"23:59", nil];
    
    priceArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil],[NSArray arrayWithObjects:@"29",@"69",@"149",@"299", nil],[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil],[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil], nil];
    priceSelect = [NSArray arrayWithObjects:@"2",@"3",@"2", nil];
    
    scaleArray = [NSArray arrayWithObjects:@"0.4",@"0.6",@"0.8",@"1", nil];
    
    locationXArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:75],[NSNumber numberWithInt:145],[NSNumber numberWithInt:205], nil];
    
    wineArray = [[NSMutableArray alloc] init];
    
    selectTimeArray = [NSArray arrayWithObjects:@"00:00",@"00:30",@"01:00",@"01:30",@"02:00",@"02:30",@"03:00",@"03:30",@"04:00",@"04:30",@"05:00",@"05:30",@"06:00",@"06:30",@"07:00",@"07:30",@"08:00",@"08:30",@"09:00",@"09:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00",@"14:30",@"15:00",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",@"18:30",@"19:00",@"19:30",@"20:00",@"20:30",@"21:00",@"21:30",@"22:00",@"22:30",@"23:00",@"23:30",nil];
    
    paramDic = [[NSMutableDictionary alloc] init];
    if (self.locationCoordinate.longitude!=0&&self.locationCoordinate.latitude!=0)
    {
        [paramDic setObject:[NSString stringWithFormat:@"%f",self.locationCoordinate.latitude] forKey:@"latitude"];
        [paramDic setObject:[NSString stringWithFormat:@"%f",self.locationCoordinate.longitude] forKey:@"longitude"];
    }
    [paramDic setObject:@"430100" forKey:@"city"];
    [paramDic setObject:@"2" forKey:@"robType"];
    if (titleArray!=nil&&[titleArray count]!=0) {
        [paramDic setObject:[[titleArray objectAtIndex:0] paramterId] forKey:@"volumeId"];
    }
    [paramDic setObject:@"0" forKey:@"consumInterval"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    [paramDic setObject:[formatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSinceNow:45*60]] forKey:@"endTime"];
    [paramDic setObject:[[SharedUserDefault sharedInstance] getCurrentAddress]==nil?@"":[[SharedUserDefault sharedInstance] getCurrentAddress] forKey:@"address"];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"yyyyMMdd"];
    [paramDic setObject:[formatter2 stringFromDate:[NSDate date]] forKey:@"consumDate"];
    [paramDic setObject:[[priceArray objectAtIndex:0] objectAtIndex:3] forKey:@"offerPrice"];
    [paramDic setObject:[NSString stringWithFormat:@"%d",self.shopType] forKey:@"shopType"];
    
    viewArray = [NSArray arrayWithObjects:self.ktvSelectView,self.wineAddView,self.publishView,self.consumePriceView,self.endTimeView,self.personInfoView,self.messageView,nil];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)publishButtonAction:(id)sender
{
    if ([self checkUserInputInfo]) {
        NewConfirmViewController *controller = [[NewConfirmViewController alloc] initWithInfo:paramDic];
        controller.wineArray = wineArray;
        controller.shopCount = [self.shopArray count];
        controller.consumeTime = consumeTime!=nil?consumeTime:@"";
        [self.navigationController pushViewController:controller animated:YES];
    }
//    if ([self checkUserInputInfo])
//    {
//        PriceConfirmViewController *confirmController = [[PriceConfirmViewController alloc] initWithInfo:paramDic];
//        confirmController.wineArray = wineArray;
//        confirmController.shopArray = self.shopArray;
//        confirmController.basePrice = [[[priceArray objectAtIndex:timeSelectIndex] objectAtIndex:priceSelectIndex] integerValue];
//        confirmController.scale     = [[scaleArray objectAtIndex:priceSelectIndex] floatValue];
//        confirmController.consumeTime = consumeTime!=nil?consumeTime:@"";
//        confirmController.shopType = self.shopType;
//        [self.navigationController pushViewController:confirmController animated:YES];
//    }
}

#pragma mark 检查用户输入信息
- (BOOL)checkUserInputInfo
{
    if (self.priceStyleOne.isHidden)
    {
        if (self.consumePriceTextField.text==nil||[self.consumePriceTextField.text isEqualToString:@""])
        {
            [self showToast:@"请输入定价"];
            return NO;
        }
        else
        {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[1-9][0-9]*$" options:0 error:nil];
            if (regex) {
                NSTextCheckingResult *result = [regex firstMatchInString:self.consumePriceTextField.text options:0 range:NSMakeRange(0, [self.consumePriceTextField.text length])];
                if (result)
                {
                    [paramDic setObject:[self.consumePriceTextField text] forKey:@"offerPrice"];
                }
                else
                {
                    [self showToast:@"请输入正确的消费价格"];
                    return NO;
                }
            }
            //[paramDic setObject:[self.consumePriceTextField text] forKey:@"offerPrice"];
        }
    }
    else
    {
        if (priceString!=nil&&![priceString isEqualToString:@""])
        {
            [paramDic setObject:priceString forKey:@"offerPrice"];
        }
    }
    if ([self.mobileTextField text]==nil||[[self.mobileTextField text] isEqualToString:@""])
    {
        [self.mobileTextField becomeFirstResponder];
        [self showToast:@"请输入手机号"];
        return NO;
    }
    else
    {
        if (![self.mobileTextField.text checkUserPhoneNumber])
        {
            [self showToast:@"请输入正确的手机号"];
            return NO;
        }
        [paramDic setObject:self.mobileTextField.text forKey:@"mobile"];
    }
    
    if (self.nameTextField.text!=nil&&![self.nameTextField.text isEqualToString:@""])
    {
        [paramDic setObject:self.nameTextField.text forKey:@"contract"];
    }
    else
    {
        if (userElement.name!=nil&&![userElement.name isEqualToString:@""])
        {
            [paramDic setObject:userElement.name forKey:@"contract"];
        }
    }
    
    if (self.messageTextView.text!=nil&&
        ![self.messageTextView.text isEqualToString:@""]
        &&![self.messageTextView.text isEqualToString:@"捎给商家的话,字数50字以内"])
    {
        [paramDic setObject:self.messageTextView.text forKey:@"brief"];
    }
    if ([wineArray count]!=0)
    {
        [paramDic setObject:[self convertWineElement] forKey:@"goods"];
    }
    if ([self.shopArray count]!=0)
    {
        [paramDic setObject:[self getSelectId] forKey:@"appointShopId"];
    }
    if (arriveTime!=nil&&![arriveTime isEqualToString:@""])
    {
        [paramDic setObject:arriveTime forKey:@"arriveTime"];
    }
    if (timeDuration!=nil&&![timeDuration isEqualToString:@""])
    {
        [paramDic setObject:timeDuration forKey:@"consumDuration"];
    }
    return YES;
}
#pragma mark 添加酒水内容的转换
-(NSString *) convertWineElement {
    NSString *drinkParam = @"";
    for (WineElement *element in wineArray)
    {
        drinkParam = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@;%@",element.goodsId,element.goodsName,element.goodsNumber,element.unit,element.goodsPrice,element.goodsImg,drinkParam];
    }
    return drinkParam ;
}
#pragma mark =======
- (void)initViewWithArray:(NSArray *)array
{
    for (UIView *view in array)
    {
        view.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
        view.layer.borderWidth = 1;
    }
    
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.ktvSelectView addGestureRecognizer:gesture1];
    
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.wineAddView addGestureRecognizer:gesture2];
    
    UITapGestureRecognizer *gesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.endTimeView addGestureRecognizer:gesture3];
}
#pragma mark 更新消费价格
- (void)initConsumePriceWithPriceArray:(NSArray *)array
                       withSelectIndex:(int)priceIndex
{
    [(UILabel *)[priceLabelArray objectAtIndex:priceSelectIndex] setTextColor:[UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1]];
    [(UILabel *)[priceLabelArray objectAtIndex:priceSelectIndex] setFont:[UIFont systemFontOfSize:15]];
    priceSelectIndex = priceIndex;
    for (int i=0;i<[priceLabelArray count];i++)
    {
        [(UILabel *)[priceLabelArray objectAtIndex:i] setText:[NSString stringWithFormat:@"%d元",[[array objectAtIndex:i] intValue]]];
        if (i == priceIndex)
        {
            [(UILabel *)[priceLabelArray objectAtIndex:priceIndex] setTextColor:[UIColor colorWithRed:234.0f/255 green:82.0f/255 blue:128.0f/255 alpha:1]];
            [(UILabel *)[priceLabelArray objectAtIndex:priceIndex] setFont:[UIFont boldSystemFontOfSize:16]];
            priceString = [array objectAtIndex:priceIndex];
            self.consumePriceSelImg.frame = CGRectMake([[locationXArray objectAtIndex:priceIndex] integerValue], self.consumePriceSelImg.frame.origin.y, self.consumePriceSelImg.frame.size.width, self.consumePriceSelImg.frame.size.height);
        }
    }
}
#pragma mark 初始化消费时间的方法
- (void)initEndTimeWithDate:(NSDate *)date withDay:(NSString *)dayStr withTimeStr:(NSString *)timeStr
{
    NSDateFormatter *formate1 = [[NSDateFormatter alloc] init];
    [formate1 setDateFormat:@"MM月dd日"];
    NSString *dateStr = [formate1 stringFromDate:date];
    NSString *timeString = nil;
    if (timeStr==nil||[timeStr isEqualToString:@""]) {
        NSDateFormatter *formate2 = [[NSDateFormatter alloc] init];
        [formate2 setDateFormat:@"HH:mm"];
        timeString = [formate2 stringFromDate:date];
    }
    else
    {
        timeString = timeStr;
    }
    self.daySelLabel.text = dayStr;
    self.dateSelLabel.text = dateStr;
    self.timeSelLabel.text = timeString;
}

//消费定价背景图片点击
- (void)consumePriceBackImgTapAction:(UITapGestureRecognizer *)gesture
{
    float xPosition = [gesture locationInView:gesture.view].x;
    for (int i=0;i<[locationXArray count];i++)
    {
        int position = [[locationXArray objectAtIndex:i] integerValue];
        if (xPosition<position+30&&xPosition>position-30)
        {
            [UIView animateWithDuration:0.5 animations:^(void){
                [(UILabel *)[priceLabelArray objectAtIndex:priceSelectIndex] setTextColor:[UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1]];
                [(UILabel *)[priceLabelArray objectAtIndex:priceSelectIndex] setFont:[UIFont systemFontOfSize:15]];
                priceSelectIndex = i;
                [(UILabel *)[priceLabelArray objectAtIndex:priceSelectIndex] setTextColor:[UIColor colorWithRed:234.0f/255 green:82.0f/255 blue:128.0f/255 alpha:1]];
                [(UILabel *)[priceLabelArray objectAtIndex:priceSelectIndex] setFont:[UIFont boldSystemFontOfSize:16]];
                self.consumePriceSelImg.frame = CGRectMake(position, self.consumePriceSelImg.frame.origin.y, self.consumePriceSelImg.frame.size.width, self.consumePriceSelImg.frame.size.height);
            }];
            priceString = [(UILabel *)[priceLabelArray objectAtIndex:priceSelectIndex] text];
            priceString = [priceString substringToIndex:[priceString length]-1];
            break;
        }
    }
}

#pragma mark CustomHorizontalScrollDelegate
- (NSInteger)numberOfViewsWithScrollView:(CustomHorizontalScrollView *)scrollView
{
    switch (scrollView.tag - SCROLVIEW_TAG) {
        case 1:
            return [titleArray count];
            break;
        case 2:
            return [(NSMutableArray *)[timeArray objectAtIndex:0] count];
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
            view = [[ContentViewStyleOne alloc] initWithFrame:CGRectMake(0, 0, 86, 40) withTitle:[[titleArray objectAtIndex:index] paramName] withImage:@"scrollerContentBg.png"];
            break;
        case 2:
            view = [[ContentViewStyleSecond alloc] initWithFrame:CGRectMake(0, 0, 86, 40) withTitle:[[timeArray objectAtIndex:0] objectAtIndex:index] withSecondTitle:[[timeArray objectAtIndex:1] objectAtIndex:index] withImage:@"scrollerContentBg.png"];
            break;
        default:
            break;
    }
    return view;
}

- (void)scrollView:(CustomHorizontalScrollView *)scrollView clickedAtIndex:(int)index
{
    switch (scrollView.tag - SCROLVIEW_TAG) {
        case 1:
            [paramDic setObject:[[titleArray objectAtIndex:index] paramterId] forKey:@"volumeId"];
            switch (index) {
                case 0:
                    priceArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil],[NSArray arrayWithObjects:@"29",@"69",@"149",@"299", nil],[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil],[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil], nil];
                    break;
                case 1:
                    priceArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"29",@"59",@"119",@"239", nil],[NSArray arrayWithObjects:@"39",@"79",@"169",@"329", nil],[NSArray arrayWithObjects:@"29",@"59",@"119",@"239", nil],[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil], nil];
                    break;
                case 2:
                    priceArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"29",@"79",@"149",@"299", nil],[NSArray arrayWithObjects:@"49",@"109",@"229",@"449", nil],[NSArray arrayWithObjects:@"29",@"79",@"149",@"299", nil],[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil], nil];
                    break;
                case 3:
                    priceArray = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"39",@"99",@"199",@"399", nil],[NSArray arrayWithObjects:@"59",@"139",@"299",@"599", nil],[NSArray arrayWithObjects:@"39",@"99",@"199",@"399", nil],[NSArray arrayWithObjects:@"19",@"49",@"99",@"199", nil], nil];
                    break;
                default:
                    break;
            }
            [self initConsumePriceWithPriceArray:[priceArray objectAtIndex:timeSelectIndex] withSelectIndex:orignPriceSelectIndex];
            break;
        case 2:
            if (timeSelectIndex != index)
            {
                timeSelectIndex = index;
                //priceSelectIndex = [[priceSelect objectAtIndex:timeSelectIndex] integerValue];
                if ([wineArray count]>0) {
                    NSMutableArray *mulArray = [[priceArray objectAtIndex:timeSelectIndex] mutableCopy];
                    for (int i=0; i<[mulArray count]; i++)
                    {
                        int price = [[mulArray objectAtIndex:i] integerValue]+([[self getAddDrinkTotalPrice] integerValue]*[[scaleArray objectAtIndex:i] floatValue]);
                        [mulArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",price]];
                    }
                    [self initConsumePriceWithPriceArray:mulArray withSelectIndex:orignPriceSelectIndex];
                }
                else
                {
                    [self initConsumePriceWithPriceArray:[priceArray objectAtIndex:timeSelectIndex] withSelectIndex:orignPriceSelectIndex];
                }
                if (index!=3)
                {
                    arriveTime = [arriveTimeArray objectAtIndex:index];
                    timeDuration = @"6";
                }
                
                [paramDic setObject:[NSNumber numberWithInt:index] forKey:@"consumInterval"];
            }
            if (index == [(NSMutableArray *)[timeArray objectAtIndex:0] count]-1) {
                TimeSelecteView *selectView = [[[NSBundle mainBundle] loadNibNamed:@"TimeSelecteView" owner:self options:nil] objectAtIndex:0];
                selectView.delegate = self ;
                [selectView initData];
                [self.view addSubview:selectView];
            }
            break;
        default:
            break;
    }
}

#pragma mark UIKeyboardWillShow/HiddenNotification
- (void)keyboardWillAppearanceAction:(NSNotification *)notification
{
    if (contentOffsetY==0) {
        contentOffsetY = self.myVerticalScroll.contentOffset.y;
    }
}

-(void)keyboardAppearanceAction:(NSNotification *)notification
{
    NSDictionary *dicInfo = [notification userInfo];
    CGSize keyboardSize = [[dicInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.myVerticalScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 665+keyboardSize.height);
    self.myVerticalScroll.contentOffset = CGPointMake(0, tempView.frame.origin.y+tempView.frame.size.height+40-keyboardSize.height);
}

-(void)keyboardHiddenAction:(NSNotification *)notification
{
    self.myVerticalScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 665);
    self.myVerticalScroll.contentOffset = CGPointMake(0, contentOffsetY);
    contentOffsetY = 0;
}
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    tempView = [textField superview];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    tempView = nil;
}
#pragma mark 酒水添加通知
#pragma mark AddDrinkDelegate
- (void)addDrink:(NSArray *)array
{
    wineArray = [array mutableCopy];
    if([wineArray count]>0){
        self.winLabel.text = @"酒水参考价：";
        self.winLabel.textColor = [UIColor blackColor];
        self.winePriceLabel.hidden = NO;
        self.winePriceLabel.text = [NSString stringWithFormat:@"%@元",[self getAddDrinkTotalPrice]];
        
        NSMutableArray *mulArray = [[priceArray objectAtIndex:timeSelectIndex] mutableCopy];
        for (int i=0; i<[mulArray count]; i++)
        {
            int price = [[mulArray objectAtIndex:i] integerValue]+((int)([[self getAddDrinkTotalPrice] integerValue]*[[scaleArray objectAtIndex:i] floatValue]))/10*10;
            [mulArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",price]];
        }
        [self initConsumePriceWithPriceArray:mulArray withSelectIndex:priceSelectIndex];
    }
    else
    {
        self.winLabel.text = @"添加酒水/小吃";
        self.winePriceLabel.hidden = YES;
        self.winLabel.textColor = [UIColor lightGrayColor];
        [self initConsumePriceWithPriceArray:[priceArray objectAtIndex:timeSelectIndex] withSelectIndex:priceSelectIndex];
    }
}

/*
 * 酒水总价的计算方法
 */
-(NSString *) getAddDrinkTotalPrice {
    NSInteger totalPrice = 0;
    for (WineElement *wineElement in wineArray) {
        NSString *goodsNumber = wineElement.goodsNumber ;
        NSString *goodsPrice = wineElement.goodsPrice ;
        NSInteger number = [goodsNumber integerValue];
        NSInteger price = [goodsPrice integerValue];
        totalPrice = number * price +totalPrice;
    }
    return [NSString stringWithFormat:@"%d",totalPrice];
}
#pragma mark 商家添加
#pragma mark MerchatSelectDelegate
- (void)shopShelect:(NSArray *)array
{
    self.shopArray = [array mutableCopy] ;
    if([self.shopArray count]>0){
        self.shopLabel.hidden = YES;
        self.shopLabel1.hidden = NO;
        self.shopLabel2.hidden = NO;
        self.shopLabel3.hidden = NO;
        self.shopLabel2.text = [NSString stringWithFormat:@"%d",[[self shopArray] count]];
    }
    else
    {
        self.shopLabel.hidden = NO;
        self.shopLabel1.hidden = YES;
        self.shopLabel2.hidden = YES;
        self.shopLabel3.hidden = YES;
    }
}
/*
 * 商家被选中的数据拼装方法
 */
-(NSString *) getSelectId
{
    NSString *selecteInfo = @"";
    for (ProviderElement *element in self.shopArray) {
        selecteInfo = [NSString stringWithFormat:@"%@%@",selecteInfo,element.shopId];
        if ([self.shopArray indexOfObject:element]!=[self.shopArray count]-1)
        {
            selecteInfo = [NSString stringWithFormat:@"%@,",selecteInfo];
        }
    }
    return selecteInfo ;
}
#pragma mark UITapGestureRecognizer
- (void)tapGestureAction:(UITapGestureRecognizer *)gesture
{
    switch (gesture.view.tag - VIEW_TAG) {
        case 1:
        {
            MerchatSelectController *merchatCon = [[MerchatSelectController alloc] init];
            merchatCon.delegate = self;
            merchatCon.shopsName = @"";
            merchatCon.selProAry = [self.shopArray mutableCopy];
            merchatCon.shopType  = [NSString stringWithFormat:@"%d",self.shopType];
            [self.navigationController pushViewController:merchatCon animated:YES];
        }
            break;
        case 2:
        {
            AddDrinkViewController *addController = [[AddDrinkViewController alloc] init];
            addController.delegate = self;
            addController.addWineAry = [wineArray mutableCopy];
            [self.navigationController pushViewController:addController animated:YES];
        }
            break;
        case 3:
        {
            [self.view endEditing:YES];
            int index = [self.timeSelLabel.text rangeOfString:@":"].location;
            int hour = [[self.timeSelLabel.text substringToIndex:index] integerValue];
            int minute = [[self.timeSelLabel.text substringFromIndex:index+1] integerValue];
            int selectIndex = minute > 30 ? hour*2+1 : hour*2;
            CGSize appSize = [UIScreen mainScreen].applicationFrame.size;
            SelectUnitView *unitView = [[SelectUnitView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, appSize.height) withParamArrOne:[NSArray arrayWithObjects:@"今天",@"明天", nil] withParamArrTwo:selectTimeArray withTitle:@"截止时间" withTableOneSelect:0 withTableSecondSelect:selectIndex];
            unitView.delegate = self;
            [self.view addSubview:unitView];
        }
            break;
        default:
            break;
    }
}

#pragma mark SelectUnitDelegate
- (void)selectFirstTable:(NSString *)firstStr secondeTable:(NSString *)secondStr
{
    if (firstStr!=nil&&secondStr!=nil)
    {
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"yyyyMMdd"];
        NSString *endTimeStr;
        if ([firstStr isEqualToString:@"明天"])
        {
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
            endTimeStr = [NSString stringWithFormat:@"%@%@%@",[formatter1 stringFromDate:date],[secondStr substringToIndex:2],[secondStr substringFromIndex:3]];
            [self initEndTimeWithDate:date withDay:@"明天" withTimeStr:secondStr];
            [paramDic setObject:endTimeStr forKey:@"endTime"];
        }
        else
        {
            endTimeStr = [NSString  stringWithFormat:@"%@%@%@",[formatter1 stringFromDate:[NSDate date]],[secondStr substringToIndex:2],[secondStr substringFromIndex:3]];
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            [formatter2 setDateFormat:@"yyyyMMddHHmm"];
            NSDate *selectedDate = [formatter2 dateFromString:endTimeStr];
            if ([selectedDate compare:[NSDate date]] == NSOrderedAscending)
            {
                [self showToast:@"选择日期时间无效"];
            }
            else
            {
                [self initEndTimeWithDate:[NSDate date] withDay:@"今天" withTimeStr:secondStr];
                [paramDic setObject:endTimeStr forKey:@"endTime"];
            }
        }
    }
}
#pragma mark 消费定价样式切换
- (IBAction)changeConsumePriceStyle:(id)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        self.consumePriceView.layer.transform = CATransform3DMakeRotation(-M_PI/2, 1.0, 0, 0);
    } completion:^(BOOL finished) {
        [self animationAction];
    }];
}
- (void)animationAction
{
    self.priceStyleOne.hidden = !self.priceStyleOne.isHidden;
    if (self.priceStyleOne.isHidden)
    {
        [self.priceStyleChangeBtn setTitle:@"参考价" forState:UIControlStateNormal];
    }
    else
    {
        [self.priceStyleChangeBtn setTitle:@"自定义" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.consumePriceView.layer.transform = CATransform3DMakeRotation(0, 1.0, 0, 0);
    } completion:^(BOOL finished) {
        self.consumePriceView.layer.transform = CATransform3DIdentity;
        consumeStyle = consumeStyle==1?0:1;
    }];
}

#pragma mark TimeSelectDelegate
-(void) timeSelecteViewTime:(NSString *) time AndLong:(NSString *) timeLong
{
    consumeTime = [ConUtils getHHmmAddTime:time AndTimeLong:timeLong];
    [(NSMutableArray *)[timeArray objectAtIndex:1] replaceObjectAtIndex:3 withObject:consumeTime];
    [self.customScrollViewSecond reloadData];
    arriveTime = time;
    timeDuration = timeLong;
}

-(void) timeSelecteViewCancel
{
    
}

#pragma mark 网络变化的通知

- (void)refreshCustomViewOne:(NSNotification *)notification
{
    if ([[SharedUserDefault sharedInstance] getSystemParam]==nil)
    {
        if ([ConUtils checkUserNetwork])
        {
            [HttpRequestComm getCommonparamsList:self];
        }
    }
}

#pragma mark -HttpRequestCommDelegate
-(void) httpRequestSuccessComm:(int)tagId withInParams:(id)inParam
{
    [[SharedUserDefault sharedInstance] saveSysetmParam:inParam];
    titleArray = [[SharedUserDefault sharedInstance] getSystemType:@"Volume"];
    [self.customScrollViewOne reloadData];
}

-(void) httpRequestFailueComm:(int)tagId withInParams:(NSString *)error
{
    [self showToast:@"获取系统参数失败"];
}

#pragma mark =========================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    NSString *temp = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (temp.length > 50) {
        textView.text = [temp substringToIndex:50];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"捎给商家的话,字数50字以内"])
    {
        textView.text = @"";
    }
    textView.textColor = [UIColor blackColor];
    tempView = [textView superview];
}

@end
