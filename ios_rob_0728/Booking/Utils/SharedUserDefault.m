//
//  ShareUserDefault.m
//  Booking
//
//  Created by jinchenxin on 14-4-11.
//  Copyright (c) 2014年 jinchenxin. All rights reserved.
//

/*
 *SharedUserDefault 用来存储用户信信息以及本地数据的缓存
 */


#import "SharedUserDefault.h"
#import "ConUtils.h"
#import "JsonUtils.h"

static SharedUserDefault *sharedDefault ;

@implementation SharedUserDefault

-(void)setFirstStartApp:(NSString *)isFirst
{
    [[NSUserDefaults standardUserDefaults] setObject:isFirst forKey:@"IsFirstStartApp"];
}

- (NSString *)isFirstStartApp
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IsFirstStartApp"];
}

+(SharedUserDefault *)sharedInstance{
    if( sharedDefault == nil){
        sharedDefault = [[SharedUserDefault alloc]init];
    }
    return sharedDefault ;
}

/*
 * 用户信息的保存
 */
//-(void)setUserData:(UserInfo *) userInfo {
//    NSData *dataInfo = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
//    [[NSUserDefaults standardUserDefaults] setObject:dataInfo forKey:USERDATA];
//}

/*
 * 拿到用户字典数据内容
 */
//-(UserInfo *) getUserData{
//    NSData *dataInfo = [[NSUserDefaults standardUserDefaults] objectForKey:USERDATA];
//    UserInfo *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:dataInfo];
//    return userInfo != nil? userInfo:nil;
//}

/*
 * 判断用户是否登入状态
 */
-(BOOL)isLogin{
    BOOL state = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userIsLogin"] != nil && [[[NSUserDefaults standardUserDefaults] objectForKey:@"userIsLogin"] isEqualToString:@"Y"])
    {
        state = YES;
    }
    return state;
}

- (BOOL)isUserComment
{
    BOOL state = NO;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"IsCommentAlert"] != nil && [[[NSUserDefaults standardUserDefaults] objectForKey:@"IsCommentAlert"] isEqualToString:@"Y"])
    {
        state = YES;
    }
    return state;
}

- (void)setUserComment:(NSString *)comment
{
    [[NSUserDefaults standardUserDefaults] setObject:comment forKey:@"IsCommentAlert"];
}

/*
 * 设置用户的登陆状态
 */
- (void)setLoginState:(NSString *)state
{
    [[NSUserDefaults standardUserDefaults] setObject:state forKey:@"userIsLogin"];
}

/*
 * 存储用户的信息
 */
- (void)setUserInfo:(NSData *)userElement
{
    [[NSUserDefaults standardUserDefaults] setObject:userElement forKey:@"userInfo"];
}

/*
 * 获取用户的数据
 */
- (UserElement *)getUserInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"]];
}

/*
 * 存储用户绑定的其他帐号的信息
 */
- (void)setUserBindInfo:(NSMutableDictionary *)info withMemberId:(NSString *)memberId
{
    NSDictionary *dic = (NSDictionary *)info;
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[memberId description]];
}

/*
 * 获取用户绑定的其他帐号的信息
 */
- (NSDictionary *)getUserBindInfo:(NSString *)memberId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[memberId description]];
}

/*
 * 用户退出登入状态
 */
-(void)exitLogin{
//    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:USERDATA];
}

/*
 * 拿到用户的Id
 */
-(NSString *)getUserId{
//    NSString *userId = @"";
//    UserInfo * userInfo = [[SharedUserDefault sharedInstance] getUserData];
//    if(userInfo !=nil){
//        userId = userInfo.uid;
//    }
    return @"";
}

/*
 * 拿到用户的名字
 */
-(NSString *)getUserName{
    NSString *userId = @"";
//    NSDictionary * userData = [[SharedUserDefault sharedInstance] getUserData];
//    if(userData !=nil){
////        userId = [userData objectForKey:USERNAME];
//    }
    return userId;
}

/*
 * 拿到用户的电话号码
 */
-(NSString *)getUserTel{
//    NSString *userId = @"";
//    NSDictionary * userData = [[SharedUserDefault sharedInstance] getUserData];
//    if(userData !=nil){
////        userId = [userData objectForKey:USERTEL];
//    }
    return @"";
}

/*
 * 判断是否发送唯一标识及版本状态
 */
-(BOOL) isSendVersionIndentifier {
    BOOL isSendState = NO ;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *sendTimeStr = [userDefault objectForKey:@"sendDate"];
    
    //当前NSDate
    NSDate *date = [NSDate date];
    NSTimeInterval timeStr = [date timeIntervalSince1970];
    if(nil != sendTimeStr && ![@"" isEqualToString:sendTimeStr]){
        NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:[sendTimeStr doubleValue]];
        NSDate *cDate = [sendDate dateByAddingTimeInterval:24*60*60];
        NSDate *eDate = [cDate laterDate:date];
        if([eDate isEqualToDate:date]){
            isSendState = YES;
            [userDefault setObject:[NSString stringWithFormat:@"%f",timeStr] forKey:@"sendDate"];
        }
    }else{
        
        [userDefault setObject:[NSString stringWithFormat:@"%f",timeStr] forKey:@"sendDate"];
        isSendState = YES;
    }
    return isSendState ;
}

/*
 * 设置城市的名称
 */
-(void) setCityName:(NSString *) cityName {
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:CITYNAME];
}

/*
 * 拿到城市名称
 */
-(NSString *) getCityName {
    NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:CITYNAME];
    return cityName ;
}

/*
 * 设置当前位置的经，纬度
 */
