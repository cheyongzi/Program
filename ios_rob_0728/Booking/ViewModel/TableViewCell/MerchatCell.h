//
//  MerchatCell.h
//  Booking
//
//  Created by jinchenxin on 14-6-17.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProviderElement.h"

@interface MerchatCell : UITableViewCell

@property (strong ,nonatomic) IBOutlet UIImageView *picImg ;
@property (strong ,nonatomic) IBOutlet UILabel *nameLa ;
@property (strong ,nonatomic) IBOutlet UILabel *addressLa ;
@property (strong ,nonatomic) IBOutlet UIButton *distanceBtn ;
@property (strong ,nonatomic) IBOutlet UIButton *selBtn ;

@property (strong ,nonatomic) UIButton  *distanceButton;
@property (strong ,nonatomic) UILabel   *distanceLabel;

/*
 * 设置Cell视图的数据内容
 */
-(void) setMerchatCellData:(ProviderElement *) providerElement ;

@end
