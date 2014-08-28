//
//  AreSelecteView.h
//  Booking
//
//  Created by jinchenxin on 14-6-23.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AreSelecteDelegate <NSObject>

-(void) areSelectedIndex:(NSInteger) position ;

@end

@interface AreSelecteView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) IBOutlet UITableView *tableView ;
@property (strong ,nonatomic) NSMutableArray *areAry ;
@property (strong ,nonatomic) id<AreSelecteDelegate> delegate ;


@end
