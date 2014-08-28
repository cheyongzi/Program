//
//  JsonUtils.m
//  Booking
//
//  Created by jinchenxin on 14-6-6.
//  Copyright (c) 2014年 bluecreate. All rights reserved.
//

#import "JsonUtils.h"
#import "HttpRequestField.h"
#import "MessageElement.h"

@implementation JsonUtils

/*
 * 抢单数据模型json解析
 */
+(RequireElement *) jsonRequireElement:(id) inParam {
    RequireElement *requireElement  ;
    NSDictionary *paramDic = (NSDictionary *)inParam ;
    if([paramDic isKindOfClass:[NSDictionary class]]){
        requireElement = [[RequireElement alloc] init];
        requireElement.requiredId = [paramDic objectForKey:@"robId"];
        requireElement.memberId = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"memberId"]];
        requireElement.shopType = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"shopType"]];
        requireElement.personId = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"volumeId"]];
        requireElement.providerType = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"partyId"]];
        requireElement.meetType = [paramDic objectForKey:@"meetType"];
        requireElement.robType = [paramDic objectForKey:@"robType"];
        requireElement.logoUrl = [paramDic objectForKey:@"logoUrl"];
        requireElement.count = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"count"]];
        requireElement.consumDate = [paramDic objectForKey:@"consumDate"];
        requireElement.arriveTime = [paramDic objectForKey:@"arriveTime"];
        requireElement.hours = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"consumDuration"]];
        requireElement.consumInterval = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"consumInterval"]];
        requireElement.rejectDate = [paramDic objectForKey:@"rejectDate"];
        requireElement.publishDate = [paramDic objectForKey:@"publishTime"];
        requireElement.cityCode = [paramDic objectForKey:@"cityCode"];
        requireElement.latitude = [paramDic objectForKey:@"latitude"];
        requireElement.longitude = [paramDic objectForKey:@"longitude"];
        requireElement.busCode = [paramDic objectForKey:@"busCode"];
        requireElement.radius = [paramDic objectForKey:@"radius"];
        requireElement.endTime = [paramDic objectForKey:@"endTime"];
        requireElement.address = [paramDic objectForKey:@"address"];
        requireElement.offerPrice = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"offerPrice"]];
        requireElement.contact = [paramDic objectForKey:@"name"];
        requireElement.mobile = [paramDic objectForKey:@"mobile"];
        requireElement.payment = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"goodfaith"]];
        requireElement.sex = [paramDic objectForKey:@"sex"];
        requireElement.brief = [paramDic objectForKey:@"brief"];
        requireElement.targeProvider = [paramDic objectForKey:@"targeProvider"];
        requireElement.goods = [paramDic objectForKey:@"goods"];
        
        NSArray *winAry = [paramDic objectForKey:@"details"];
        requireElement.winAry = [[NSMutableArray alloc] init];
        if(winAry != nil && [winAry count]>0){
            for (NSDictionary *winDic in winAry) {
                WineElement *wineElement = [JsonUtils jsonWineElement:winDic];
                [requireElement.winAry addObject:wineElement];
            }
        }
        
        if(requireElement.requiredId == nil) requireElement.requiredId = @"";
        if(requireElement.personId == nil) requireElement.personId = @"";
        if(requireElement.providerType == nil) requireElement.providerType = @"";
        if(requireElement.meetType == nil) requireElement.meetType = @"";
        if(requireElement.robType == nil) requireElement.robType = @"";
        if(requireElement.logoUrl == nil) requireElement.logoUrl = @"";
        if(requireElement.count == nil || [requireElement.count isEqualToString:@"(null)"]) requireElement.count = @"0";
        if(requireElement.consumDate == nil) requireElement.consumDate = @"";
        if(requireElement.arriveTime == nil) requireElement.arriveTime = @"";
        if(requireElement.hours == nil || [requireElement.hours isEqualToString:@"(null)"]) requireElement.hours = @"";
        if(requireElement.consumInterval == nil) requireElement.consumInterval = @"";
        if(requireElement.rejectDate == nil) requireElement.rejectDate = @"";
        if(requireElement.publishDate == nil) requireElement.publishDate = @"";
        if(requireElement.cityCode == nil) requireElement.cityCode = @"";
        if(requireElement.latitude == nil) requireElement.latitude = @"";
        if(requireElement.longitude == nil) requireElement.longitude = @"";
        if(requireElement.busCode == nil) requireElement.busCode = @"";
        if(requireElement.radius == nil) requireElement.radius = @"";
        if(requireElement.address == nil) requireElement.address = @"";
        if(requireElement.offerPrice == nil || [requireElement.offerPrice isEqualToString:@"(null)"]) requireElement.offerPrice = @"0";
        if(requireElement.contact == nil) requireElement.contact = @"";
        if(requireElement.mobile == nil) requireElement.mobile = @"";
        if(requireElement.payment == nil || [requireElement.payment isEqualToString:@"(null)"]) requireElement.payment = @"0";
        if(requireElement.sex == nil) requireElement.sex = @"";
        if(requireElement.targeProvider == nil) requireElement.targeProvider = @"";
        if(requireElement.goods == nil) requireElement.goods = @"";
    }
    return requireElement ;
}

