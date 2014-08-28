//
//  DatePickerView.h
//  Booking
//
//  Created by jinchenxin on 13-11-22.
//  Copyright (c) 2013年 jinchenxin. All rights reserved.
//

/*
 此类主要是用于picker的模式化，牵涉到ktv场次选择等各种选择，都可复用
 datepicker用于关于日期选择的复用
 */

#import <UIKit/UIKit.h>

@protocol ShowValueDelegate <NSObject>

-(void)completeChoose:(UIView *)pickerView;

@end

@interface PickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak   , nonatomic) id<ShowValueDelegate> delegate;
@property (strong , nonatomic) UIPickerView * pickerView;
@property (strong , nonatomic) NSString * value;
@property (strong , nonatomic) NSMutableArray * dataArray;
@end

@interface DatePickerView : UIView
@property (weak   , nonatomic) id<ShowValueDelegate> delegate;
@property (strong , nonatomic) NSString * dateValue;
@property (strong , nonatomic) UIDatePicker * datePicker;
@end

