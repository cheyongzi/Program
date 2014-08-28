//
//  DrinkViewController.m
//  Booking
//
//  Created by jinchenxin on 14-6-28.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "DrinkViewController.h"
#import "DrinkCell.h"

/*
 * 酒水列表
 */
@interface DrinkViewController ()

@end

@implementation DrinkViewController

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
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    infoLabel.text = @"暂未添加酒水";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:infoLabel];
    if ([self.drinkAry count]!=0&&self.drinkAry!=nil) {
        infoLabel.hidden = YES;
    }
    
    self.title = @"酒水列表";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.tableView.frame = CGRectMake(0, 0, 320, APPLICATION_HEIGHT-44);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDelegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.drinkAry count] ;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70 ;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DrinkCell *cell = nil ;
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DrinkCell" owner:self options:nil] objectAtIndex:0];
        WineElement *element = [self.drinkAry objectAtIndex:indexPath.row];
        [cell setDrinkCellData:element];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 69, 320, 1)];
        label.backgroundColor = [UIColor lightGrayColor];
        [cell addSubview:label];
    }
    
    return cell ;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
