//
//  BlJSON.m
//  Bolaaw
//
//  Created by KoharuYoshino on 2017/4/20.
//  Copyright © 2017年 KoharuYoshino. All rights reserved.

/*
 自定义JSON数据解析类
 */

#import "BLJSON.h"



@implementation BLJSON

//判断字符串是否为空
+ (BOOL)stringIsEmpty:(NSString *)str {
    if (str==nil ||[@"null" isEqualToString:str] || [@"" isEqualToString:str] || [@"<null>" isEqualToString:str] || [@"(null)" isEqualToString:str] || [[NSNull null] isEqual:str]||[@"\"null\"" isEqualToString:str]) {
        return YES;
    } else {
        return NO;
    }
}


#pragma mark - SETTER && GETTER
-(NSDictionary *)response
{
    if (_response == nil) {
        _response = [NSDictionary dictionary];
    }
    return _response;
}

+(instancetype)json
{
    BLJSON *sbJson = [[self alloc] init];
    return sbJson;
}

+(instancetype)jsonWithString:(NSString *)string
{
    BLJSON *sbJson = [[self alloc] init];
    [sbJson analysisDictionaryWithString:string];
    return sbJson;
}

#pragma makr - 解析部分
//传入一个字典字符串解析字典
+(NSDictionary *)analysisDictionaryWithString:(NSString *)string
{
    BLJSON *json = [[BLJSON alloc] init];
    NSDictionary *tempdict = [NSDictionary dictionary];
    if (![BLJSON stringIsEmpty:string] && string.length > 5) {
        
        NSRange range = NSMakeRange(1, string.length-3);
        NSString *headStr = [string substringWithRange:range];
        NSArray *tempArr = [headStr componentsSeparatedByString:@"§§"];
        NSMutableDictionary *analysis = [NSMutableDictionary dictionary];
        for (NSString *keyStr in tempArr) {
        
            NSArray *tmpArr = [keyStr componentsSeparatedByString:@"§:"];
            if (tmpArr.count == 2) {
                
                [analysis setObject:tmpArr[1] forKey:tmpArr[0]];
            } else {
                
                [analysis setObject:@"" forKey:tmpArr[0]];
            }
        }
        
        
        if (analysis) tempdict = analysis;
    }
    
    
    if (tempdict) {
        json.response = tempdict;
        return tempdict;
    }
    return nil;
}
//传入一个字典字符串解析字典ru
-(NSDictionary *)analysisDictionaryWithString:(NSString *)string
{
    NSDictionary *tempdict = [NSDictionary dictionary];
    if (![BLJSON stringIsEmpty:string] && string.length > 5) {
        
        NSRange range = NSMakeRange(1, string.length-3);
        NSString *headStr = [string substringWithRange:range];
        NSArray *tempArr = [headStr componentsSeparatedByString:@"§§"];
        NSMutableDictionary *analysis = [NSMutableDictionary dictionary];
        for (NSString *keyStr in tempArr) {
            
            NSArray *tmpArr = [keyStr componentsSeparatedByString:@"§:"];
            if (tmpArr.count == 2) {
                
                [analysis setObject:tmpArr[1] forKey:tmpArr[0]];
            } else {
                
                [analysis setObject:@"" forKey:tmpArr[0]];
            }
        }
        if (analysis) tempdict = analysis;
    }
    if (tempdict) {
        self.response = tempdict;
        return tempdict;
    }
    return nil;
}


//传入一个数组字符串解析数组
+(NSArray *)analysisArrayWithString:(NSString *)string
{
    NSArray *array = [NSArray array];
    if (![BLJSON stringIsEmpty:string]) {
        array = [string componentsSeparatedByString:@"§"];
    }
    if (array) return array;
    return nil;
}

