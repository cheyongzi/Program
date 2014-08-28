
//
//  MerchatCell.m
//  Booking
//
//  Created by jinchenxin on 14-6-17.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "MerchatCell.h"
#import "UIImageView+WebCache.h"
#import "HttpRequestField.h"
#import "ConUtils.h"
#import "SharedUserDefault.h"
#import "BMKGeometry.h"

@implementation MerchatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"MerchatCell" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

/*
 * 设置Cell视图的数据内容
 */
-(void) setMerchatCellData:(ProviderElement *) providerElement {
//    NSString *picUrl = [NSString stringWithFormat:@"%@/mobile%@",FILESERVER,providerElement.shopImgUrl];
//    [self.picImg setImageWithURL:[NSURL URLWithString:picUrl]];
    [ConUtils checkFileWithURLString:providerElement.shopImgUrl withImageView:self.picImg withDirector:@"Shop" withDefaultImage:@"defaultImg.png"];
    self.nameLa.text = providerElement.shopName ;
    self.addressLa.text = providerElement.shopAddress ;
    if ([[SharedUserDefault sharedInstance] getLongitude]!=nil&&![[[SharedUserDefault sharedInstance] getLongitude] isEqualToString:@""]&&[[SharedUserDefault sharedInstance] getLatitude]!=nil&&![[[SharedUserDefault sharedInstance] getLatitude] isEqualToString:@""])
    {
        if ([providerElement longitude]!=nil&&![[providerElement longitude] isEqualToString:@""]&&[providerElement latitude]!=nil&&![[providerElement latitude] isEqualToString:@""])
        {
            BMKMapPoint userPoint = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([[[SharedUserDefault sharedInstance] getLatitude] doubleValue], [[[SharedUserDefault sharedInstance] getLongitude] doubleValue]));
            BMKMapPoint shopPoint = BMKMapPointForCoordinate(CLLocationCoordinate2DMake([providerElement.latitude doubleValue],[providerElement.longitude doubleValue]));
            CLLocationDistance distance = BMKMetersBetweenMapPoints(userPoint, shopPoint);
            //self.distanceBtn.titleLabel.text = distance>1000?[NSString stringWithFormat:@"%dkm",(int)distance/1000]:[NSString stringWithFormat:@"%dm",(int)distance];
            if (distance>1000) {
                distance = distance/1000;
                if (distance>10) {
                    self.distanceLabel.text = @"10km以上";
                }
                else
                {
                    self.distanceLabel.text = [NSString stringWithFormat:@"%dkm",(int)distance];
                }
            }
            else
            {
                self.distanceLabel.text = [NSString stringWithFormat:@"%dm",(int)distance];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
