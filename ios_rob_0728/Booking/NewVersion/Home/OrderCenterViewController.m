//
//  OrderCenterViewController.m
//  Booking
//
//  Created by jinchenxin on 14-7-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

enum ORDERSELECTED {
    WAITSUBMIT,
    WAITCONSUME,
    WAITCOMMENT,
    WAITCOMMENTED,
    WAITHISTORY,
};


#import "OrderCenterViewController.h"
#import "OrderListCell.h"
#import "OrderDetailsViewController.h"
#import "LoadingView.h"
#import "SharedUserDefault.h"

@interface OrderCenterViewController ()<UIAlertViewDelegate>
{
    LoadingView *refreshView;
    BOOL        isPullRefresh;
    
    BOOL        isFirstRequestOver;
    BOOL        isSecondRequestOver;
    BOOL        isThirdRequestOver;
    BOOL        isFourRequestOver;
    BOOL        isFiveRequestOver;
}
@end

@implementation OrderCenterViewController

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
    if (self.isFromConfirOrder&&![[SharedUserDefault sharedInstance] isUserComment])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"主子们，赏个赞吧\n微歌程序员加班加到吐血啦~" delegate:self cancelButtonTitle:@"赏赐一个赞" otherButtonTitles:@"残忍的拒绝", nil];
        [alert show];
        [[SharedUserDefault sharedInstance] setUserComment:@"Y"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的订单";
    self.wSubmitBtn.selected = YES ;
    self.currentBtn = self.wSubmitBtn ;
    self.currentRobPage = 1 ;
    self.currentConPage = 1 ;
    self.currentComPage = 1 ;
    self.currentComedPage = 1;
    self.currentHisPage = 1 ;
    
    if(DEVICE_IS_IPHONE5){
        self.scrollView.contentSize = CGSizeMake(320*5, 413);
    }else{
        self.scrollView.contentSize = CGSizeMake(320*5, 325);
    }
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self ;
    
    self.conParamDic = [[NSMutableDictionary alloc] init];
    [self.conParamDic setObject:@"0" forKey:@"isCost"];
    [self.conParamDic setObject:@"" forKey:@"isEvaluate"];
    [self.conParamDic setObject:@"1" forKey:INDEX];
    [self.conParamDic setObject:[NSString stringWithFormat:@"%d",MYORDERLIST0] forKey:@"tagId"];
    
    self.comParamDic = [[NSMutableDictionary alloc] init];
    [self.comParamDic setObject:@"1" forKey:@"isCost"];
    [self.comParamDic setObject:@"0" forKey:@"isEvaluate"];
    [self.comParamDic setObject:@"1" forKey:INDEX];
    [self.comParamDic setObject:[NSString stringWithFormat:@"%d",MYORDERLIST1] forKey:@"tagId"];
    
    self.comedParamDic = [[NSMutableDictionary alloc] init];
    [self.comedParamDic setObject:@"1" forKey:@"isCost"];
    [self.comedParamDic setObject:@"1" forKey:@"isEvaluate"];
    [self.comedParamDic setObject:@"1" forKey:INDEX];
    [self.comedParamDic setObject:[NSString stringWithFormat:@"%d",MYORDERLIST2] forKey:@"tagId"];
    
    self.robAry = [[NSMutableArray alloc] init];
    self.conAry = [[NSMutableArray alloc] init];
    self.comAry = [[NSMutableArray alloc] init];
    self.comedAry = [[NSMutableArray alloc] init];
    self.hisAry  = [[NSMutableArray alloc] init];
    
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 20)];
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.text = @"暂无数据";
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    self.infoLabel.textColor = [UIColor lightGrayColor];
    self.infoLabel.hidden = YES;
    [self.view addSubview:self.infoLabel];
    
    if ([ConUtils checkUserNetwork])
    {
        self.tableView.tableFooterView = [[LoadingView alloc] initType:0];
        self.conTableView.tableFooterView = [[LoadingView alloc] initType:0];
        self.comTableView.tableFooterView = [[LoadingView alloc] initType:0];
        self.comedTableView.tableFooterView = [[LoadingView alloc] initType:0];
        self.hisTableView.tableFooterView = [[LoadingView alloc] initType:0];
        [HttpRequestComm getrRobOrderDoingList:1 withUserFlag:@"Y" withDelegate:self];
    }
    else
    {
        [self showToast:@"网络异常，请稍后重试"];
    }
    
    //添加评论的通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentRefreshData:) name:COMMENTREFRESH object:nil];
}

