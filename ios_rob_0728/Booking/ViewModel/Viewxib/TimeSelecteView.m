//
//  TimeSelecteView.m
//  Booking
//
//  Created by jinchenxin on 14-7-9.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "TimeSelecteView.h"
#import "ConUtils.h"

@implementation TimeSelecteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) initData {
    self.timeTableView.delegate = self;
    self.timeLongTableView.delegate = self;
    self.timeTableView.dataSource = self;
    self.timeLongTableView.dataSource = self;
    self.timeAry = [[NSMutableArray alloc] init];
    [self.timeAry addObject:@""];
    [self.timeAry addObject:@""];
    for (int i = 0; i<48; i++) {
        NSString *timeStr = @"";
        if(i%2 == 0){
            int hh = i/2 ;
            timeStr = [NSString stringWithFormat:@"%d点",hh];
        }else{
            int hh = i/2 ;
            int mm = 30 ;
            timeStr = [NSString stringWithFormat:@"%d点%d分",hh,mm];
        }
        [self.timeAry addObject:timeStr];
    }
    [self.timeAry addObject:@""];
    [self.timeAry addObject:@""];
    [self.timeAry addObject:@""];
    
    self.timeLongAry = [[NSMutableArray alloc] init];
    [self.timeLongAry addObject:@""];
    [self.timeLongAry addObject:@""];
    for (int i = 0; i<12; i++) {
        NSString *timeLongStr = [NSString stringWithFormat:@"%d小时",i+1];
        [self.timeLongAry addObject:timeLongStr];
    }
    [self.timeLongAry addObject:@""];
    [self.timeLongAry addObject:@""];
    [self.timeLongAry addObject:@""];
    [self.timeTableView reloadData];
    [self.timeLongTableView reloadData];
    
    [self setDefaultPosition];
}

/*
 * 设置选择器的默认位置
 */
-(void) setDefaultPosition {
    
    //拿到当前的时间
    NSDate *date = [NSDate date];
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"HH"];
    NSString *nowTime = [matter stringFromDate:date];
    NSInteger timeInt = [nowTime integerValue]*2+3;
    
    //设置到店默认时间
    NSIndexPath *index = [NSIndexPath indexPathForRow:timeInt inSection:0];
    [self.timeTableView setContentOffset:CGPointMake(0, (timeInt-2)*40)];
    self.selectIndexFirst = timeInt;
    [self.timeTableView cellForRowAtIndexPath:index].textLabel.alpha = 1;
    [self.timeTableView cellForRowAtIndexPath:index].textLabel.font = [ConUtils boldAndSizeFont:20];
    
    //默认时长设置
    NSIndexPath *longIndex = [NSIndexPath indexPathForRow:5 inSection:0];
    [self.timeLongTableView setContentOffset:CGPointMake(0, 3*40)];
    self.selectIndexSecond = 5;
    [self.timeLongTableView cellForRowAtIndexPath:longIndex].textLabel.alpha = 1;
    [self.timeLongTableView cellForRowAtIndexPath:longIndex].textLabel.font = [ConUtils boldAndSizeFont:20];
    
    self.time = [self convertTime:timeInt];
    self.timeLong = @"4";
    
}

/*
 * 确定或取消按钮事件
 */
-(IBAction) clickEvent:(id)sender {
    UIButton *btn = (UIButton *)sender ;
    NSInteger tagValue = btn.tag ;
    switch (tagValue) {
        case 100:{
            [self.delegate timeSelecteViewTime:self.time AndLong:self.timeLong];
        }
            break;
        case 101:{
            [self.delegate timeSelecteViewCancel];
        }
            break;
    }
    [self removeFromSuperview];
}