/*
 * 酒水数据模型json解析
 */
+(WineElement *) jsonWineElement:(id) inParam {
    NSDictionary *paramDic = (NSDictionary *)inParam;
    WineElement *wineElement  ;
    
    if([paramDic isKindOfClass:[NSDictionary class]]){
        wineElement = [[WineElement alloc] init];
        wineElement.goodsId = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"serviceId"]];
        wineElement.goodsImg = [paramDic objectForKey:@"picUrl"];
        wineElement.goodsName = [paramDic objectForKey:@"goodsName"];
        wineElement.goodsNumber = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"goodsNum"]];
        wineElement.goodsPrice = [NSString stringWithFormat:@"%@",[paramDic objectForKey:@"price"]];
        wineElement.unit = [paramDic objectForKey:@"unit"];
        
        if(wineElement.goodsNumber == nil || [wineElement.goodsNumber isEqualToString:@"(null)"]) wineElement.goodsNumber = @"0";
    }
    return wineElement ;
}

/*
 * 用户数据模型json解析
 */
+(UserElement *) jsonUserElement:(id) inParam {
    NSDictionary *dataDic = (NSDictionary *)inParam;
    UserElement *userElement;
    if ([dataDic isKindOfClass:[NSDictionary class]]) {
        userElement = [[UserElement alloc] init];
        userElement.memberId = [dataDic objectForKey:@"memberId"];
        userElement.sessionId = [dataDic objectForKey:@"sid"];
        userElement.userCode = [dataDic objectForKey:@"userCode"];
        userElement.logoUrl = [dataDic objectForKey:@"logoUrl"];
        userElement.name = [dataDic objectForKey:@"name"];
        userElement.contact = [dataDic objectForKey:@"contact"];
        userElement.sex = [dataDic objectForKey:@"sex"];
        userElement.email = [dataDic objectForKey:@"email"];
        userElement.mobile = [dataDic objectForKey:@"mobile"];
        userElement.inviteCode = [dataDic objectForKey:@"inviteCode"];
    }
    return userElement ;
}

/*
 * 获取验证码模型json解析
 */
+(VerifyElement *) jsonVerifyElement:(id) inParam
{
    NSDictionary *dataDic = (NSDictionary *)inParam;
    VerifyElement *verifyElement;
    if ([dataDic isKindOfClass:[NSDictionary class]]) {
        verifyElement = [[VerifyElement alloc] init];
        verifyElement.verifyCode = [dataDic objectForKey:@"verify"];
    }
    return verifyElement;
}

/*
 * 提供商家模型的json解析
 */
