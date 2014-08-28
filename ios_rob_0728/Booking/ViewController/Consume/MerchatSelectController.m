//
//  MerchatSelectController.m
//  Booking
//
//  Created by jinchenxin on 14-6-17.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "MerchatSelectController.h"
#import "LoadingView.h"
#import "MerchatCell.h"

@interface MerchatSelectController ()
{
    int lastHeight;
}
@end

@implementation MerchatSelectController

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
    self.title = @"商家选择";
    self.searchBtn.layer.cornerRadius = 3 ;
    
    UIButton *rightf = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 40)];
    [rightf setImage:[UIImage imageNamed:@"con_sure.png"] forState:UIControlStateNormal];
    UIBarButtonItem *itemf = [[UIBarButtonItem alloc] initWithCustomView:rightf];
    [rightf addTarget:self action:@selector(submitClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = itemf;
    
    self.currentPage = 1 ;
    self.shopsNameTf.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
    self.shopsNameTf.layer.borderWidth = 1;
    self.proAry = [[NSMutableArray alloc] init];
    if (self.selProAry == nil) {
        self.selProAry = [[NSMutableArray alloc] init];
    }
    else
    {
        if ([self.selProAry count]>0) {
            [self resetProviderInfoContent];
            self.providerInfoLa.text = [self getSelecteData];
        }
    }
    self.paramDic = [[NSMutableDictionary alloc]init];
    [self.paramDic setObject:@"430100" forKey:CITY];
    [self.paramDic setObject:self.shopsName forKey:@"shopsName"];
    [self.paramDic setObject:self.shopType forKey:@"shopType"];
    [self.paramDic setObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:INDEX];
    [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
    self.tableView.tableFooterView = [[LoadingView alloc]initType:0];
}

#pragma mark -UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.proAry count] ;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchatCell"];
    if(cell == nil) {
        cell = [[MerchatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MerchatCell"];
        cell.distanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cell.distanceButton.frame = CGRectMake(250, 63, 60, 22);
        [cell addSubview:cell.distanceButton];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, 11, 14)];
        imageView.image = [UIImage imageNamed:@"con_c_position.png"];
        [cell.distanceButton addSubview:imageView];
        
        cell.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 46, 22)];
        cell.distanceLabel.backgroundColor = [UIColor clearColor];
        cell.distanceLabel.font = [UIFont systemFontOfSize:10];
        cell.distanceLabel.textAlignment = NSTextAlignmentLeft;
        cell.distanceLabel.text = @"未知";
        [cell.distanceButton addSubview:cell.distanceLabel];
        ProviderElement *providerElement = [self.proAry objectAtIndex:indexPath.row];
        [cell setMerchatCellData:providerElement];
        [cell.selBtn addTarget:self action:@selector(selecteClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        cell.selBtn.tag = 100 +indexPath.row ;
        NSString *selectState = providerElement.selectState ;
        if([selectState isEqualToString:@"1"])
        {
            cell.selBtn.selected = YES ;
        }
    }
    return cell ;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIButton *btn = (UIButton*)[[tableView cellForRowAtIndexPath:indexPath] viewWithTag:(100+[indexPath row])];
    btn.selected = !btn.selected;
    ProviderElement *providerElement = [self.proAry objectAtIndex:[indexPath row]];
    NSString *selectState = providerElement.selectState ;
    if([selectState isEqualToString:@"1"]) {
        providerElement.selectState = @"0";
        for (ProviderElement *element in self.selProAry) {
            if([element.shopId isEqualToString:providerElement.shopId]){
                [self.selProAry removeObject:element];
                break;
            }
        }
    }else{
        providerElement.selectState = @"1";
        BOOL isExit = NO ;
        for (ProviderElement *element in self.selProAry) {
            if([element.shopId isEqualToString:providerElement.shopId]) isExit = YES ;
            break;
        }
        if(!isExit) [self.selProAry addObject:providerElement];
    }
    [self resetProviderInfoContent];
    self.providerInfoLa.text = [self getSelecteData];
}

/*
 * 是否选中商家事件方法
 */
-(void) selecteClickEvent:(id) sender {
    UIButton *btn = (UIButton *)sender ;
    btn.selected = !btn.selected ;
    NSInteger row = btn.tag - 100 ;
    ProviderElement *providerElement = [self.proAry objectAtIndex:row];
    NSString *selectState = providerElement.selectState ;
    if([selectState isEqualToString:@"1"]) {
        providerElement.selectState = @"0";
        for (ProviderElement *element in self.selProAry) {
            if([element.shopId isEqualToString:providerElement.shopId]){
                [self.selProAry removeObject:element];
                break;
            }
        }
    }else{
        providerElement.selectState = @"1";
        BOOL isExit = NO ;
        for (ProviderElement *element in self.selProAry) {
            if([element.shopId isEqualToString:providerElement.shopId]) isExit = YES ;
            break;
        }
        if(!isExit) [self.selProAry addObject:providerElement];
    }
    [self resetProviderInfoContent];
    self.providerInfoLa.text = [self getSelecteData];
}

- (void)resetProviderInfoContent
{
    CGSize textSize = [[self getSelecteData] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(300, 300)];
    int textHeight = textSize.height;
    if (textHeight>20)
    {
        if (textHeight > lastHeight)
        {
            if (lastHeight==0)
            {
                self.bottomView.frame = CGRectMake(0, self.bottomView.frame.origin.y-textHeight+20, 320, self.bottomView.frame.size.height+textHeight-20);
                self.providerInfoLa.frame = CGRectMake(10, self.providerInfoLa.frame.origin.y, 300,textHeight+1);
                self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-textHeight+20);
            }
            else
            {
                self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-textHeight+lastHeight);
                self.bottomView.frame = CGRectMake(0, self.bottomView.frame.origin.y-textHeight+lastHeight, 320, self.bottomView.frame.size.height+textHeight-lastHeight);
                self.providerInfoLa.frame = CGRectMake(10, self.providerInfoLa.frame.origin.y, 300,textHeight+1);
            }
            lastHeight = textHeight;
        }
        if (textHeight < lastHeight)
        {
            if (textHeight < lastHeight)
            {
                self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-textHeight+lastHeight);
                self.bottomView.frame = CGRectMake(0, self.bottomView.frame.origin.y-textHeight+lastHeight, 320, self.bottomView.frame.size.height+textHeight-lastHeight);
                self.providerInfoLa.frame = CGRectMake(10, self.providerInfoLa.frame.origin.y, 300,textHeight+1);
                lastHeight = textHeight;
            }
        }
    }
    else
    {
        if (lastHeight!=0)
        {
            self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-textHeight+20);
            self.bottomView.frame = CGRectMake(0, self.bottomView.frame.origin.y-textHeight+20, 320, self.bottomView.frame.size.height+textHeight-20);
            self.providerInfoLa.frame = CGRectMake(10, self.providerInfoLa.frame.origin.y, 300,20);
            lastHeight = 0;
        }
    }
}
/*
 * 商家被选中的数据拼装方法
 */