#pragma mark - UITableViewDelegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView.tag == 200){
        return self.timeAry == nil? 0:[self.timeAry count] ;
    }else{
        return self.timeLongAry == nil? 0:[self.timeLongAry count] ;
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40 ;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeSelectCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimeSelectCell"
                ];
    }
    cell.textLabel.textAlignment = 1 ;
    cell.textLabel.alpha = 0.3 ;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.backgroundColor = [UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1];
    if(tableView.tag == 200){
        cell.textLabel.text = [self.timeAry objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [self.timeLongAry objectAtIndex:indexPath.row];
    }
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tagValue = tableView.tag ;
    switch (tagValue) {
        case 200:{
            NSInteger row = indexPath.row ;
            [self resetTable:tableView withIndex:row withLastIndex:self.selectIndexFirst withTag:200];
        }
            break;
        case 201:{
            [self resetTable:tableView withIndex:[indexPath row] withLastIndex:self.selectIndexSecond withTag:201];
        }
            break;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    UITableView *tableView = (UITableView *)scrollView;
    int index = tableView.contentOffset.y/40;
    tableView.contentOffset = CGPointMake(0, index*40);
    
    NSInteger tagValue = scrollView.tag ;
    if (tagValue == 200) {
        [self resetTable:self.timeTableView withIndex:index+2 withLastIndex:self.selectIndexFirst withTag:200];
    }
    else
    {
        [self resetTable:self.timeLongTableView withIndex:index+2 withLastIndex:self.selectIndexSecond withTag:201];
    }
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    UITableView *tableView = (UITableView *)scrollView;
    if ((int)tableView.contentOffset.y%40 == 0)
    {
        int index = tableView.contentOffset.y/40;
        NSInteger tagValue = scrollView.tag ;
        if (tagValue == 200) {
            [self resetTable:self.timeTableView withIndex:index+2 withLastIndex:self.selectIndexFirst withTag:200];
        }
        else
        {
            [self resetTable:self.timeLongTableView withIndex:index+2 withLastIndex:self.selectIndexSecond withTag:201];
        }
    }
}

- (void)resetTable:(UITableView*)tableView withIndex:(NSInteger)index withLastIndex:(NSInteger)lastIndex withTag:(int)tag
{
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:lastIndex inSection:0]].textLabel setAlpha:0.3];
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:lastIndex inSection:0]].textLabel setFont:[UIFont systemFontOfSize:15]];
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]].textLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]].textLabel setAlpha:1];
    if (tag == 200) {
        self.selectIndexFirst = index;
        
        NSString *timeStr = [self convertTime:index];
        self.time = timeStr ;
    }
    else
    {
        self.selectIndexSecond = index;
        
        NSString *timeLong = [self.timeLongAry objectAtIndex:index];
        timeLong = [timeLong stringByReplacingOccurrencesOfString:@"小时" withString:@""];
        self.timeLong = timeLong ;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    UITableView *tableView = (UITableView *)scrollView;
    int index = tableView.contentOffset.y/40;
    tableView.contentOffset = CGPointMake(0, index*40);
    
    NSInteger tagValue = scrollView.tag ;
    if(tagValue == 200){
        [self resetTable:self.timeTableView withIndex:index+2 withLastIndex:self.selectIndexFirst withTag:200];
    }else{
        [self resetTable:self.timeLongTableView withIndex:index+2 withLastIndex:self.selectIndexSecond withTag:201];
    }
}

/*
 * 时间格式的转换
 */
-(NSString *) convertTime:(NSInteger ) row {
    NSString *timeStr = [self.timeAry objectAtIndex:row];
    if(row % 2 == 0){
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"点" withString:@":"];
        NSInteger timeIn = [timeStr integerValue];
        if(timeIn <10 ){
            timeStr = [NSString stringWithFormat:@"0%@00",timeStr];
        }else{
            timeStr = [NSString stringWithFormat:@"%@00",timeStr];
        }
    }else{
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"点" withString:@":"];
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"分" withString:@""];
        if(row < 23){
            timeStr = [NSString stringWithFormat:@"0%@",timeStr];
        }
    }
    return timeStr ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
