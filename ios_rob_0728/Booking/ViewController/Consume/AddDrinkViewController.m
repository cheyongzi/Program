//
//  AddDrinkViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-17.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "AddDrinkViewController.h"
#import "UIImageView+WebCache.h"
#import "WineElement.h"
#import "DrinkTypeResponse.h"

@interface AddDrinkViewController ()
{
    float lastHeight;
}
@end

@implementation AddDrinkViewController

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
    self.title = @"添加商品";
    
    self.currentSelBtn.selected = YES ;
    self.searchType = @"";
    self.keyword = @"";
    self.keywordTF.layer.borderWidth = 1;
    self.keywordTF.layer.borderColor = [LOAD_SEPERATE_COLOR CGColor];
    self.winAry = [[NSMutableArray alloc] init];
    self.tableView.tableFooterView = [[LoadingView alloc]initType:0];
    self.currentPage = 1 ;
    self.searchBtn.layer.cornerRadius = 3;
    
    self.conImg.image = [[UIImage imageNamed:@"com_con_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    if ([self.addWineAry count]>0)
    {
        [self resetDrinkContent];
        self.addDrinkInfoLa.text = [self getAddDrinkInfo];
        self.totalLa.text = [NSString stringWithFormat:@"%@元",[self getAddDrinkTotalPrice]];
    }
    
    UIButton *rightf = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 40)];
    [rightf setImage:[UIImage imageNamed:@"con_sure.png"] forState:UIControlStateNormal];
    UIBarButtonItem *itemf = [[UIBarButtonItem alloc] initWithCustomView:rightf];
    [rightf addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = itemf;
    
    [HttpRequestComm getGoodsTypeList:self];
}

/*
 * 酒水筛选的事件
 */
-(void)selectClickEvent:(id)sender {
    
    self.currentSelBtn.selected = NO;
    UIButton *btn = (UIButton *)sender ;
    NSInteger position = btn.tag -200 ;
    self.currentSelBtn = btn ;
    self.currentSelBtn.selected = YES;
    self.currentPage = 1 ;
    [self.winAry removeAllObjects];
    [self.tableView reloadData];
    [self.tableView.tableFooterView removeFromSuperview];
    self.tableView.tableFooterView = [[LoadingView alloc] initType:0];
    NSDictionary *typeDic = [self.typeResponse.driTypeAry objectAtIndex:position];
    NSString *key = [[typeDic allKeys]objectAtIndex:0];
    NSString *valueType = [NSString stringWithFormat:@"%@",[typeDic objectForKey:key]];
    self.searchType = valueType ;
    [HttpRequestComm getDrinksList:self.keyword andTopType:valueType atIndex:self.currentPage withDelegate:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tagView.frame = CGRectMake(btn.frame.origin.x, 0, btn.frame.size.width, 40);
    }];
}

/*
 * 酒水的搜索
 */
-(IBAction)searchClickEvent:(id)sender {
    if (self.keywordTF.text == nil||[self.keywordTF.text isEqualToString:@""])
    {
        [self showToast:@"请输入商品名称"];
    }
    else
    {
        [SVProgressHUD show];
        self.keyword = self.keywordTF.text ;
        if(self.keyword == nil) self.keyword = @"";
        self.currentPage = 1 ;
        [self.keywordTF resignFirstResponder];
        [self.winAry removeAllObjects];
        [HttpRequestComm getDrinksList:self.keyword andTopType:self.searchType atIndex:self.currentPage withDelegate:self];
    }
}