+(ProviderElement *) jsonProviderElement:(id) inParam {
    NSDictionary *dataDic = (NSDictionary *) inParam ;
    ProviderElement *providerElement ;
    if([dataDic isKindOfClass:[NSDictionary class]]){
        providerElement = [[ProviderElement alloc] init];
        providerElement.shopAddress = [dataDic objectForKey:@"address"];
        providerElement.shopName = [dataDic objectForKey:@"name"];
        providerElement.shopImgUrl = [dataDic objectForKey:@"logo"];
        providerElement.roomName = @"";
        providerElement.shopId = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"shopId"]];
        providerElement.longitude = [dataDic objectForKey:@"longitude"];
        providerElement.latitude = [dataDic objectForKey:@"latitude"];
        providerElement.endDate = @"";
        providerElement.volume = @"";
        providerElement.selectState = @"0";
    }
    return providerElement;
}

/*
 * 应单对象
 */
+(AcceptOrderElement *) jsonAcceptOrderElement:(id) inParam {
    NSDictionary *dataDic = (NSDictionary *) inParam ;
    AcceptOrderElement *element ;
    if([dataDic isKindOfClass:[NSDictionary class]]){
        element = [[AcceptOrderElement alloc] init];
        element.acceptTime = [dataDic objectForKey:@"acceptTime"];
        element.latitude = [dataDic objectForKey:@"latitude"];
        element.longitude = [dataDic objectForKey:@"longitude"];
        element.partyId = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"partyId"]];
        element.shopName = [dataDic objectForKey:@"shopName"];
        element.shopsId = [dataDic objectForKey:@"shopsId"];
        element.status = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"status"]];
        element.totalPrice = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"totalPrice"]];
        element.volumeId = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"volumeId"]];
        element.typeId = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"typeId"]];
        element.logo = [dataDic objectForKey:@"logo"];
        element.winAry = [[NSMutableArray alloc] init];
        element.sendAry = [[NSMutableArray alloc] init];
        element.endTime = [dataDic objectForKey:@"endTime"];
        element.phoneNumber = [dataDic objectForKey:@"shopPhone"];
        element.mobileNumber = [dataDic objectForKey:@"shopMobile"];
        element.roomName    = [dataDic objectForKey:@"roomName"];
        NSArray *detailsAry = [dataDic objectForKey:@"details"];
        if(detailsAry != nil && [detailsAry count]>0){
            for (NSDictionary *goodsDic in detailsAry) {
                NSString *isSend = [NSString stringWithFormat:@"%@",[goodsDic objectForKey:@"isSend"]] ;
                WineElement *wineElement = [self jsonWineElement:goodsDic];
                if([isSend isEqualToString:@"0"]){
                   [element.winAry addObject:wineElement];
                }else{
                   [element.sendAry addObject:wineElement];
                }
                
                
            }
        }
        
        if(element.totalPrice != nil || [element.totalPrice isEqualToString:@"(null)"]) element.totalPrice = @"0";
    }
    return element ;
}

/*
 * 系统参数模型类
 */
+(ParamElement *) jsonParamElement:(id) inParam {
    NSDictionary *dataDic = (NSDictionary *) inParam ;
    ParamElement *element ;
    if([dataDic isKindOfClass:[NSDictionary class]]){
        element = [[ParamElement alloc] init];
        element.paramName = [dataDic objectForKey:@"paramName"];
        element.paramterId = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"parameterId"]];
    }
    return element ;
}

