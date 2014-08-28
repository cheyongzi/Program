//
//  ConUtils.m
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "ConUtils.h"
#import "Reachability.h"
#import "SharedUserDefault.h"
#import <CoreLocation/CoreLocation.h>
#import "HttpRequestField.h"

@implementation ConUtils

/*
 * 自定义加粗字体类
 * @sizeValue 字体的大小
 */
+(UIFont *)boldAndSizeFont:(int) sizeValue{
    UIFont *font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:sizeValue];
    return font ;
}

/*
 * 时间的转换yyyy-MM-dd
 */
+(NSString *) getyyyyMMddSpaceTime :(NSDate *) date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getyyyMMddHHmmSpaceTime :(NSDate *)date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}


/*
 * 时间转换为hh:mm
 */
+(NSString *) getHHmmTime:(NSDate *) date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:date];
}

/*
 * 时间转换yyyyMMddHHmm
 */
+(NSString *) getyyyyMMddTime:(NSString *) timeStr {
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    return timeStr ;
}

/*
 * 时间日期转换
 */
+(NSString *) getDDMMTime:(NSString *) timeStr {
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd"];
    matter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [matter dateFromString:timeStr];
    [matter setDateFormat:@"MM月dd日"];
    return [matter stringFromDate:date];
}

/*
 * 自定义时长追加的方法
 */
+(NSString *) getHHmmAddTime:(NSString *) timeStr AndTimeLong:(NSString *) timeLong {
    
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"HH:mm"];
    matter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [matter dateFromString:timeStr];
    date = [date dateByAddingTimeInterval:([timeLong integerValue])*60*60];
    NSString *time = [matter stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@-%@",timeStr,time];
}

/*
 * 检查用户网络是否可用
 */
+ (BOOL)checkUserNetwork
{
    BOOL userNetworkReachbility;
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    //Reachability *reachability = [Reachability reachabilityForInternetConnection];
    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
            userNetworkReachbility = NO;
            break;
        case ReachableViaWiFi:
            userNetworkReachbility = YES;
            break;
        case ReachableViaWWAN:
            userNetworkReachbility = YES;
            break;
            
        default:
            break;
    }
    return userNetworkReachbility;
}

/*
 * 类型说明的转换
 */
+(NSString *) convertTypeDetails:(RequireElement *) element {
    NSString *typeDetails = @"";
    
    NSString *typeName = [[SharedUserDefault sharedInstance] getSystemNameType:@"ShopType" andTypeKey:element.shopType];
    NSString *countName = [[SharedUserDefault sharedInstance] getSystemNameType:@"Volume" andTypeKey:element.personId];
    NSString *partyName = [[SharedUserDefault sharedInstance] getSystemNameType:@"PartyType" andTypeKey:element.providerType];
    typeDetails = [NSString stringWithFormat:@"%@ | %@ | %@",typeName,countName,partyName];
    
    return typeDetails ;
}

/*
 * 计算距离的方法
 */
+(NSString *) getDistanceLatA:(double)lat lngA:(double)lng {
    double latA = [[[SharedUserDefault sharedInstance] getLatitude ] floatValue];
    double lngA = [[[SharedUserDefault sharedInstance] getLongitude ] floatValue];
    CLLocation *current = [[CLLocation alloc] initWithLatitude:latA longitude:lngA];
    CLLocation *before = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    CLLocationDistance meters = [current distanceFromLocation:before];
    if(meters/1000 >10){
        return @"10km以上";
    }
    return [NSString stringWithFormat:@"%.2fkm",meters/1000] ;
}

/*
 * 剩余时间的字符组合方法
 */
+(NSString *) getReduceTime:(NSString *) dateStr {
    NSString *timeStr = @"0";
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd HH:mm"];
    matter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [matter dateFromString:dateStr];
    
    long nowValue = [[NSDate date] timeIntervalSince1970];
    long reduceValue = [date timeIntervalSince1970];
    
    long value = (reduceValue - nowValue) ;
    
    if(value <  60){
//        return time = dateStr;
        return @"已过期";
    }
    
    int day = 60 * 60 * 24 ;
    int hour = 60 * 60 ;
    int minute = 60 ;
    
    int days = value / day ;
    NSString *str = @"剩余";
    
    if(days > 0){
        str = [NSString stringWithFormat:@"%@%d天",str,days];
    }
    
    long hours = (value)/hour ;
    if(hours > 0){
        timeStr = @"";
        //str = [NSString stringWithFormat:@"%@%d小时",str,hours];
        timeStr = [NSString stringWithFormat:@"%ld",hours];
    }
    
    int minutes = (value%day)%hour;
    
    //str = [NSString stringWithFormat: @"%@%d分钟",str,(minutes/minute)];
    timeStr = [NSString stringWithFormat:@"%@,%d",timeStr,(minutes/minute)];
    
    return timeStr;
}

/*
 * 发布时间的组合方法
 */