#pragma mark - 拼接部分
//传出一个字典字符串
+(NSString *)dictionaryToString:(NSDictionary *)dict
{
    NSString *string = @"";
    if (dict.count > 0) {
        
        NSMutableString *result = [[NSMutableString alloc] initWithString:@"{"];
        NSArray *key = [dict allKeys];
        for (int i = 0; i < key.count; i++) {
            
            NSString *column = key[i];
            NSString * value = [dict valueForKey:column];
            [result appendFormat:@"%@",column];
            [result appendFormat:@"§:"];
            [result appendFormat:@"%@",value];
            if (i < key.count - 1) {
                [result appendFormat:@"§§"];
            }
        }

        [result appendFormat:@"}"];
        NSRange range = NSMakeRange(0, result.length);
        string = [result substringWithRange:range];
    }
    if (![BLJSON stringIsEmpty:string]) return string;
    return nil;
}

//拼接URL请求字典参数
+(NSString *)appendUrlParamsFormat:(NSDictionary*)dict;
{
    NSString *str = @"";
    if (dict.count > 0) {
        NSMutableString *result = [[NSMutableString alloc] init];
        NSArray *key = [dict allKeys];
        for (NSString *column in key) {
            NSString * value = [dict valueForKey:column];
            [result appendFormat:@"%@",column];
            [result appendFormat:@"="];
            [result appendFormat:@"%@",value];
            [result appendFormat:@"&"];
        }
        NSRange range = NSMakeRange(0, result.length-1);
        str = [result substringWithRange:range];
    }
    return str;
}

#pragma makr - 工具方法
-(NSString *)getStringforKey:(NSString *)key
{
    NSString *result = @"";
    if ([self.response objectForKey:key]) {
        result = [self.response valueForKey:key];
    }
    return result;
}

-(BOOL)boolWithKeys:(NSString *)key
{
    BOOL result = NO;
    if ([self.response objectForKey:key]) {
        result = [[self.response objectForKey:key] boolValue];
    }
    return result;
}


#pragma mark - 未分类
//解析字典 等价于 analysisDictionaryWithString
-(void)BlJSONWithString:(NSString *)tempStr
{
    if (![BLJSON stringIsEmpty:tempStr] && tempStr.length > 5) {
        NSRange range = NSMakeRange(1, tempStr.length-3);
        
        NSString *headStr = [tempStr substringWithRange:range];
        NSArray *tempArr = [headStr componentsSeparatedByString:@"§§"];
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        for (NSString *keyStr in tempArr) {
            
            NSArray *tmpArr = [keyStr componentsSeparatedByString:@"§:"];
            
            if (tmpArr.count == 2) {
                [tempDict setObject:tmpArr[1] forKey:tmpArr[0]];
                
            } else {
                [tempDict setObject:@"" forKey:tmpArr[0]];
            }
        }
        self.response = tempDict;
    }
}

// 自动生成属性声明的代码
+ (void)propertyCodeWithDictionary:(NSDictionary *)dict
{
    
    NSMutableString *strM = [NSMutableString string];
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *str;
        
        NSLog(@"--obj 的类型---%@",[obj class]);
        if ([obj isKindOfClass:[NSNull class]]) {
             str = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@________%@;",key,[obj class]];
        }
        
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")] || [obj isKindOfClass:NSClassFromString(@"NSTaggedPointerString")] || [obj isKindOfClass:NSClassFromString(@"__NSCFConstantString")]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) int %@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]|| [obj isKindOfClass:NSClassFromString(@"__NSArray0")] ||[obj isKindOfClass:NSClassFromString(@"__NSArrayI")]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, copy) NSArray *%@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, copy) NSDictionary *%@;",key];
        }
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            str = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        }
        
        [strM appendFormat:@"\n%@\n",str];
    }];
    
    NSLog(@" \n======== 声明属性开始 ========  \n%@ \n======= 声明属性结束 ========= ",strM);
}

#pragma mark - json操作
/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  @param jsonString jsonString JSON格式的字符串
 *
 *  @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
/**
 *  带json格式的对象(字典)转化成json字符串
 *
 *  @param jsonObject json对象
 *
 *  @return 带json格式的字符串
 */
+ (NSString *)jsonStringWithObject:(id)jsonObject{
    // 将字典或者数组转化为JSON串
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    if ([jsonString length] > 0 && error == nil){
        return jsonString;
    }else{
        return nil;
    }
}



@end

