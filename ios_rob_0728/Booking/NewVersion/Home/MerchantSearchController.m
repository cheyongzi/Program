//
//  MerchantSearchController.m
//  Booking
//
//  Created by jinchenxin on 14-7-11.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "MerchantSearchController.h"
#import "MerchatCell.h"

/*
 * 搜索结果页面
 */
@interface MerchantSearchController ()
{
    UIActivityIndicatorView *indicatorView;
}
@end

@implementation MerchantSearchController

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
    
    self.title = @"商户搜索页面";
    self.seaContent = [self.paramDic objectForKey:@"shopsName"];
    [self.paramDic setObject:@"" forKey:LATITUDE];
    [self.paramDic setObject:@"" forKey:LONGITUDE];
    self.proAry = [[NSMutableArray alloc] init];
    //添加搜索框背景视图
    self.searchImg = [[UIImageView alloc] init];
    self.searchImg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    self.searchImg.image = [[UIImage imageNamed:@"h_search_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    self.searchImg.clipsToBounds = YES ;
    self.searchImg.userInteractionEnabled = YES ;
    [self.view addSubview:self.searchImg];
    
    
    UIImageView *searchBg = [[UIImageView alloc] init];
    searchBg.frame = CGRectMake(15, 5, SCREEN_WIDTH - 75, 40);
    searchBg.image = [[UIImage imageNamed:@"h_search_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    searchBg.userInteractionEnabled = YES ;
    [self.searchImg addSubview:searchBg];
    
    //添加搜索框
    self.searchTf = [[UITextField alloc] init];
    self.searchTf.frame = CGRectMake(15, 10, SCREEN_WIDTH-75, 20);
    self.searchTf.placeholder = @"请输入搜索内容";
    self.searchTf.text = self.seaContent ;
    self.searchTf.font = [UIFont systemFontOfSize:15];
    self.searchTf.returnKeyType = UIReturnKeyDone ;
    self.searchTf.delegate = self;
    [searchBg addSubview:self.searchTf];
    
    //添加搜索按钮
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBtn.frame = CGRectMake(SCREEN_WIDTH-60, 0, 50, 50);
    [self.searchBtn setImage:[UIImage imageNamed:@"h_search_p"] forState:UIControlStateNormal];
//    [self.searchBtn setImage:[UIImage imageNamed:@"h_search_p"] forState:UIControlStateSelected];
    [self.searchBtn addTarget:self action:@selector(searchClickEvent:) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:self.searchBtn];
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.frame = CGRectMake(SCREEN_WIDTH/2, APPLICATION_HEIGHT/2, 20, 20);
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    
    [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
}

#pragma mark - HttpRequestCommDelegate
-(void) httpRequestSuccessComm:(int)tagId withInParams:(id)inParam {
    [indicatorView stopAnimating];
    self.proResponse = [[ProviderResponse alloc] init];
    [self.proResponse setResultData:inParam];
    if(self.proResponse.code == 0){
        if(self.proResponse.providerAry != nil && [self.proResponse.providerAry count]>0){
            [self.proAry addObjectsFromArray:self.proResponse.providerAry];
            [self.tableView reloadData];
        }
        
    }
}


-(void) httpRequestFailueComm:(int)tagId withInParams:(NSString *)error {
    [indicatorView stopAnimating];
    [self showToast:@"网络异常，请稍后重试"];
}

/*
 * 搜索按钮的事件方法
 */
-(void) searchClickEvent:(id) sender {
    
    NSString *keyword = self.searchTf.text ;
    if(keyword == nil)keyword = @"";
    [self.view endEditing:YES];
    [self.paramDic setObject:keyword forKey:@"shopsName"];
    [self.proAry removeAllObjects];
    [HttpRequestComm getNearShopList:self.paramDic withDelegate:self];
}

#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.proAry count] ;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchatCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MerchatCell" owner:self options:nil] objectAtIndex:0];
        ProviderElement *providerElement = [self.proAry objectAtIndex:indexPath.row];
        [cell setMerchatCellData:providerElement];
        cell.selBtn.hidden = YES ;
        
    }
    return cell ;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     ProviderElement *providerElement = [self.proAry objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:SEARCHREFRESH object:providerElement];
    [self popViewController];
}



#pragma  mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"----------");
    [textField resignFirstResponder];
    return YES ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
