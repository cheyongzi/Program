//
//  SelectUnitView.h
//  RobShop
//
//  Created by 1 on 14-7-7.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectUnitDelegate <NSObject>

- (void)selectFirstTable:(NSString *)firstStr secondeTable:(NSString *)secondStr;

@end

@interface SelectUnitView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *array1;
    NSArray *array2;
    
    NSString        *firstStr;
    NSString        *secondStr;
}

@property (weak,nonatomic) id<SelectUnitDelegate> delegate;

@property (assign,nonatomic) int cellSelectedIndex1;
@property (assign,nonatomic) int cellSelectedIndex2;

@property (strong,nonatomic) UITableView *myTableView1;
@property (strong,nonatomic) UITableView *myTableView2;

-(id)initWithFrame:(CGRect)frame
   withParamArrOne:(NSArray *)arrayOne
   withParamArrTwo:(NSArray *)arrayTwo
         withTitle:(NSString *)titleStr
withTableOneSelect:(int)selectIndex1
withTableSecondSelect:(int)selectIndex2;
@end
