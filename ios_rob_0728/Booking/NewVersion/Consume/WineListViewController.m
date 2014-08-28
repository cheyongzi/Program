//
//  WineListViewController.m
//  Booking
//
//  Created by 1 on 14-7-28.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "WineListViewController.h"
#import "WineElement.h"
#import "UIImageView+AFNetworking.h"
#import "DrinkCell.h"

@interface WineListViewController ()

@end

@implementation WineListViewController

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
    
    self.title = @"酒水清单";
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    infoLabel.text = @"暂未添加酒水";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:infoLabel];
    if ([self.dataArray count]!=0&&self.dataArray!=nil) {
        infoLabel.hidden = YES;
    }
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, APPLICATION_HEIGHT-44)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndextify = @"WineListCell";
    DrinkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndextify];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DrinkCell" owner:self options:nil] objectAtIndex:0];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 1)];
        label.backgroundColor = LOAD_SEPERATE_COLOR;
        [cell addSubview:label];
    }
    WineElement *element = [self.dataArray objectAtIndex:[indexPath row]];
    [ConUtils checkFileWithURLString:element.goodsImg withImageView:cell.picImg withDirector:@"Wine" withDefaultImage:@"con_wear.png"];
    cell.nameLa.text = element.goodsName;
    cell.priceLa.text = [NSString stringWithFormat:@"%@%@",element.goodsNumber,element.unit];
    cell.totalPriceLa.text = [NSString stringWithFormat:@"总价:%.2f元",[element.goodsNumber integerValue]*[element.goodsPrice floatValue]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