+(NSString *) getSendTime:(NSString *) dateStr {
    NSString *time =@"";
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    matter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date = [matter dateFromString:dateStr];
    
    long nowValue = [[NSDate date] timeIntervalSince1970];
    long reduceValue = [date timeIntervalSince1970];
    
    long value = (nowValue-reduceValue  ) ;
    
    if(value <  60){
        return time = dateStr;
    }
    
    int day = 60 * 60 * 24 ;
    int hour = 60 * 60 ;
    int minute = 60 ;
    
    int days = value / day ;
    NSString *str = @"发布于";
    
    if(days > 0){
        str = [NSString stringWithFormat:@"%@%d天",str,days];
    }
    
    long hours = (value % day)/hour ;
    if(hours > 0){
        str = [NSString stringWithFormat:@"%@%ld小时",str,hours];
    }
    
    int minutes = (value%day)%hour;
    
    str = [NSString stringWithFormat: @"%@%d分钟前",str,(minutes/minute)];
    
    return str;
}

/*
 * 计算内容所占UILabel的宽度
 */
+(CGFloat)labelWidth:(NSString *) contentText withFont:(UIFont *) font {
    CGSize titleSize = [contentText sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    return titleSize.width ;
}

/*
 * 计算内容所占UILabel的高度
 */
+(CGFloat)cellHeight:(NSString*)contentText withWidth:(CGFloat)with withFont:(UIFont *) font {
    CGSize size =[contentText sizeWithFont:font constrainedToSize:CGSizeMake(with, 300000.0f)];
    CGFloat height = size.height + 0.;
    return height;
}

/*
 * 字符串的排序
 */
+(NSString *) stingSort:(NSMutableDictionary *)sortDic {
    NSMutableArray *sortAry = [[NSMutableArray alloc]init];
    NSMutableString *muString = [[NSMutableString alloc]init];
    NSArray *keys = [sortDic allKeys];
    for (NSString *key in keys) {
        [sortAry addObject:[NSString stringWithFormat:@"%@=%@",key,[sortDic objectForKey:key]]];
    }
    NSArray *sortedArray = [sortAry sortedArrayUsingSelector:@selector(compare:)];
    //参数排序字符串
    for (NSString *param in sortedArray) {
        [muString appendString:[NSString stringWithFormat:@"%@&",param]];
    }
    //除去组合字符串后的最后一个&符号
    NSString *parStr = [muString substringToIndex:([muString length]-1)];
    return parStr;
}

/*
 * 图片背景的拉伸处理
 */
+(UIImage *) getImageScale:(NSString *) imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
}

/*
 * 订单类型的转换
 */
+(RequireElement *) convertRequireElement:(OrderElement *)element {
    RequireElement *reElement = [[RequireElement alloc] init];
    reElement.requiredId = element.robId ;
    reElement.robId     = element.orderId;
    reElement.consumDate = element.consumeDate ;
    reElement.personId = element.volumeId;
    reElement.consumInterval = element.consumInterval;
    reElement.offerPrice = element.amounts;
    reElement.count = element.count;
    reElement.logoUrl = element.logo ;
    reElement.verifyCode = element.userCostNum ;
    reElement.arriveTime = element.arriveTime ;
    reElement.hours = element.hours ;
    reElement.contact = element.shopName ;
    reElement.winAry = element.mulArray;
    //reElement.shopType = elemen
    return reElement ;
}

/*
 * 酒水总价的计算方法
 */
+(NSString *) getAddDrinkTotalPrice:(NSMutableArray *) wineAry {
    NSInteger totalPrice = 0;
    for (WineElement *wineElement in wineAry) {
        NSString *goodsNumber = wineElement.goodsNumber ;
        NSString *goodsPrice = wineElement.goodsPrice ;
        NSInteger number = [goodsNumber integerValue];
        NSInteger price = [goodsPrice integerValue];
        totalPrice = number * price +totalPrice;
    }
    return [NSString stringWithFormat:@"%d",totalPrice];
}

/*
 * 酒水总数的计算
 */
+(NSInteger) getDrinkTotalCounts:(NSMutableArray *) winAry {
    NSInteger counts = 0;
    for (WineElement *wineElement in winAry) {
        counts = [wineElement.goodsNumber integerValue]+counts;
    }
    return counts ;
}

+ (void)checkFileWithURLString:(NSString *)logoString withImageView:(UIImageView *)imageView withDirector:(NSString *)director withDefaultImage:(NSString *)defaultImage
{
    if (logoString == nil || [logoString isEqualToString:@""])
    {
        [imageView setImage:[UIImage imageNamed:defaultImage]];
        return;
    }
    NSString *directoryPath = [FILE_PATH stringByAppendingString:[NSString stringWithFormat:@"/%@",director]];
    BOOL isDirectory = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [directoryPath stringByAppendingString:[NSString stringWithFormat:@"/%@",logoString.lastPathComponent]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [imageView setImage:[UIImage imageWithContentsOfFile:filePath]];
    }
    else
    {
        NSString *picUrlString = [NSString stringWithFormat:@"%@/mobile%@",FILESERVER,logoString];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                       {
                           NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrlString]];
                           if (data != nil)
                           {
                               [data writeToFile:filePath atomically:YES];
                               dispatch_sync(dispatch_get_main_queue(), ^(void)
                                             {
                                                 [imageView setImage:[UIImage imageWithData:data]];
                                             });
                           }
                           else
                           {
                               [imageView setImage:[UIImage imageNamed:defaultImage]];
                           }
                       });
    }
}


@end