+(NSMutableArray *) jsonUserOrderElement:(id) inParam
{
    NSMutableArray *mulArray = [[NSMutableArray alloc] init];
    NSArray *orderArr = (NSArray *)inParam;
    OrderElement *orderElement;
    for (int i= 0; i<[orderArr count]; i++) {
        NSDictionary *orderDic = [orderArr objectAtIndex:i];
        if (orderDic != nil)
        {
            orderElement = [[OrderElement alloc] init];
            
            orderElement.address = [orderDic objectForKey:@"address"];
            orderElement.amounts = [orderDic objectForKey:@"amounts"];
            orderElement.consumeDate = [orderDic objectForKey:@"consumDate"];
            orderElement.isCost = [[orderDic objectForKey:@"isCost"] integerValue];
            orderElement.orderId = [orderDic objectForKey:@"orderId"];
            orderElement.orderNum = [orderDic objectForKey:@"orderNum"];
            orderElement.shopName = [orderDic objectForKey:@"shopName"];
            orderElement.submitTime = [orderDic objectForKey:@"submitTime"];
            orderElement.userCostNum = [orderDic objectForKey:@"usercostnum"];
            orderElement.logo = [orderDic objectForKey:@"logo"];
            orderElement.robId = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"robId"]];
            orderElement.typeId = [orderDic objectForKey:@"typeId"];
            orderElement.count = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"count"]];
            orderElement.consumInterval = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"consumInterval"]];
            orderElement.arriveTime = [orderDic objectForKey:@"startTime"];
            orderElement.hours = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"consumDuration"]];
            orderElement.volumeId = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"volumeId"]];
            
            NSArray *winAry = [orderDic objectForKey:@"details"];
            orderElement.mulArray = [[NSMutableArray alloc] init];
            if(winAry != nil && [winAry count]>0){
                for (NSDictionary *winDic in winAry) {
                    WineElement *wineElement = [JsonUtils jsonWineElement:winDic];
                    [orderElement.mulArray addObject:wineElement];
                }
            }
            
            [mulArray addObject:orderElement];
            
        }
    }
    return mulArray;
}

/*
 * 用户订单详情数据解析
 */
+(NSMutableArray *) jsonUserOrderDetailElement:(id) inParam
{
    NSMutableArray *mulArr = [[NSMutableArray alloc] init];
    NSArray *detailArr = (NSArray *)inParam;
    WineElement *wineElement;
    for (int i = 0; i<[detailArr count]; i++)
    {
        NSDictionary *detailDic = [detailArr objectAtIndex:i];
        if (detailDic != nil)
        {
            wineElement = [[WineElement alloc] init];
            wineElement.goodsName = [detailDic objectForKey:@"goodsName"];
            wineElement.goodsNumber = [detailDic objectForKey:@"googsNum"];
            wineElement.goodsPrice = [detailDic objectForKey:@"price"];
            wineElement.unit = [detailDic objectForKey:@"unit"];
            wineElement.goodsImg = [NSString stringWithFormat:@"%@%@",BASEURLPATH,[detailDic objectForKey:@"picUrl"]];
            [mulArr addObject:wineElement];
        }
    }
    return mulArr;
}

+(NSMutableArray *)jsonMessageWithData:(id) inParam
{
    NSMutableArray *mulArr = [[NSMutableArray alloc] init];
    NSArray *array = (NSArray *)inParam;
    MessageElement *messageElement;
    for (int i=0; i<[array count]; i++)
    {
        NSDictionary *dic = [array objectAtIndex:i];
        if (dic != nil)
        {
            messageElement = [[MessageElement alloc] init];
            messageElement.content = [dic objectForKey:@"content"];
            messageElement.newsUrl = [dic objectForKey:@"newsUrl"];
            messageElement.sendTime = [dic objectForKey:@"sendTime"];
            messageElement.title = [dic objectForKey:@"title"];
            [mulArr addObject:messageElement];
        }
    }
    return mulArr;
}

+(EvaluateElement*)jsonEvaluateWithData:(NSDictionary*) infoDic
{
    EvaluateElement *element = [[EvaluateElement alloc] init];
    if (infoDic!=nil) {
        element.environmentScore = [infoDic objectForKey:@"environment"];
        element.serviceScore     = [infoDic objectForKey:@"serviceScore"];
        element.deviceScore      = [infoDic objectForKey:@"deviceScore"];
        element.commentContent   = [infoDic objectForKey:@"content"];
    }
    return element;
}

@end
