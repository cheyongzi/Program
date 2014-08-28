//
//  DatePickerView.m
//  Booking
//
//  Created by jinchenxin on 13-11-22.
//  Copyright (c) 2013年 jinchenxin. All rights reserved.
//

#import "DatePickerView.h"
@implementation PickerView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIToolbar * toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 45) ];
        toolbar.barStyle = UIBarStyleBlack;
        NSMutableArray * array = [[NSMutableArray alloc]init];
        
        UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        [array addObject:barButtonItem];
        
        UIBarButtonItem * doneBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(complete)];
        [array addObject:doneBarButtonItem];
        [toolbar setItems:array];
        
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 45, 320, 216)];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = YES;
        [self addSubview:toolbar];
        [self addSubview:self.pickerView];
        
        
    }
    return self;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 90;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * str = [self.dataArray objectAtIndex:row];
    return str;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.value = [NSString stringWithFormat:@"%d",row];
}

-(void)complete{
    [self.delegate completeChoose:self];
}

@end

@implementation DatePickerView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIToolbar * toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 45) ];
        toolbar.barStyle = UIBarStyleBlack;
        NSMutableArray * array = [[NSMutableArray alloc]init];
        
        for (int i = 0 ; i<4; i++) {
            UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [array addObject:barButtonItem];
        }
        UIBarButtonItem * barButtonItem;

        barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(complete)];
        
        [array addObject:barButtonItem];
        [toolbar setItems:array];
        
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 45, 320, 216)];
        [self.datePicker setMinimumDate:[NSDate date]];
        [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        [self.datePicker addTarget:self action:@selector(keepTheValue:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:toolbar];
        [self addSubview:self.datePicker];
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        self.dateValue = [dateFormatter stringFromDate:self.datePicker.date];
    }
    return self;
}

-(void)complete{
    [self.delegate completeChoose:self];
}

-(void)keepTheValue:(UIDatePicker *)datePicker{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.dateValue = [dateFormatter stringFromDate:datePicker.date];
}

@end
