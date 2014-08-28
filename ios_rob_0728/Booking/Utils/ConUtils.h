//
//  ConUtils.h
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequireElement.h"
#import "OrderElement.h"

@interface ConUtils : NSObject

/*
 * 自定义加粗字体类
 * @sizeValue 字体的大小
 */
+(UIFont *)boldAndSizeFont:(int) sizeValue ;

/*
 * 时间的转换yyyy-MM-dd
 */
+(NSString *) getyyyyMMddSpaceTime :(NSDate *) date ;
/**
 *  时间格式转换
 *
 *  @param date 需要转换的时间
 *
 *  @return 转换之后的时间格式
 *
 *  @since 1.0.0
 */
+(NSString *)getyyyMMddHHmmSpaceTime :(NSDate *)date;

/*
 * 时间转换为hh:mm
 */
+(NSString *) getHHmmTime:(NSDate *) date ;

/*
 * 时间转换yyyyMMdd
 */
+(NSString *) getyyyyMMddTime:(NSString *) timeStr ;

/*
 * 自定义时长追加的方法
 */
+(NSString *) getHHmmAddTime:(NSString *) timeStr AndTimeLong:(NSString *) timeLong ;

/*
 * 时间日期转换
 */
+(NSString *) getDDMMTime:(NSString *) timeStr ;

/*
 * 判断用户网络是否可用
 */
+ (BOOL)checkUserNetwork;

/*
 * 类型说明的转换
 */
+(NSString *) convertTypeDetails:(RequireElement *) element ;

/*
 * 计算距离的方法
 */
+(NSString *) getDistanceLatA:(double)lat lngA:(double)lng ;

/*
 * 剩余时间的字符组合方法
 */
+(NSString *) getReduceTime:(NSString *) dateStr ;

/*
 * 发布时间的组合方法
 */
+(NSString *) getSendTime:(NSString *) dateStr ;

/*
 * 计算内容所占UILabel的宽度
 */
+(CGFloat)labelWidth:(NSString *) contentText withFont:(UIFont *) font ;

/*
 * 计算内容所占UILabel的高度
 */
+(CGFloat)cellHeight:(NSString*)contentText withWidth:(CGFloat)with withFont:(UIFont *) font ;

/*
 * 字符串的排序
 */
+(NSString *) stingSort:(NSMutableDictionary *)sortDic ;

/*
 * 图片背景的拉伸处理
 */
+(UIImage *) getImageScale:(NSString *) imageName ;

/*
 * 订单类型的转换
 */
+(RequireElement *) convertRequireElement:(OrderElement *)element ;

/*
 * 酒水总价的计算方法
 */
+(NSString *) getAddDrinkTotalPrice:(NSMutableArray *) wineAry ;

/*
 * 酒水总数的计算
 */
+(NSInteger) getDrinkTotalCounts:(NSMutableArray *) winAry ;

/**
 *  本地缓存图片
 *
 *  @param logoString   图片的URLString
 *  @param imageView    显示的imageView
 *  @param director     本地存储的目录
 *  @param defaultImage 图片下载失败显示的默认图片
 */
+ (void)checkFileWithURLString:(NSString *)logoString withImageView:(UIImageView *)imageView withDirector:(NSString *)director withDefaultImage:(NSString *)defaultImage;

@end
