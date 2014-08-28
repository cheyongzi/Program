//
//  NewConfirmViewController.m
//  Booking
//
//  Created by 1 on 14-8-11.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "NewConfirmViewController.h"
#import "ConstantField.h"
#import "ParamElement.h"
#import "SharedUserDefault.h"
#import "UserLoadViewController.h"
#import "OrderCenterViewController.h"
#import "RobOrderResponse.h"

@interface NewConfirmViewController ()
{
    NSMutableDictionary *dataDic;
    UIImageView *picImg;
    UILabel     *nameLabel;
    UILabel     *countLabel;
}
@end

@implementation NewConfirmViewController

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
    
    if ([self.wineArray count]>0) {
        self.myTableView.hidden = NO;
        
        CGPoint wineLabelPoint = self.wineLabel.frame.origin;
        CGSize  wineLabelSize  = self.wineLabel.frame.size;
        
        UIImageView *seperateLine = [[UIImageView alloc] initWithFrame:CGRectMake(10, wineLabelPoint.y+wineLabelSize.height, 300, 1)];
        seperateLine.image = [UIImage imageNamed:@"seperateLineDot.png"];
        [self.myScrollView addSubview:seperateLine];
        
        self.myTableView.frame = CGRectMake(15, wineLabelPoint.y+wineLabelSize.height, 290, 70*[self.wineArray count]);
        self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.confirmBackImg.frame = CGRectMake(10, 10, 300, wineLabelPoint.y+wineLabelSize.height+self.myTableView.frame.size.height);
    }
    
    self.myScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, APPLICATION_HEIGHT-100);
    self.myScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.confirmBackImg.frame.size.height+20);
    
    self.confirmView.frame = CGRectMake(0, APPLICATION_HEIGHT-100, SCREEN_WIDTH, 56);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认发布";
    
    self.confirmBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, APPLICATION_HEIGHT-120)];
    self.confirmBackImg.image = [[UIImage imageNamed:@"confirmBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(70, 30, 10, 50)];
    [self.myScrollView insertSubview:self.confirmBackImg belowSubview:self.addressLabel];
    
    self.confirmView.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
    self.confirmView.layer.borderWidth = 1;
    [self.confirmButton setBackgroundImage:[[UIImage imageNamed:@"bottomBtnBack.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
    
    [self initUserInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUserInfo
{
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",[dataDic objectForKey:@"offerPrice"]];
    
    self.addressLabel.text = [dataDic objectForKey:@"address"];
    
    for (ParamElement *element in [[SharedUserDefault sharedInstance] getSystemType:@"Volume"])
    {
        if ([[dataDic objectForKey:@"volumeId"] isEqualToString:[element paramterId]])
        {
            self.peopleCountLabel.text = [NSString stringWithFormat:@"%@",element.paramName];
            break;
        }
    }
    
    NSArray *timeArr = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@"下午场",@"正晚场",@"晚晚场", @"自定义",nil],[NSArray arrayWithObjects:@"12:00-18:00",@"18:00-00:00",@"00:00-06:00",self.consumeTime, nil], nil];
    NSString *str1 = [[timeArr objectAtIndex:0] objectAtIndex:[[dataDic objectForKey:@"consumInterval"] integerValue]];
    NSString *str2 = [[timeArr objectAtIndex:1] objectAtIndex:[[dataDic objectForKey:@"consumInterval"] integerValue]];
    self.timeLabel.text = str1;
    self.timeIntervalLabel.text = [NSString stringWithFormat:@"(%@)",str2];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyyMMddHHmm";
    NSString *endTime = [ConUtils getyyyMMddHHmmSpaceTime:[formater dateFromString:[dataDic objectForKey:@"endTime"]]];
    NSString *reduceTime = [ConUtils getReduceTime:endTime];
    NSArray *reduceAry = [reduceTime componentsSeparatedByString:@","];
    self.consumeTimeLabel.text = [NSString stringWithFormat:@"剩余%@小时%@分",[reduceAry objectAtIndex:0],[reduceAry objectAtIndex:1]];
    
    if (self.shopCount>0)
    {
        self.shopCountLabel.text = [NSString stringWithFormat:@"已指定%d个商家",self.shopCount];
    }
    
    if ([self.wineArray count]>0)
    {
        self.wineLabel.text = [NSString stringWithFormat:@"我需要的酒水/小吃(%d)",[self.wineArray count]];
    }
}

#pragma mark UITableViewDeleate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.wineArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ConfirmCell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ConfirmCell"];
        
        picImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        [cell addSubview:picImg];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:14];
        [cell addSubview:nameLabel];
        
        countLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, 200, 30)];
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.font = [UIFont systemFontOfSize:14];
        
        UILabel *seperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 69, 290, 1)];
        [seperateLine setBackgroundColor:LOAD_SEPERATE_COLOR];
        [cell addSubview:seperateLine];
        
        [cell addSubview:countLabel];
    }
    WineElement *element = [self.wineArray objectAtIndex:[indexPath row]];
    [ConUtils checkFileWithURLString:element.goodsImg withImageView:picImg withDirector:@"Wine" withDefaultImage:@"con_wear.png"];
    nameLabel.text = element.goodsName;
    countLabel.text = [NSString stringWithFormat:@"%@%@ %@元",element.goodsNumber,element.unit,element.goodsPrice];
    return cell;
}

- (IBAction)confirmButtonAction:(id)sender {
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
        
        [self performSelector:@selector(orderCenterAction) withObject:nil afterDelay:0.3];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)popViewController
{
    [SVProgressHUD dismiss];
    [super popViewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