-(void) commentRefreshData:(NSNotification *)notification
{
    [self.comAry removeAllObjects];
    [HttpRequestComm myOrderList:self.comParamDic withDelegate:self];
}

/*
 * 顶部菜单的选择按钮
 */
-(IBAction)menuClickEvent:(id)sender {
    self.infoLabel.hidden = YES;
    UIButton *btn = (UIButton *)sender ;
    self.currentBtn.selected = NO ;
    self.currentBtn = btn ;
    NSInteger tagValue = btn.tag ;
    self.currentPosition = tagValue - 100 ;
    self.currentBtn.selected = !btn.selected ;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.currentImg.frame = btn.frame ;
    }];
    [self setMenuSelectedState:self.currentPosition];
    
    
    switch (self.currentPosition) {
        case WAITSUBMIT:{
            if (self.robAry!=nil&&[self.robAry count]>0)
            {
                [self insertRefrshViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) withType:3];
            }
            else
            {
                if ([ConUtils checkUserNetwork]) {
                    self.tableView.tableFooterView = [[LoadingView alloc] initType:0];
                    [HttpRequestComm getrRobOrderDoingList:1 withUserFlag:@"Y" withDelegate:self];
                }
                else
                {
                    [self showToast:@"网络异常，请稍后重试"];
                }
            }
        }
            break;
        case WAITCONSUME:{
            if (self.conAry!=nil&&[self.conAry count]>0)
            {
                [self insertRefrshViewWithFrame:CGRectMake(320, 0, SCREEN_WIDTH, 40) withType:3];
            }
            else
            {
                if ([ConUtils checkUserNetwork]) {
                    self.conTableView.tableFooterView = [[LoadingView alloc] initType:0];
                    [HttpRequestComm myOrderList:self.conParamDic withDelegate:self];
                }
                else
                {
                    [self showToast:@"网络异常，请稍后重试"];
                }
            }
        }
            break;
        case WAITCOMMENT:{
            if (self.comAry!=nil&&[self.comAry count]>0)
            {
                [self insertRefrshViewWithFrame:CGRectMake(640, 0, SCREEN_WIDTH, 40) withType:3];
            }
            else
            {
                if ([ConUtils checkUserNetwork]) {
                    self.comTableView.tableFooterView = [[LoadingView alloc] initType:0];
                    [HttpRequestComm myOrderList:self.comParamDic withDelegate:self];
                }
                else
                {
                    [self showToast:@"网络异常，请稍后重试"];
                }
            }
        }
            break;
        case WAITCOMMENTED:{
            if (self.comedAry!=nil&&[self.comedAry count]>0)
            {
                [self insertRefrshViewWithFrame:CGRectMake(960, 0, SCREEN_WIDTH, 40) withType:3];
            }
            else
            {
                if ([ConUtils checkUserNetwork]) {
                    self.comedTableView.tableFooterView = [[LoadingView alloc] initType:0];
                    [HttpRequestComm myOrderList:self.comedParamDic withDelegate:self];
                }
                else
                {
                    [self showToast:@"网络异常，请稍后重试"];
                }
            }
            break;
        }
        case WAITHISTORY:{
            if (self.hisAry!=nil&&[self.hisAry count]>0)
            {
                [self insertRefrshViewWithFrame:CGRectMake(1280, 0, SCREEN_WIDTH, 40) withType:3];
            }
            else
            {
                if ([ConUtils checkUserNetwork]) {
                    self.hisTableView.tableFooterView = [[LoadingView alloc] initType:0];
                    [HttpRequestComm getrRobOrderUndoneList:1 withUserFlag:@"Y" withDelegate:self];
                }
                else
                {
                    [self showToast:@"网络异常，请稍后重试"];
                }
            }
        }
            break;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger counts  = 0 ;
    switch (self.currentPosition) {
        case WAITSUBMIT:{
           counts = self.robAry!= nil? [self.robAry count]:0 ;
        }
            break;
        case WAITCONSUME:{
            counts = self.conAry!= nil?[self.conAry count]:0 ;
        }
            break;
        case WAITCOMMENT:{
            counts = self.comAry!= nil?[self.comAry count]:0 ;
        }
            break;
        case WAITCOMMENTED:{
            counts = self.comedAry!= nil?[self.comedAry count]:0 ;
        }
            break;
        case WAITHISTORY:{
            counts = self.hisAry!= nil?[self.hisAry count]:0 ;
        }
            break;
    }
    return counts ;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135 ;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListCell *cell = nil ;
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListCell" owner:self options:nil]objectAtIndex:0];
        cell.nameLa.hidden = NO ;
        cell.nameImg.hidden = NO ;
        switch (tableView.tag) {
            case 500:{
                RequireElement *element = [self.robAry objectAtIndex:indexPath.row];
                [cell setOrderListData:element];
                //cell.picImg.image = [UIImage imageNamed:@"m_img_ktv"] ;
                cell.tagImg.image = [UIImage imageNamed:@"m_order_time"];
                cell.nameLa.hidden = YES ;
                cell.nameImg.hidden = YES ;
            }
                break;
            case 501:{
                OrderElement *element = [self.conAry objectAtIndex:indexPath.row];
                RequireElement *reElement = [ConUtils convertRequireElement:element];
                cell.isCostCell = YES;
                [cell setOrderListData:reElement];
                cell.verifyCodeLa.hidden = NO;
                cell.verifyLa.hidden = NO;
                cell.tagImg.image = [UIImage imageNamed:@"m_order_con"];
            }
                break;
            case 502:{
                OrderElement *element = [self.comAry objectAtIndex:indexPath.row];
                RequireElement *reElement = [ConUtils convertRequireElement:element];
                cell.isCostCell = YES;
                [cell setOrderListData:reElement];
                [ConUtils checkFileWithURLString:reElement.logoUrl withImageView:cell.picImg withDirector:@"Shop" withDefaultImage:@"m_img_ktv.png"];
                [cell.reduceTimeView removeFromSuperview];
                cell.comHisBtn.hidden = NO ;
                [cell.comHisBtn setImage:[UIImage imageNamed:@"h_order_com"] forState:UIControlStateNormal];
                [cell.comHisBtn setTitle:@" 待评论" forState:UIControlStateNormal];
                cell.tagImg.image = [UIImage imageNamed:@"m_order_com"];
            }
                break;
            case 503:{
                OrderElement *element = [self.comedAry objectAtIndex:indexPath.row];
                RequireElement *reElement = [ConUtils convertRequireElement:element];
                cell.isCostCell = YES;
                [cell setOrderListData:reElement];
                [ConUtils checkFileWithURLString:reElement.logoUrl withImageView:cell.picImg withDirector:@"Shop" withDefaultImage:@"m_img_ktv.png"];
                [cell.reduceTimeView removeFromSuperview];
                cell.comHisBtn.hidden = NO ;
                [cell.comHisBtn setTitle:@" 已评论" forState:UIControlStateNormal];
                cell.tagImg.image = [UIImage imageNamed:@"m_order_old1"];
            }
                break;
            case 504:{
                RequireElement *element = [self.hisAry objectAtIndex:indexPath.row];
                [cell setOrderListData:element];
                [cell.comHisBtn setTitle:@" 已过期" forState:UIControlStateNormal];
                cell.tagImg.image = [UIImage imageNamed:@"m_order_old2"];
                cell.comHisBtn.hidden = NO ;
                cell.nameLa.hidden = YES ;
                cell.nameImg.hidden = YES ;
            }
                break;
        }
        
    }
    return cell ;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *titleName = @"";
    RequireElement *element = nil ;
    switch (self.currentPosition) {
        case WAITSUBMIT:{
            element = [self.robAry objectAtIndex:indexPath.row];
            titleName = @"待确认详情";
        }
            break;
        case WAITCONSUME:{
            OrderElement  *orElement = [self.conAry objectAtIndex:indexPath.row];
            element = [ConUtils convertRequireElement:orElement];
            titleName = @"待消费详情";
        }
            break;
        case WAITCOMMENT:{
            OrderElement *orElement = [self.comAry objectAtIndex:indexPath.row];
            element = [ConUtils convertRequireElement:orElement];
            titleName = @"待评论详情";
        }
            break;
        case WAITCOMMENTED:{
            OrderElement *orElement = [self.comedAry objectAtIndex:indexPath.row];
            element = [ConUtils convertRequireElement:orElement];
            titleName = @"已评论详情";
        }
            break;
        case WAITHISTORY:{
            element = [self.hisAry objectAtIndex:indexPath.row];
            titleName = @"已过期详情";
        }
            break;
    }
    OrderDetailsViewController *detailsCon = [[OrderDetailsViewController alloc] init];
    detailsCon.reElement = element ;
    detailsCon.currentPosition = self.currentPosition ;
    detailsCon.title = titleName;
    [self.navigationController pushViewController:detailsCon animated:YES];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    isPullRefresh = YES;
    if (scrollView.contentOffset.y<-50)
    {
        switch (self.currentPosition) {
            case WAITSUBMIT:{
                if (isFirstRequestOver) {
                    [self insertRefrshViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) withType:0];
                    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
                    [HttpRequestComm getrRobOrderDoingList:1 withUserFlag:@"Y" withDelegate:self];
                }
            }
                break;
            case WAITCONSUME:{
                if (isSecondRequestOver)
                {
                    [self insertRefrshViewWithFrame:CGRectMake(320, 0, SCREEN_WIDTH, 40) withType:0];
                    self.conTableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
                    [HttpRequestComm myOrderList:self.conParamDic withDelegate:self];
                }
            }
                break;
            case WAITCOMMENT:{
                if (isThirdRequestOver) {
                    [self insertRefrshViewWithFrame:CGRectMake(640, 0, SCREEN_WIDTH, 40) withType:0];
                    self.comTableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
                    [HttpRequestComm myOrderList:self.comParamDic withDelegate:self];
                }
            }
                break;
            case WAITCOMMENTED:{
                if (isFourRequestOver) {
                    [self insertRefrshViewWithFrame:CGRectMake(960, 0, SCREEN_WIDTH, 40) withType:0];
                    self.comedTableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
                    [HttpRequestComm myOrderList:self.comedParamDic withDelegate:self];
                }
                break;
            }
            case WAITHISTORY:{
                if (isFiveRequestOver) {
                    [self insertRefrshViewWithFrame:CGRectMake(1280, 0, SCREEN_WIDTH, 40) withType:0];
                    self.hisTableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
                    [HttpRequestComm getrRobOrderUndoneList:1 withUserFlag:@"Y" withDelegate:self];
                }
            }
                break;
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.infoLabel.hidden = YES;
    isPullRefresh = NO;
    if(self.scrollView.contentOffset.x == 0){
        self.currentPosition = WAITSUBMIT;
        if(self.robAry == nil || [self.robAry count] == 0){
            if ([ConUtils checkUserNetwork])
            {
                self.tableView.tableFooterView = [[LoadingView alloc] initType:0];
                [HttpRequestComm getrRobOrderDoingList:1 withUserFlag:@"Y" withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
        else
        {
            [self insertRefrshViewWithFrame:CGRectMake(0, 0, 320, 40) withType:3];
        }
    }else if(self.scrollView.contentOffset.x == 320){
        self.currentPosition = WAITCONSUME;
        if(self.conAry == nil || [self.conAry count] == 0){
            if ([ConUtils checkUserNetwork]) {
                self.conTableView.tableFooterView = [[LoadingView alloc] initType:0];
                [HttpRequestComm myOrderList:self.conParamDic withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
        else
        {
            [self insertRefrshViewWithFrame:CGRectMake(320, 0, 320, 40) withType:3];
        }
    }else if(self.scrollView.contentOffset.x == 640){
        self.currentPosition = WAITCOMMENT;
        if(self.comAry == nil || [self.comAry count] == 0){
            if ([ConUtils checkUserNetwork]) {
                self.comTableView.tableFooterView = [[LoadingView alloc] initType:0];
                [HttpRequestComm myOrderList:self.comParamDic withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
        else
        {
            [self insertRefrshViewWithFrame:CGRectMake(640, 0, 320, 40) withType:3];
        }
    }else if(self.scrollView.contentOffset.x == 960){
        self.currentPosition = WAITCOMMENTED ;
        if(self.comedAry == nil || [self.comedAry count] == 0){
            if ([ConUtils checkUserNetwork]) {
                self.comedTableView.tableFooterView = [[LoadingView alloc] initType:0];
                [HttpRequestComm myOrderList:self.comedParamDic withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
        else
        {
            [self insertRefrshViewWithFrame:CGRectMake(960, 0, 320, 40) withType:3];
        }
    }else if(self.scrollView.contentOffset.x == 1280){
        self.currentPosition = WAITHISTORY;
        if(self.hisAry == nil || [self.hisAry count] == 0){
            if ([ConUtils checkUserNetwork]) {
                self.hisTableView.tableFooterView = [[LoadingView alloc] initType:0];
                [HttpRequestComm getrRobOrderUndoneList:1 withUserFlag:@"Y" withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
        else
        {
            [self insertRefrshViewWithFrame:CGRectMake(1280, 0, 320, 40) withType:3];
        }
    }
    [self setMenuSelectedState:self.currentPosition];
    
    //数据分页加载
    if(self.tableView.contentOffset.y == (self.tableView.contentSize.height - self.tableView.frame.size.height)){
        if(self.robResponse.totalPage > self.currentRobPage){
            if ([ConUtils checkUserNetwork]) {
                self.currentRobPage ++ ;
                [HttpRequestComm getrRobOrderDoingList:self.currentRobPage withUserFlag:nil withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
    }else if(self.conTableView.contentOffset.y == (self.conTableView.contentSize.height - self.conTableView.frame.size.height)){
        if(self.conResponse != nil && self.conResponse.totalPage > self.currentConPage){
            if ([ConUtils checkUserNetwork]) {
                self.currentConPage ++ ;
                [self.conParamDic setObject:[NSString stringWithFormat:@"%d",self.currentConPage] forKey:INDEX];
                [HttpRequestComm myOrderList:self.conParamDic withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
        
    }else if(self.comTableView.contentOffset.y == (self.comTableView.contentSize.height - self.comTableView.frame.size.height)){
        if(self.comResponse != nil && self.comResponse.totalPage > self.currentComPage){
            if ([ConUtils checkUserNetwork]) {
                self.currentComPage ++ ;
                [self.comParamDic setObject:[NSString stringWithFormat:@"%d",self.currentComPage] forKey:INDEX];
                [HttpRequestComm myOrderList:self.comParamDic withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
    }else if(self.comedTableView.contentOffset.y == (self.comedTableView.contentSize.height - self.comedTableView.frame.size.height)){
        if(self.comedResponse != nil && self.comedResponse.totalPage > self.currentComedPage){
            if ([ConUtils checkUserNetwork]) {
                self.currentComedPage ++ ;
                [self.comedParamDic setObject:[NSString stringWithFormat:@"%d",self.currentComedPage] forKey:INDEX];
                [HttpRequestComm myOrderList:self.comedParamDic withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
    
    }else if(self.hisTableView.contentOffset.y == (self.hisTableView.contentSize.height - self.hisTableView.frame.size.height)){
        if(self.hisResponse != nil && self.hisResponse.totalPage > self.currentHisPage){
            if ([ConUtils checkUserNetwork]) {
                self.currentHisPage ++ ;
                [HttpRequestComm getrRobOrderUndoneList:self.currentHisPage withUserFlag:@"Y" withDelegate:self];
            }
            else
            {
                [self showToast:@"网络异常，请稍后重试"];
            }
        }
    }
}
#pragma mark 添加refreshView
- (void)insertRefrshViewWithFrame:(CGRect)frame withType:(int)type
{
    [refreshView removeFromSuperview];
    refreshView = [[LoadingView alloc] initType:type];
    if (type!=0) {
        refreshView.hidden = YES;
    }
    [refreshView setFrame:frame];
    [self.scrollView insertSubview:refreshView atIndex:0];
}

/*
 * 设置顶部菜单栏的选中状态
 */
-(void) setMenuSelectedState:(NSInteger) position {
    switch (position) {
        case WAITSUBMIT:{
            self.wSubmitBtn.selected = YES ;
            self.wConsumeBtn.selected = NO ;
            self.wCommentBtn.selected = NO ;
            self.wCommentedBtn.selected = NO ;
            self.wHistoryBtn.selected = NO ;
            self.currentBtn = self.wSubmitBtn ;
        }
            break;
        case WAITCONSUME:{
            self.wSubmitBtn.selected = NO ;
            self.wConsumeBtn.selected = YES ;
            self.wCommentBtn.selected = NO ;
            self.wCommentedBtn.selected = NO ;
            self.wHistoryBtn.selected = NO ;
            self.currentBtn = self.wConsumeBtn;
        }
            break;
        case WAITCOMMENT:{
            self.wSubmitBtn.selected = NO ;
            self.wConsumeBtn.selected = NO ;
            self.wCommentBtn.selected = YES ;
            self.wCommentedBtn.selected = NO ;
            self.wHistoryBtn.selected = NO ;
            self.currentBtn = self.wCommentBtn ;
        }
            break;
            
        case WAITCOMMENTED:{
            self.wSubmitBtn.selected = NO ;
            self.wConsumeBtn.selected = NO ;
            self.wCommentBtn.selected = NO ;
            self.wCommentedBtn.selected = YES ;
            self.wHistoryBtn.selected = NO ;
            self.currentBtn = self.wCommentedBtn ;
        }
            break;
        case WAITHISTORY:{
            self.wSubmitBtn.selected = NO ;
            self.wConsumeBtn.selected = NO ;
            self.wCommentBtn.selected = NO ;
            self.wCommentedBtn.selected = NO ;
            self.wHistoryBtn.selected = YES ;
            self.currentBtn = self.wHistoryBtn ;
        }
            break;
    }
    
    [self.scrollView setContentOffset:CGPointMake(320*position, 0) animated:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.x != 0){
        self.currentImg.frame = CGRectMake(scrollView.contentOffset.x/5,self.currentImg.frame.origin.y, self.currentImg.frame.size.width, self.currentImg.frame.size.height);
    }
    if (!isPullRefresh)
    {
        if (scrollView.contentOffset.y<0&&scrollView.contentOffset.y>-50)
        {
            refreshView.desLa.text = @"下拉可以刷新";
        }
        else if (scrollView.contentOffset.y<-50)
        {
            refreshView.desLa.text = @"松开可以刷新";
        }
        if (scrollView.contentOffset.y<0)
        {
            if (refreshView.hidden)
            {
                refreshView.hidden = NO;
                self.infoLabel.hidden = YES;
            }
        }
    }
}

-(void)httpRequestSuccessComm:(int)tagId withInParams:(id)inParam {

    switch (tagId) {
        case ROBORDERLIST0:{
            self.robResponse = [[RobRequireResponse alloc] init];
            [self.robResponse setResultData:inParam];
            if(self.robResponse.code == 0){
                if(self.robResponse.robRequireAry != nil && [self.robResponse.robRequireAry count]>0){
                    if (self.robResponse.index == 1)
                    {
                        [self.robAry removeAllObjects];
                        
                        self.tableView.contentInset = UIEdgeInsetsZero;
                        
                        [self insertRefrshViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) withType:3];
                    }
                    [self.robAry addObjectsFromArray:self.robResponse.robRequireAry];
                    [self.tableView reloadData];
                    if(self.currentRobPage == self.robResponse.totalPage){
                        [self.tableView.tableFooterView removeFromSuperview];
                        self.tableView.tableFooterView = [[LoadingView alloc]initType:1];
                    }
                    else
                    {
                        self.tableView.tableFooterView = [[LoadingView alloc] initType:0];
                    }
                }
                else
                {
                    self.tableView.contentInset = UIEdgeInsetsZero;
                    [self insertRefrshViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) withType:3];
                    [self.tableView.tableFooterView removeFromSuperview];
                    self.infoLabel.hidden = NO;
                }
            }
            else
            {
                self.tableView.contentInset = UIEdgeInsetsZero;
                [self insertRefrshViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) withType:3];
                [self.tableView.tableFooterView removeFromSuperview];
                self.infoLabel.hidden = NO;
                [self showToast:self.robResponse.message];
            }
            isFirstRequestOver = YES;
        }
            
            break;
        case MYORDERLIST0:{
            self.conResponse = [[OrderResponse alloc] init];
            [self.conResponse setResultData:inParam];
            if(self.conResponse.code == 0){
                if(self.conResponse.mulArray != nil && [self.conResponse.mulArray count]>0){
                    if (self.conResponse.index == 1)
                    {
                        [self.conAry removeAllObjects];
                        
                        self.conTableView.contentInset = UIEdgeInsetsZero;
                        
                        [self insertRefrshViewWithFrame:CGRectMake(320, 0, SCREEN_WIDTH, 40) withType:3];
                    }
                    [self.conAry addObjectsFromArray:self.conResponse.mulArray];
                    [self.conTableView reloadData];
                    if(self.currentConPage == self.conResponse.totalPage)
                    {
                        [self.conTableView.tableFooterView removeFromSuperview];
                        self.conTableView.tableFooterView = [[LoadingView alloc]initType:1];
                    }
                    else
                    {
                        self.conTableView.tableFooterView = [[LoadingView alloc] initType:0];
                    }
                }
                else
                {
                    self.conTableView.contentInset = UIEdgeInsetsZero;
                    [self insertRefrshViewWithFrame:CGRectMake(320, 0, SCREEN_WIDTH, 40) withType:3];
                    [self.conTableView.tableFooterView removeFromSuperview];
                    self.infoLabel.hidden = NO;
                }
            }
            else
            {
                self.conTableView.contentInset = UIEdgeInsetsZero;
                [self insertRefrshViewWithFrame:CGRectMake(320, 0, SCREEN_WIDTH, 40) withType:3];
                [self.conTableView.tableFooterView removeFromSuperview];
                self.infoLabel.hidden = NO;
                [self showToast:self.conResponse.message];
            }
            isSecondRequestOver = YES;
        }
            break;
        case MYORDERLIST1:{
            self.comResponse = [[OrderResponse alloc] init];
            [self.comResponse setResultData:inParam];
            if(self.comResponse.code == 0){
                if(self.comResponse.mulArray != nil && [self.comResponse.mulArray count]>0){
                    if (self.comResponse.index == 1)
                    {
                        [self.comAry removeAllObjects];
                        
                        self.comTableView.contentInset = UIEdgeInsetsZero;
                        
                        [self insertRefrshViewWithFrame:CGRectMake(640, 0, SCREEN_WIDTH, 40) withType:3];
                    }
                    [self.comAry addObjectsFromArray:self.comResponse.mulArray];
                    [self.comTableView reloadData];
                    if(self.currentComPage == self.comResponse.totalPage){
                        [self.comTableView.tableFooterView removeFromSuperview];
                        self.comTableView.tableFooterView = [[LoadingView alloc]initType:1];
                    }
                    else
                    {
                        self.comTableView.tableFooterView = [[LoadingView alloc] initType:0];
                    }
                }
                else
                {
                    self.comTableView.contentInset = UIEdgeInsetsZero;
                    [self insertRefrshViewWithFrame:CGRectMake(640, 0, SCREEN_WIDTH, 40) withType:3];
                    [self.comTableView.tableFooterView removeFromSuperview];
                    self.infoLabel.hidden = NO;
                    [self.comTableView reloadData];
                }
            }
            else
            {
                self.comTableView.contentInset = UIEdgeInsetsZero;
                [self insertRefrshViewWithFrame:CGRectMake(640, 0, SCREEN_WIDTH, 40) withType:3];
                [self.comTableView.tableFooterView removeFromSuperview];
                self.infoLabel.hidden = NO;
                [self showToast:self.comedResponse.message];
            }
            isThirdRequestOver = YES;
        }
            break;
            
        case MYORDERLIST2:{
            self.comedResponse = [[OrderResponse alloc] init];
            [self.comedResponse setResultData:inParam];
            if(self.comedResponse.code == 0){
                if(self.comedResponse.mulArray != nil && [self.comedResponse.mulArray count]>0){
                    self.infoLabel.hidden = YES;
                    if (self.comedResponse.index == 1)
                    {
                        [self.comedAry removeAllObjects];
                        
                        self.comedTableView.contentInset = UIEdgeInsetsZero;
                        
                        [self insertRefrshViewWithFrame:CGRectMake(960, 0, SCREEN_WIDTH, 40) withType:3];
                    }
                    [self.comedAry addObjectsFromArray:self.comedResponse.mulArray];
                    [self.comedTableView reloadData];
                    if(self.currentComedPage == self.comedResponse.totalPage){
                        [self.comedTableView.tableFooterView removeFromSuperview];
                        self.comedTableView.tableFooterView = [[LoadingView alloc]initType:1];
                    }
                    else
                    {
                        self.comedTableView.tableFooterView = [[LoadingView alloc] initType:0];
                    }
                }
                else
                {
                    self.comedTableView.contentInset = UIEdgeInsetsZero;
                    [self insertRefrshViewWithFrame:CGRectMake(960, 0, SCREEN_WIDTH, 40) withType:3];
                    [self.comedTableView.tableFooterView removeFromSuperview];
                    self.infoLabel.hidden = NO;
                    [self.comedTableView reloadData];
                }
            }
            else
            {
                self.comedTableView.contentInset = UIEdgeInsetsZero;
                [self insertRefrshViewWithFrame:CGRectMake(960, 0, SCREEN_WIDTH, 40) withType:3];
                [self.comedTableView.tableFooterView removeFromSuperview];
                self.infoLabel.hidden = NO;
                [self showToast:self.comedResponse.message];
            }
            isFourRequestOver = YES;
        }
            break;
            
        case ROBORDERLIST2:{
            self.hisResponse = [[RobRequireResponse alloc] init];
            [self.hisResponse setResultData:inParam];
            if(self.hisResponse.code == 0)
            {
                if(self.hisResponse.robRequireAry != nil && [self.hisResponse.robRequireAry count]>0){
                    self.infoLabel.hidden = YES;
                    if (self.hisResponse.index == 1)
                    {
                        [self.hisAry removeAllObjects];
                        
                        self.hisTableView.contentInset = UIEdgeInsetsZero;
                        
                        [self insertRefrshViewWithFrame:CGRectMake(1280, 0, SCREEN_WIDTH, 40) withType:3];
                    }
                    [self.hisAry addObjectsFromArray:self.hisResponse.robRequireAry];
                    [self.hisTableView reloadData];
                    if(self.currentHisPage == self.hisResponse.totalPage){
                        [self.hisTableView.tableFooterView removeFromSuperview];
                        self.hisTableView.tableFooterView = [[LoadingView alloc]initType:1];
                    }
                    else
                    {
                        self.hisTableView.tableFooterView = [[LoadingView alloc] initType:0];
                    }
                }
                else
                {
                    self.hisTableView.contentInset = UIEdgeInsetsZero;
                    [self insertRefrshViewWithFrame:CGRectMake(1280, 0, SCREEN_WIDTH, 40) withType:3];
                    [self.hisTableView.tableFooterView removeFromSuperview];
                    self.infoLabel.hidden = NO;
                    if ([self.hisAry count]!=0) {
                        [self.hisAry removeAllObjects];
                        [self.hisTableView reloadData];
                    }
                }
            }
            else
            {
                self.hisTableView.contentInset = UIEdgeInsetsZero;
                [self insertRefrshViewWithFrame:CGRectMake(1280, 0, SCREEN_WIDTH, 40) withType:3];
                [self.hisTableView.tableFooterView removeFromSuperview];
                self.infoLabel.hidden = NO;
                [self showToast:self.hisResponse.message];
            }
            isFiveRequestOver = YES;
            break;
        }
    }
}

-(void)httpRequestFailueComm:(int)tagId withInParams:(NSString *)error
{
    switch (tagId) {
        case ROBORDERLIST0:{
            self.tableView.contentInset = UIEdgeInsetsZero;
            [self insertRefrshViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) withType:3];
            [self.tableView.tableFooterView removeFromSuperview];
            self.infoLabel.hidden = NO;
            isFirstRequestOver = YES;
        }
            break;
        case MYORDERLIST0:{
            self.conTableView.contentInset = UIEdgeInsetsZero;
            [self insertRefrshViewWithFrame:CGRectMake(320, 0, SCREEN_WIDTH, 40) withType:3];
            [self.conTableView.tableFooterView removeFromSuperview];
            self.infoLabel.hidden = NO;
            isSecondRequestOver = YES;
        }
            break;
        case MYORDERLIST1:{
            self.comTableView.contentInset = UIEdgeInsetsZero;
            [self insertRefrshViewWithFrame:CGRectMake(640, 0, SCREEN_WIDTH, 40) withType:3];
            [self.comTableView.tableFooterView removeFromSuperview];
            self.infoLabel.hidden = NO;
            isThirdRequestOver = YES;
        }
            break;
            
        case MYORDERLIST2:{
            self.comedTableView.contentInset = UIEdgeInsetsZero;
            [self insertRefrshViewWithFrame:CGRectMake(960, 0, SCREEN_WIDTH, 40) withType:3];
            [self.comedTableView.tableFooterView removeFromSuperview];
            self.infoLabel.hidden = NO;
            isFourRequestOver = YES;
        }
            break;
            
        case ROBORDERLIST2:{
            self.hisTableView.contentInset = UIEdgeInsetsZero;
            [self insertRefrshViewWithFrame:CGRectMake(1280, 0, SCREEN_WIDTH, 40) withType:3];
            [self.hisTableView.tableFooterView removeFromSuperview];
            self.infoLabel.hidden = NO;
            isFiveRequestOver = YES;
        }
            break;
    }
    [self showToast:@"网络异常，请稍后重试"];
}

-(void)popViewController
{
    if (self.isFromConfirOrder)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            NSURL *appURL = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/wei-ge/id791098078?mt=8"];
            [[UIApplication sharedApplication] openURL:appURL];
        }
            break;
        case 1:
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
