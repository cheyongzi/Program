//
//  ConditionView.m
//  Booking
//
//  Created by jinchenxin on 14-7-2.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ConditionView.h"
#import "ParamElement.h"
#import "TypeButton.h"
#import "ConstantField.h"
#import "SharedUserDefault.h"

@implementation ConditionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void) initConditionView {
    [self addCountTypeView];
    [self addTimeTypeView];
    [self addMoneyTypeView];
    [self setBackgroundImage];
    self.submitBtn.layer.cornerRadius = 5 ;
    self.conView.frame = CGRectMake(0, -self.conView.frame.size.height,self.conView.frame.size.width , self.conView.frame.size.height);
    [UIView animateWithDuration:0.3 animations: ^{
        self.conView.frame = CGRectMake(0, 0,self.conView.frame.size.width , self.conView.frame.size.height);
    }];
}

-(void) setBackgroundImage {
    self.timeImg.image = [[UIImage imageNamed:@"com_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    self.countImg.image = [[UIImage imageNamed:@"com_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    self.moneyImg.image = [[UIImage imageNamed:@"com_con_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
}

/*
  * 添加人数选择视图
  */
-(void) addCountTypeView{
    NSArray *ary = [[SharedUserDefault sharedInstance] getSystemType:@"Volume"];
    for (int i = 0; i<[ary count]; i++) {
        ParamElement *element = [ary objectAtIndex:i];
        TypeButton *btn = [[TypeButton alloc] init];
        btn.frame = CGRectMake(75*i, 1, 73, 37);
        if(i == 0) btn.frame = CGRectMake(2, 1, 73, 37);
        [btn setTitle:element.paramName forState:UIControlStateNormal];
        btn.tag = 200 + i ;
        [btn addTarget:self action:@selector(selectClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){
            self.curCountBtn = btn ;
            self.curCountBtn.selected = YES ;
            self.countTagView = [[UIView alloc] init];
            self.countTagView.backgroundColor = SELECTED_TAG_COLOR;
            self.countTagView.frame = btn.frame ;
            [self.countScrollView addSubview:self.countTagView];
        }
        [self.countScrollView addSubview:btn];
    }
    
    if([ary count] > 4){
        self.countScrollView.contentSize = CGSizeMake(75*[ary count], 40);
        self.countScrollView.showsHorizontalScrollIndicator = NO ;
    }
}

-(void)selectClickEvent:(id)sender {
    UIButton *btn = (UIButton *)sender ;
    self.curCountBtn.selected = NO ;
    self.curCountBtn = btn ;
    self.curCountBtn.selected = YES ;
    //NSInteger position = btn.tag - 200 ;
    //NSArray *countsAry = [[SharedUserDefault sharedInstance] getSystemType:@"Volume"];
    //ParamElement *element = [countsAry objectAtIndex:position];
    [UIView animateWithDuration:0.3 animations:^{
        self.countTagView.frame = btn.frame ;
    }];
}

/*
 * 时间类型的添加
 */
-(void) addTimeTypeView {
    NSArray *ary = [[SharedUserDefault sharedInstance] getSystemType:@"Volume"];
    for (int i = 0; i<[ary count]; i++) {
        ParamElement *element = [ary objectAtIndex:i];
        TypeButton *btn = [[TypeButton alloc] init];
        btn.frame = CGRectMake(75*i, 1, 73, 37);
        if(i == 0) btn.frame = CGRectMake(2, 1, 73, 37);
        [btn setTitle:element.paramName forState:UIControlStateNormal];
        btn.tag = 200 + i ;
        [btn addTarget:self action:@selector(selectClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){
            self.curTimeBtn = btn ;
            self.curTimeBtn.selected = YES ;
            self.timeTagView = [[UIView alloc] init];
            self.timeTagView.backgroundColor = SELECTED_TAG_COLOR;
            self.timeTagView.frame = btn.frame ;
            [self.timeScrollView addSubview:self.timeTagView];
        }
        [self.timeScrollView addSubview:btn];
    }
    
    if([ary count] > 4){
        self.timeScrollView.contentSize = CGSizeMake(75*[ary count], 40);
        self.timeScrollView.showsHorizontalScrollIndicator = NO ;
    }
}

/*
 * 消费金额的添加
 */
-(void) addMoneyTypeView {
    NSArray *ary = [[SharedUserDefault sharedInstance] getSystemType:@"Volume"];
    for (int i = 0; i<[ary count]; i++) {
        ParamElement *element = [ary objectAtIndex:i];
        TypeButton *btn = [[TypeButton alloc] init];
        btn.frame = CGRectMake(75*i, 1, 73, 37);
        if(i == 0) btn.frame = CGRectMake(2, 1, 73, 37);
        [btn setTitle:element.paramName forState:UIControlStateNormal];
        btn.tag = 200 + i ;
        [btn addTarget:self action:@selector(selectClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){
            self.curMoneyBtn = btn ;
            self.curMoneyBtn.selected = YES ;
            self.moneyTagView = [[UIView alloc] init];
            self.moneyTagView.backgroundColor = SELECTED_TAG_COLOR;
            self.moneyTagView.frame = btn.frame ;
            [self.moneyScrollView addSubview:self.moneyTagView];
        }
        [self.moneyScrollView addSubview:btn];
    }
    
    if([ary count] > 4){
        self.moneyScrollView.contentSize = CGSizeMake(75*[ary count], 40);
        self.moneyScrollView.showsHorizontalScrollIndicator = NO ;
    }
}

-(void) dismissConditionView {
    self.picImg.alpha = 0 ;
    [UIView animateWithDuration:0.3 animations: ^{
        self.conView.frame = CGRectMake(0, -self.conView.frame.size.height,self.conView.frame.size.width , self.conView.frame.size.height);
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

-(IBAction) submitClickEvent:(id) sender {
    [self dismissConditionView];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissConditionView];
    [self.delegate conditionViewDismiss];
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
