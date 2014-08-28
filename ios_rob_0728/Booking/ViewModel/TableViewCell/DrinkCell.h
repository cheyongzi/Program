//
//  DrinkCell.h
//  Booking
//
//  Created by jinchenxin on 14-6-28.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WineElement.h"

@interface DrinkCell : UITableViewCell

@property (strong ,nonatomic) IBOutlet UIImageView *picImg ;
@property (strong ,nonatomic) IBOutlet UILabel *nameLa ;
@property (strong ,nonatomic) IBOutlet UILabel *priceLa ;
@property (strong ,nonatomic) IBOutlet UILabel *totalPriceLa ;

-(void) setDrinkCellData:(WineElement *) element ;

@end