#pragma mark -UITableViewDelegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.winAry count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.winAry count] == indexPath.row+1) return 71;
    return 70 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddDrinkCell *cell = (AddDrinkCell*)[tableView dequeueReusableCellWithIdentifier:@"AddWineCell"];
    if(cell == nil){
        cell = [[AddDrinkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddWineCell"];
    }
    WineElement *wineElement = [self.winAry objectAtIndex:indexPath.row];
    [ConUtils checkFileWithURLString:wineElement.goodsImg withImageView:cell.goodImg withDirector:@"Wine" withDefaultImage:@"con_wear.png"];
    cell.goodNameLabel.text = wineElement.goodsName;
    cell.goodPriceLabel.text = [NSString stringWithFormat:@"%@元/%@",wineElement.goodsPrice,wineElement.unit];
    if ([wineElement.goodsNumber integerValue]>0)
    {
        [cell.goodReduceBtn setBackgroundImage:[UIImage imageNamed:@"con_drink_reduce.png"] forState:UIControlStateNormal];
        cell.goodCountLabel.text = wineElement.goodsNumber;
    }
    [cell.goodReduceBtn addTarget:self action:@selector(reduceDrinkClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    cell.goodReduceBtn.tag = 3000 +indexPath.row ;
    [cell.goodAddBtn addTarget:self action:@selector(addDrinkClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    cell.goodAddBtn.tag = 2000 + indexPath.row ;
    return cell ;
}

/*
 * 添加酒水数
 */
-(void) addDrinkClickEvent:(id) sender {
    UIButton *btn = (UIButton *)sender ;
    NSInteger tagValue = btn.tag ;
    NSInteger row  = tagValue - 2000 ;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    AddDrinkCell *cell = (AddDrinkCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    NSString *countsStr = cell.goodCountLabel.text ;
    NSInteger counts = [countsStr integerValue] +1 ;
    WineElement *wineElement = [self.winAry objectAtIndex:row];
    wineElement.goodsNumber = [NSString stringWithFormat:@"%d",counts] ;
    cell.goodCountLabel.text = wineElement.goodsNumber ;
    [cell.goodReduceBtn setBackgroundImage:[UIImage imageNamed:@"con_drink_reduce.png"] forState:UIControlStateNormal];
    
    BOOL isExit = YES ;
    for (WineElement *element  in self.addWineAry) {
        if([element.goodsId isEqualToString:wineElement.goodsId]){
            element.goodsNumber = wineElement.goodsNumber;
            isExit = NO ;
            break;
        }
    }
    if(isExit) [self.addWineAry addObject:wineElement];
    [self resetDrinkContent];
    self.addDrinkInfoLa.text = [self getAddDrinkInfo];
    self.totalLa.text = [NSString stringWithFormat:@"%@元",[self getAddDrinkTotalPrice]];
}

- (void)resetDrinkContent
{
    CGSize textSize = [[self getAddDrinkInfo] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(300, 300)];
    int textHeight = textSize.height;
    if (textHeight>20)
    {
        if (textHeight > lastHeight)
        {
            if (lastHeight==0)
            {
                self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-textHeight+20);
                self.bottomView.frame = CGRectMake(0, self.bottomView.frame.origin.y-textHeight+21, 320, self.bottomView.frame.size.height+textHeight-20);
                self.bottomBakImage.frame = CGRectMake(0, 0, 320, self.bottomView.frame.size.height);
                self.addDrinkInfoLa.frame = CGRectMake(10, self.addDrinkInfoLa.frame.origin.y, 300,textHeight+1);
            }
            else
            {
                self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-textHeight+lastHeight);
                self.bottomView.frame = CGRectMake(0, self.bottomView.frame.origin.y-textHeight+lastHeight, 320, self.bottomView.frame.size.height+textHeight-lastHeight);
                self.bottomBakImage.frame = CGRectMake(0, 0, 320, self.bottomView.frame.size.height);
                self.addDrinkInfoLa.frame = CGRectMake(10, self.addDrinkInfoLa.frame.origin.y, 300,textHeight+1);
            }
            lastHeight = textHeight;
        }
    }
}

/*
 * 减少酒水数
 */
-(void) reduceDrinkClickEvent:(id) sender {
    UIButton *btn = (UIButton *)sender ;
    NSInteger tagValue = btn.tag ;
    NSInteger row  = tagValue - 3000 ;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    AddDrinkCell *cell = (AddDrinkCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    NSString *countsStr = cell.goodCountLabel.text ;
    NSInteger counts = [countsStr integerValue];
    WineElement *wineElement = [self.winAry objectAtIndex:row];
    if(counts <=1){
        for (WineElement *element in self.addWineAry) {
            if([element.goodsId isEqualToString:wineElement.goodsId]){
                [self.addWineAry removeObject:element];
                [cell.goodReduceBtn setBackgroundImage:[UIImage imageNamed:@"con_drink_reduceNo.png"] forState:UIControlStateNormal];
                wineElement.goodsNumber = [NSString stringWithFormat:@"%d",counts-1] ;
                cell.goodCountLabel.text = wineElement.goodsNumber ;
                [self resetDrinkContentOther];
                self.addDrinkInfoLa.text = [self getAddDrinkInfo];
                self.totalLa.text = [NSString stringWithFormat:@"%@元",[self getAddDrinkTotalPrice]];
                break;
            }
        }
        return ;
    }else{
        for (WineElement *element in self.addWineAry) {
            if([element.goodsId isEqualToString:wineElement.goodsId]){
                NSInteger counts = [wineElement.goodsNumber integerValue] - 1;
                wineElement.goodsNumber = [NSString stringWithFormat:@"%d",counts];
                element.goodsNumber = wineElement.goodsNumber ;
            }
        }
    }
   
    wineElement.goodsNumber = [NSString stringWithFormat:@"%d",counts-1] ;
    cell.goodCountLabel.text = wineElement.goodsNumber ;
    [self resetDrinkContentOther];
    self.addDrinkInfoLa.text = [self getAddDrinkInfo];
    self.totalLa.text = [NSString stringWithFormat:@"%@元",[self getAddDrinkTotalPrice]];
}

- (void)resetDrinkContentOther
{
    CGSize textSize = [[self getAddDrinkInfo] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(300, 300)];
    int textHeight = textSize.height;
    if (textHeight>20)
    {
        if (textHeight < lastHeight)
        {
            self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-textHeight+lastHeight);
            self.bottomView.frame = CGRectMake(0, self.bottomView.frame.origin.y-textHeight+lastHeight, 320, self.bottomView.frame.size.height+textHeight-lastHeight);
            self.bottomBakImage.frame = CGRectMake(0, 0, 320, self.bottomView.frame.size.height);
            self.addDrinkInfoLa.frame = CGRectMake(10, self.addDrinkInfoLa.frame.origin.y, 300,textHeight+1);
            lastHeight = textHeight;
        }
    }
    else
    {
        if (lastHeight!=0)
        {
            self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height-textHeight+20);
            self.bottomView.frame = CGRectMake(0, self.bottomView.frame.origin.y-textHeight+20, 320, self.bottomView.frame.size.height+textHeight-20);
            self.bottomBakImage.frame = CGRectMake(0, 0, 320, self.bottomView.frame.size.height);
            self.addDrinkInfoLa.frame = CGRectMake(10, self.addDrinkInfoLa.frame.origin.y, 300,20);
            lastHeight = 0;
        }
    }
}

/*
 * 酒水信息的拼装方法
 */
-(NSString *) getAddDrinkInfo {
    NSString *addDrinkInfo = @"";
    for (WineElement *wineElement in self.addWineAry) {
        NSString *wineInfo = [NSString stringWithFormat:@"%@x%@ ",wineElement.goodsName,wineElement.goodsNumber];
        addDrinkInfo = [addDrinkInfo stringByAppendingString:wineInfo];
    }
    return addDrinkInfo;
}

/*
 * 酒水总价的计算方法
 */
-(NSString *) getAddDrinkTotalPrice {
    NSInteger totalPrice = 0;
    for (WineElement *wineElement in self.addWineAry) {
        NSString *goodsNumber = wineElement.goodsNumber ;
        NSString *goodsPrice = wineElement.goodsPrice ;
        NSInteger number = [goodsNumber integerValue];
        NSInteger price = [goodsPrice integerValue];
        totalPrice = number * price +totalPrice;
    }
    return [NSString stringWithFormat:@"%d",totalPrice];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //数据分页加载
    if(self.tableView.contentOffset.y == (self.tableView.contentSize.height - self.tableView.frame.size.height)){
        if(self.drinkResponse.totalPage > self.currentPage)
        {
            self.currentPage ++ ;
            [HttpRequestComm getDrinksList:@"" andTopType:self.searchType atIndex:self.currentPage withDelegate:self];
        }
    }
}

#pragma  mark - HttpRequestCommDelegate
-(void) httpRequestSuccessComm:(int)tagId withInParams:(id)inParam {
    [SVProgressHUD dismiss];
    switch (tagId) {
        case GOODSTYPELIST:{
            self.typeResponse = [[DrinkTypeResponse alloc] init];
            [self.typeResponse setResultData:inParam];
            if(self.typeResponse.code == 0){
                if(self.typeResponse.driTypeAry != nil && [self.typeResponse.driTypeAry count]>0){
                    [self addConditionTypeView:self.typeResponse.driTypeAry];
                }
            }
        }
            break;
        case SEARCHDRINKLIST:{
            self.infoLabel.hidden = YES;
            self.drinkResponse = [[AddDrinkResponse alloc] init];
            [self.drinkResponse setResultData:inParam];
            if(self.drinkResponse.code == 0){
                if(self.drinkResponse.winAry != nil && [self.drinkResponse.winAry count]>0){
                    [self.winAry addObjectsFromArray:self.drinkResponse.winAry];
                    
                    for (WineElement *element in self.drinkResponse.winAry) {
                        for (WineElement *addElement in self.addWineAry) {
                            if([element.goodsId isEqualToString:addElement.goodsId]){
                                element.goodsNumber = addElement.goodsNumber ;
                            }
                        }
                    }
                    [self.tableView reloadData];
                    if(self.currentPage == self.drinkResponse.totalPage){
                        [self.tableView.tableFooterView removeFromSuperview];
                        self.tableView.tableFooterView = [[LoadingView alloc]initType:1];
                    }
                }else{
                    [self.tableView reloadData];
                    [self.tableView.tableFooterView removeFromSuperview];
                    self.infoLabel.hidden = NO;
                    //self.tableView.tableFooterView = [[LoadingView alloc]initType:1];
                }
            }
        }
            break;
    }
}

/*
 * 添加条件选择视图
 */
-(void) addConditionTypeView:(NSArray *) ary {
    for (int i = 0; i<[ary count]; i++) {
        NSDictionary *typeDic = [ary objectAtIndex:i];
        NSString *keyName = [[typeDic allKeys] objectAtIndex:1];
        NSString *valueName = [typeDic objectForKey:keyName];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(75*i, 0, 73, 40);
        [btn setTitle:valueName forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:SELECTED_TAG_COLOR forState:UIControlStateSelected];
        btn.titleLabel.font = [ConUtils boldAndSizeFont:12];
        btn.tag = 200 + i ;
        [btn addTarget:self action:@selector(selectClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        if(i==0){
            self.currentSelBtn = btn ;
            self.currentSelBtn.selected = YES ;
            self.tagView = [[UIImageView alloc] init];
            [self.tagView setImage:[UIImage imageNamed:@"m_cursor_ic.png"]];
            self.tagView.frame = CGRectMake(btn.frame.origin.x, 0, btn.frame.size.width, 40);
            [self.scrollView addSubview:self.tagView];
        }
    }
    
    if([ary count]>4){
        self.scrollView.contentSize = CGSizeMake(75*[ary count], 40);
    }
    
    NSDictionary *typeDic = [self.typeResponse.driTypeAry objectAtIndex:0];
    NSString *key = [[typeDic allKeys]objectAtIndex:0];
    NSString *valueType = [NSString stringWithFormat:@"%@",[typeDic objectForKey:key]];
    self.searchType = valueType ;
    [HttpRequestComm getDrinksList:@"" andTopType:self.searchType atIndex:self.currentPage withDelegate:self];
}

-(void) httpRequestFailueComm:(int)tagId withInParams:(NSString *)error {
    [SVProgressHUD dismiss];
    [self showToast:@"网络异常，请稍后重试"];
}

- (void)popViewController
{
    [SVProgressHUD dismiss];
    [super popViewController];
}

- (void)confirmButtonAction:(id)sender
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:ADDDRINKREFRESH object:self.addWineAry];
    [self.delegate addDrink:self.addWineAry];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