-(NSString *) getSelecteData {
    NSString *selecteInfo = @"";
    for (ProviderElement *element in self.selProAry) {
        selecteInfo = [NSString stringWithFormat:@"%@%@",selecteInfo,element.shopName];
        if ([self.selProAry indexOfObject:element]!=[self.selProAry count]-1)
        {
            selecteInfo = [NSString stringWithFormat:@"%@,",selecteInfo];
        }
    }    
    return selecteInfo ;
}

- (void)popViewController
{
    [SVProgressHUD dismiss];
    [super popViewController];
}
/*
 * 提供商家选择确定事件
 */
-(void)submitClickEvent:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:ADDPROVIDERREFRESH object:self.selProAry];
    [self.delegate shopShelect:self.selProAry];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 商家搜索事件
 */
-(IBAction)searchClickEvent:(id)sender {
    if (self.shopsNameTf.text==nil||[self.shopsNameTf.text isEqualToString:@""])
    {
        [self showToast:@"请输入商家名称"];
    }
    else
    {
        [SVProgressHUD show];
        self.shopsName = self.shopsNameTf.text ;
        self.currentPage = 1 ;
        [self.proAry removeAllObjects];
        [self.paramDic setObject:self.shopsName forKey:@"shopsName"];
        [self.paramDic setObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:INDEX];
        [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
        [self.shopsNameTf resignFirstResponder];
    }
}

#pragma mark - HttpRequestCommDelegate
-(void) httpRequestSuccessComm:(int)tagId withInParams:(id)inParam {
    [SVProgressHUD dismiss];
    self.proResponse = [[ProviderResponse alloc] init];
    [self.proResponse setResultData:inParam];
    if(self.proResponse.code == 0){
        if(self.proResponse.providerAry != nil && [self.proResponse.providerAry count]>0){
            [self.proAry addObjectsFromArray:self.proResponse.providerAry];
            
            for (ProviderElement *selElement in self.selProAry) {
                for (ProviderElement *element in self.proAry) {
                    if([element.shopId integerValue] ==[selElement.shopId integerValue])
                    {
                        element.selectState = @"1";
                        break;
                    }
                }
            }
            
            [self.tableView reloadData];
            if(self.currentPage == self.proResponse.totalPage){
                [self.tableView.tableFooterView removeFromSuperview];
                self.tableView.tableFooterView = [[LoadingView alloc]initType:1];
            }
        }else{
            [self.tableView reloadData];
            [self.tableView.tableFooterView removeFromSuperview];
            self.tableView.tableFooterView = [[LoadingView alloc]initType:1];
        }
        
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //数据分页加载
    if(scrollView.contentOffset.y == (self.tableView.contentSize.height - self.tableView.frame.size.height)){
        if(self.proResponse.totalPage > self.currentPage){
            self.currentPage ++ ;
            
            [self.paramDic setObject:self.shopsName forKey:@"shopsName"];
            [self.paramDic setObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:INDEX];
            [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
        }
    }
}

-(void) httpRequestFailueComm:(int)tagId withInParams:(NSString *)error {
    [SVProgressHUD dismiss];
    [self showToast:@"网络异常，请稍后重试"];
}

#pragma  mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
