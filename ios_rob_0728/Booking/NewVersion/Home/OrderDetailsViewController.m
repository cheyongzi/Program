//
//  OrderDetailsViewController.m
//  Booking
//
//  Created by jinchenxin on 14-7-10.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

enum ORDERSELECTED {
    WAITSUBMIT,
    WAITCONSUME,
    WAITCOMMENT,
    WAITCOMMENTED,
    WAITHISTORY,
};


#import "OrderDetailsViewController.h"
#import "OrderSubmitCell.h"
#import "DrinkViewController.h"
#import "ConfirmResponse.h"
#import "ConsumePayController.h"
#import "RountViewController.h"
#import "EvaluateElement.h"
#import "SharedUserDefault.h"

@interface OrderDetailsViewController ()<UIAlertViewDelegate>
{
    ConfirmResponse *conResponse;
    NSString        *shopName;
    NSString        *typeId;
    NSString        *roomType;
}
@end

@implementation OrderDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nextBtn.layer.cornerRadius = 5 ;
    
    self.wineAry = [[NSMutableArray alloc] init];
    self.acAry = [[NSMutableArray alloc] init];
    switch (self.currentPosition) {
        case WAITSUBMIT:{
            self.headView = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailsHeadView" owner:self options:nil]objectAtIndex:0];
            [self.headView setHeadCellData:self.reElement];
            [self.headView.drinkBtn addTarget:self action:@selector(returnToDrink:) forControlEvents:UIControlEventTouchUpInside];
            self.tableView.tableHeaderView = self.headView ;
            if ([ConUtils checkUserNetwork]) {
                [HttpRequestComm findOrderDetail:self.reElement.requiredId atIndex:@"1" withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
            break;
        case WAITCONSUME:{
            self.consumeView = [[[NSBundle mainBundle] loadNibNamed:@"OrderConsumeHeadView" owner:self options:nil] objectAtIndex:0];
            [self.consumeView setHeadCellData:self.reElement];
            [self.consumeView.drinkBtn addTarget:self action:@selector(returnToDrink:) forControlEvents:UIControlEventTouchUpInside];
            self.tableView.tableHeaderView = self.consumeView ;
            if ([ConUtils checkUserNetwork]) {
                [HttpRequestComm findOrderDetail:self.reElement.requiredId atIndex:@"1" withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
            break;
        case WAITCOMMENT:{
            self.commView = [[[NSBundle mainBundle] loadNibNamed:@"OrderCommentView" owner:self options:nil] objectAtIndex:0];
            self.tableView.tableHeaderView = self.commView ;
            self.bottomView.hidden = NO ;
            [self.nextBtn addTarget:self action:@selector(submitComment:) forControlEvents:UIControlEventTouchUpInside];
            [self.commView setHeadCellData:self.reElement];
            self.tableView.scrollEnabled = NO ;
        }
            break;
            
        case WAITCOMMENTED:{
            self.commView = [[[NSBundle mainBundle] loadNibNamed:@"OrderCommentView" owner:self options:nil] objectAtIndex:0];
            self.tableView.tableHeaderView = self.commView ;
            self.bottomView.hidden = YES ;
            [self.commView setHeadCellData:self.reElement];
            self.commView.commentView.hidden = YES;
            self.commView.setRatingView.hidden = YES;
            self.commView.enStarRating.hidden = YES;
            self.commView.seStarRating.hidden = YES;
            self.tableView.scrollEnabled = NO ;
            
            if ([ConUtils checkUserNetwork]) {
                NSMutableDictionary *mulDic = [[NSMutableDictionary alloc] init];
                [mulDic setObject:self.reElement.robId forKey:@"orderId"];
                [HttpRequestComm queryEvaluate:mulDic withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
            break;
        case WAITHISTORY:{
            self.headView = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailsHeadView" owner:self options:nil]objectAtIndex:0];
            [self.headView setHeadCellData:self.reElement];
            [self.headView.drinkBtn addTarget:self action:@selector(returnToDrink:) forControlEvents:UIControlEventTouchUpInside];
            self.headView.tagImg.image = [UIImage imageNamed:@"m_order_old"];
            self.tableView.tableHeaderView = self.headView ;
            if ([ConUtils checkUserNetwork]) {
                [HttpRequestComm findOrderDetail:self.reElement.requiredId atIndex:@"1" withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
            break;
    }
}

/*
 * 评论内容的事件响应方法
 */
-(void) submitComment:(id) sender {
    NSMutableArray *comAry = [self.commView getCommentInfo];
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setObject:self.reElement.robId forKey:@"orderId"];
    [paramDic setObject:[comAry objectAtIndex:0] forKey:@"environment"];
    [paramDic setObject:[comAry objectAtIndex:1] forKey:@"serviceScore"];
    [paramDic setObject:[comAry objectAtIndex:2] forKey:@"deviceScore"];
    [paramDic setObject:[comAry objectAtIndex:3] forKey:@"content"];
    if ([ConUtils checkUserNetwork]) {
        [HttpRequestComm submitCommentInfo:paramDic withDelegate:self];
    }
    else
    {
        [self showToast:@"网络异常，请稍后重试"];
    }
}


//侍确定详情酒水视图的跳转
-(void) returnToDrink:(id) sender {
    UIButton *btn = (UIButton *)sender ;
    NSInteger tagValue = btn.tag ;
    if(tagValue < 100){
        DrinkViewController *addCon = [[DrinkViewController alloc] init];
        addCon.drinkAry = self.reElement.winAry ;
        [self.navigationController pushViewController:addCon animated:YES];
    }else{
        DrinkViewController *addCon = [[DrinkViewController alloc] init];
        AcceptOrderElement *acElement = [self.acAry objectAtIndex:tagValue-100];
        addCon.drinkAry = acElement.winAry ;
        [self.navigationController pushViewController:addCon animated:YES];
    } 
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //if(self.currentPosition == WAITCOMMENT||self.currentPosition == WAITCOMMENTED) return 0 ;
    return [self.acAry count]>0?[self.acAry count]:0 ;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135 ;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderSubmitCell *cell = nil ;
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderSubmitCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.currentPosition==1||self.currentPosition==2||self.currentPosition==3) {
            cell.isCostCell = YES;
        }
        AcceptOrderElement *element = [self.acAry objectAtIndex:indexPath.row];
        [cell setSubmitCellData:element];
        if (element.phoneNumber!=nil&&![element.phoneNumber isEqualToString:@""])
        {
            [cell.phoneButton setTitle:element.phoneNumber forState:UIControlStateNormal];
        }
        else
        {
            if (element.mobileNumber!=nil&&![element.mobileNumber isEqualToString:@""])
            {
                [cell.phoneButton setTitle:element.mobileNumber forState:UIControlStateNormal];
            }
            else
            {
                cell.phoneButton.hidden = YES;
            }
        }
        switch (self.currentPosition) {
            case WAITSUBMIT:{
                if (cell.comHisBtn.hidden) {
                    cell.submitBtn.hidden = NO ;
                    cell.submitBtn.tag = indexPath.row + 200 ;
                    [cell.submitBtn addTarget:self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
                }
            }
                break;
                
            case WAITCONSUME:
                break;
            case WAITCOMMENT:
                break;
            case WAITHISTORY:
                break;
        }
        
        cell.verityCodeLa.text = self.reElement.verifyCode ;
        cell.drinkBtn.tag = indexPath.row + 100 ;
        [cell.drinkBtn addTarget:self action:@selector(returnToDrink:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.mapButton.tag = 600 +indexPath.row ;
        [cell.mapButton addTarget:self action:@selector(returnToRount:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

-(void) returnToRount:(id) sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger row = btn.tag - 600;
    AcceptOrderElement *element = [self.acAry objectAtIndex:row];
    RountViewController *rountCon = [[RountViewController alloc] init];
    rountCon.lautitude = element.latitude ;
    rountCon.longitude = element.longitude ;
    [self.navigationController pushViewController:rountCon animated:YES];
}

/*
 * 确认商家响应订单的方法
 */
-(void) submitOrder:(id) sender {
    UIButton *btn = (UIButton *)sender ;
    NSInteger row = btn.tag - 200 ;
    AcceptOrderElement *element = [self.acAry objectAtIndex:row];
    NSString *robId = self.reElement.requiredId ;
    NSString *shopId = [NSString stringWithFormat:@"%@",element.shopsId] ;
    shopName = element.shopName;
    typeId   = element.typeId;
    roomType = [[SharedUserDefault sharedInstance] getSystemNameType:@"RoomType" andTypeKey:element.typeId];
    self.price = self.reElement.offerPrice ;
    if ([ConUtils checkUserNetwork]) {
        [HttpRequestComm confirmOrder:robId andShopId:shopId withDelegate:self];
    }
    else
    {
        [self showToast:@"网络异常，请稍后重试"];
    }
}

#pragma mark- HttpRequestCommDelegate
-(void)httpRequestSuccessComm:(int)tagId withInParams:(id)inParam
{
    switch (tagId) {
        case CONFIRMORDER:{
            conResponse = [[ConfirmResponse alloc] init];
            [conResponse setResultData:inParam];
            if(conResponse.code == 0){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确认去消费吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
            }else
            {
                [self showToast:conResponse.message];
            }
        }
            break;
            
        case ROBORDERDETAIL:{
            self.acResponse = [[AcceptOrderResponse alloc] init];
            [self.acResponse setResultData:inParam];
            if(self.acResponse.code == 0){
                if(self.acResponse.accAry != nil && [self.acResponse.accAry count]>0){
                    self.acAry = self.acResponse.accAry ;
                    [self.tableView reloadData];
                }
            }
        }
            break;
            
        case SUBMITCOMMENT:{
            NSDictionary *resDic = [inParam objectForKey:@"result"];
            NSInteger code = [[resDic objectForKey:@"code"] integerValue];
            if(code == 0){
                [self showToast:@"发表评论成功！"];
                [[NSNotificationCenter defaultCenter] postNotificationName:COMMENTREFRESH object:nil];
                [self popViewController];
            }else{
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
            break;
        case QUERYEVALUATE:
            if ([[[inParam objectForKey:@"result"] objectForKey:@"code"] integerValue] == 0)
            {
                if ([inParam objectForKey:@"body"]!=nil) {
                    NSDictionary *dic = [[[inParam objectForKey:@"body"] objectForKey:@"evaluate"] objectAtIndex:0];
                    EvaluateElement *element = [JsonUtils jsonEvaluateWithData:dic];
                    self.commView.commentView.hidden = NO;
                    self.commView.setRatingView.hidden = NO;
                    self.commView.enStarRating.hidden = NO;
                    self.commView.seStarRating.hidden = NO;
                    self.commView.titleLabel.hidden = YES;
                    [self.commView.titleButton setTitle:@"已评价" forState:UIControlStateNormal];
                    self.commView.conTv.text = element.commentContent;
                    [self.commView.setRatingView changeStarForegroundViewWithPoint:CGPointMake([element.deviceScore floatValue]*10, self.commView.setRatingView.frame.origin.y)];
                    [self.commView.seStarRating changeStarForegroundViewWithPoint:CGPointMake([element.serviceScore floatValue]*10, self.commView.setRatingView.frame.origin.y)];
                    [self.commView.enStarRating changeStarForegroundViewWithPoint:CGPointMake([element.environmentScore floatValue]*10, self.commView.setRatingView.frame.origin.y)];
                    self.commView.setRatingView.userInteractionEnabled = NO;
                    self.commView.enStarRating.userInteractionEnabled = NO;
                    self.commView.seStarRating.userInteractionEnabled = NO;
                    self.commView.conTv.userInteractionEnabled = NO;
                }
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
            break;
    }
}

-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *)error {
    [self showToast:@"网络异常，请稍后重试"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIAlerViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        {
            ConsumePayController *payCon = [[ConsumePayController alloc] init];
            payCon.price = self.price;
            payCon.orderId = conResponse.orderNum;
            payCon.shopName = shopName;
            payCon.roomType = roomType;
            [self.navigationController pushViewController:payCon animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
