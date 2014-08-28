//
//  SelectUnitView.m
//  RobShop
//
//  Created by 1 on 14-7-7.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "SelectUnitView.h"
#import "ConstantField.h"

#define ALERT_BUTTON_TAG 1000
#define TABLE_VIEW_TAG   2000

@implementation SelectUnitView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
   withParamArrOne:(NSArray *)arrayOne
   withParamArrTwo:(NSArray *)arrayTwo
         withTitle:(NSString *)titleStr
withTableOneSelect:(int)selectIndex1
withTableSecondSelect:(int)selectIndex2
{
    if (self = [super initWithFrame:frame])
    {
        array1 = arrayOne;
        array2 = arrayTwo;
        
        self.cellSelectedIndex1 = selectIndex1;
        self.cellSelectedIndex2 = selectIndex2;
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
        [img setBackgroundColor:ALERT_BACKGROUND_COLOR];
        [img setAlpha:0.4];
        [img setUserInteractionEnabled:YES];
        [self addSubview:img];
        
        [self initHeaderWithTitle:titleStr withPoint:CGPointMake(10, 70)];
        
        [self initTableViewWithPoint:CGPointMake(10, 70)];
    }
    return self;
}

- (void)initTableViewWithPoint:(CGPoint)point
{
    [self addTableView:self.myTableView1 withFrame:CGRectMake(point.x, point.y+40, 150, 150) withTag:TABLE_VIEW_TAG + 1];
    
    [self addTableView:self.myTableView2 withFrame:CGRectMake(point.x+150, point.y+40, 150, 150) withTag:TABLE_VIEW_TAG + 2];
}

- (void)addTableView:(UITableView *)tableView withFrame:(CGRect)frame withTag:(int)tag
{
    tableView = [[UITableView alloc] initWithFrame:frame];
    if (tag - TABLE_VIEW_TAG == 2)
    {
        tableView.contentOffset = CGPointMake(0, 50*self.cellSelectedIndex2-50);
    }
    tableView.backgroundColor = [UIColor clearColor];
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tag = tag;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
}

//初始化公共的Header，确认和取消按钮
- (void)initHeaderWithTitle:(NSString *)title withPoint:(CGPoint)point
{
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(point.x,point.y, 300, 40)];
    [headerLabel setBackgroundColor:ALERT_HEADER_COLOR];
    [headerLabel setText:title];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:headerLabel];
    
    UIImageView *contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y+40, 300, 150)];
    [contentImg setBackgroundColor:[UIColor colorWithRed:0.941 green:0.941 blue:0.941 alpha:1]];
    [self addSubview:contentImg];
    
    UIButton *confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirBtn setFrame:CGRectMake(point.x, point.y+190, 150, 40)];
    [confirBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirBtn setBackgroundColor:ALERT_CONFIRM_COLOR];
    [confirBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    confirBtn.tag = ALERT_BUTTON_TAG + 1;
    [self addSubview:confirBtn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(point.x+150, point.y+190, 150, 40)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = ALERT_BUTTON_TAG + 2;
    [cancelBtn setBackgroundColor:ALERT_CANCEL_COLOR];
    [self addSubview:cancelBtn];
}

//弹出框确认和取消按钮单机事件
- (void)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag - ALERT_BUTTON_TAG) {
        case 1:
            [self.delegate selectFirstTable:[array1 objectAtIndex:self.cellSelectedIndex1] secondeTable:[array2 objectAtIndex:self.cellSelectedIndex2]];
            break;
        case 2:
            break;
            
        default:
            break;
    }
    [self removeFromSuperview];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    if (tableView.tag - TABLE_VIEW_TAG == 1)
    {
        [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellSelectedIndex1 inSection:0]].textLabel setTextColor:TITLE_LABEL_COLOR];
        [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellSelectedIndex1 inSection:0]].textLabel setFont:[UIFont systemFontOfSize:16]];
        self.cellSelectedIndex1 = [indexPath row];
        firstStr = text;
    }
    else
    {
        [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellSelectedIndex2 inSection:0]].textLabel setTextColor:TITLE_LABEL_COLOR];
        [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellSelectedIndex2 inSection:0]].textLabel setFont:[UIFont systemFontOfSize:16]];
        self.cellSelectedIndex2 = [indexPath row];
        secondStr = text;
    }
    [[tableView cellForRowAtIndexPath:indexPath].textLabel setFont:[UIFont systemFontOfSize:22]];
    [[tableView cellForRowAtIndexPath:indexPath].textLabel setTextColor:[UIColor blackColor]];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag - TABLE_VIEW_TAG == 1)
    {
        return [array1 count];
    }
    else
    {
        return [array2 count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *unitCellIndentify = @"UnitCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unitCellIndentify];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unitCellIndentify];
    }
    NSString *cellText = nil;
    if (tableView.tag - TABLE_VIEW_TAG == 1)
    {
        cellText = [array1 objectAtIndex:[indexPath row]];
        if ([indexPath row]==self.cellSelectedIndex1)
        {
            [cell.textLabel setFont:[UIFont systemFontOfSize:22]];
            [cell.textLabel setTextColor:[UIColor blackColor]];
        }
        else
        {
            [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
            [cell.textLabel setTextColor:TITLE_LABEL_COLOR];
        }
    }
    else
    {
        cellText = [array2 objectAtIndex:[indexPath row]];
        if ([indexPath row]==self.cellSelectedIndex2)
        {
            [cell.textLabel setFont:[UIFont systemFontOfSize:22]];
            [cell.textLabel setTextColor:[UIColor blackColor]];
        }
        else
        {
            [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
            [cell.textLabel setTextColor:TITLE_LABEL_COLOR];
        }
    }
    cell.textLabel.text = cellText;
    cell.backgroundColor = [UIColor colorWithRed:0.953 green:0.945 blue:0.949 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    UITableView *tableView = (UITableView *)scrollView;
    int index = tableView.contentOffset.y/50;
    tableView.contentOffset = CGPointMake(0, index*50);
    [self resetTableView:tableView withIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableView *tableView = (UITableView *)scrollView;
    if ((int)tableView.contentOffset.y%50 == 0)
    {
        int index = tableView.contentOffset.y/50;
        [self resetTableView:tableView withIndex:index];
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    UITableView *tableView = (UITableView *)scrollView;
    int index = tableView.contentOffset.y/50;
    tableView.contentOffset = CGPointMake(0, index*50);
    [self resetTableView:tableView withIndex:index];
}

- (void)resetTableView:(UITableView *)tableView withIndex:(int)index
{
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellSelectedIndex2 inSection:0]].textLabel setTextColor:TITLE_LABEL_COLOR];
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellSelectedIndex2 inSection:0]].textLabel setFont:[UIFont systemFontOfSize:16]];
    self.cellSelectedIndex2 = index+1;
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellSelectedIndex2 inSection:0]].textLabel setFont:[UIFont systemFontOfSize:22]];
    [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.cellSelectedIndex2 inSection:0]].textLabel setTextColor:[UIColor blackColor]];
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