-(void) setLatitudeAndLongitude:(NSString *) lat andLat:(NSString *) lon {
    [[NSUserDefaults standardUserDefaults] setObject:lat forKey:LATITUDE];
    [[NSUserDefaults standardUserDefaults] setObject:lon forKey:LONGITUDE];
}

/*
 * 拿到当前的经度
 */
-(NSString *) getLongitude {
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:LONGITUDE];
    return longitude;
}

/*
 * 拿到当前纬度
 */
-(NSString *) getLatitude {
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:LATITUDE];
    return latitude;
}

/*
 * 设置定位的具体位置地址
 */
-(void) setCurrentAddress:(NSString *) address {
    [[NSUserDefaults standardUserDefaults] setObject:address forKey:ADDRESS];
}

/*
 * 拿到上一次定位后的具体地址
 */
-(NSString *) getCurrentAddress  {
    NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:ADDRESS];
    return address ;
}

/*
 * 省份解析
 */
-(NSArray *) getProvincesList {
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"province.txt"];
    [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *textFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];    
    NSArray *citys = [textFile componentsSeparatedByString:@"\n"];
    NSMutableArray *provincesAry = [[NSMutableArray alloc] init];
    for (NSString *content in citys) {
        NSLog(@"%@",content);
        if([content isEqualToString:@""]) break;
        NSString *contentStr = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSArray *provinces = [contentStr componentsSeparatedByString:@";"];
        NSDictionary *proDic = [[NSDictionary alloc] initWithObjectsAndKeys:[provinces objectAtIndex:2],[provinces objectAtIndex:0], nil];
        [provincesAry addObject:proDic];
        
    }
    return provincesAry ;
}

/*
 * 城市文件的解析
 */
-(NSArray *) getCityList {
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"city.txt"];
    [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *textFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *citys = [textFile componentsSeparatedByString:@"\n"];
    NSMutableArray *provincesAry = [[NSMutableArray alloc] init];
    for (NSString *content in citys) {
//        NSLog(@"%@",content);
        if([content isEqualToString:@""]) break;
        NSString *contentStr = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSArray *provinces = [contentStr componentsSeparatedByString:@";"];
        NSDictionary *proDic = [[NSDictionary alloc] initWithObjectsAndKeys:[provinces objectAtIndex:2],[provinces objectAtIndex:1],nil];
        [provincesAry addObject:proDic];
        
    }
    return provincesAry ;
}

/*
 * 省份城市列表
 */
-(NSMutableDictionary *) getProvinceCitysList {
    NSArray *provinces = [self getProvincesList];
    NSMutableArray *provinceKeys = [[NSMutableArray alloc] init];
    for (NSDictionary *provinceDic in provinces) {
        NSString *provinceKey = [[provinceDic allKeys] objectAtIndex:0];
        [provinceKeys addObject:provinceKey];
    }
    
    NSMutableDictionary *proCitys = [[NSMutableDictionary alloc] init];
    NSArray *citys = [self getCityList];
    for (NSString *key in provinceKeys) {
        NSMutableArray *cityMuAry = [[NSMutableArray alloc] init];
        for (NSDictionary *cityDic in citys) {
            NSString *cityKey = [[cityDic allKeys] objectAtIndex:0];
            if([key isEqualToString:cityKey]){
                [cityMuAry addObject:cityDic];
            }
        }
        [proCitys setObject:cityMuAry forKey:key];
    }
    return proCitys ;
}

/*
 * 依据城市名查找城市编号
 */
-(NSString *) getCityCode:(NSString *) cityName {
    NSString *cityCode = @"";
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"city.txt"];
    [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *textFile = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *citys = [textFile componentsSeparatedByString:@"\n"];
    for (NSString *content in citys) {
        //        NSLog(@"%@",content);
        if([content isEqualToString:@""]) break;
        NSString *contentStr = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        NSArray *provinces = [contentStr componentsSeparatedByString:@";"];
        if([[provinces objectAtIndex:2] isEqualToString:cityName]){
            cityCode = [provinces objectAtIndex:0];
        }
        
    }
    return cityCode ;
}

/*
 * 根据系统参数名获取该类数组
 * @param typeName 系统参数键值
 */
-(NSArray *) getSystemType:(NSString *) typeName {
    NSArray *paramAry ;
    SystemParamResponse *sysResponse = [[SystemParamResponse alloc] init];
    id inParam = [self getSystemParam];
    if(inParam != nil){
        [sysResponse setResultData:inParam];
        NSMutableDictionary *paramDic = sysResponse.sysParamDic ;
        paramAry = [paramDic objectForKey:typeName];
    }
    return paramAry ;
}

/*
 * 根据系统参数获取对应的参数值
 * @param typeName 系统参数键值
 * @param paramId 类型id
 */
-(NSString *) getSystemNameType:(NSString *) typeName andTypeKey:(NSString *) paramId {
    NSString *nameValue = @"无" ;
    NSArray *ary = [self getSystemType:typeName];
    for (ParamElement *element in ary) {
        if([element.paramterId isEqualToString:paramId]){
            nameValue = element.paramName ;
        }
    }
    return nameValue ;
}

/*
 * 系统参数的保存
 */
-(void) saveSysetmParam:(id) inParam {
    [[NSUserDefaults standardUserDefaults] setObject:inParam forKey:SYSTEMPARAM];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 * 系统参数的获取
 */
-(id) getSystemParam {
    id systemData = [[NSUserDefaults standardUserDefaults] objectForKey:SYSTEMPARAM];
    return systemData ;
}

/*
 * 清理图片缓存
 */
- (void)clearImgCache
{
    
}

/*
 * 清理数据缓存
 */
- (void)clearDataCache
{
    
}

@end
