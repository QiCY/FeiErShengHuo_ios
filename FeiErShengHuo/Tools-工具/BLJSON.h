//
//  BlJSON.h
//  Bolaaw
//
//  Created by KoharuYoshino on 2017/4/20.
//  Copyright © 2017年 KoharuYoshino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLJSON : NSObject

@property (nonatomic, strong) NSDictionary *response;//当前字典


#pragma mark - 实力化
/**
 *  实例化类方法 不带参数
 */
+(instancetype)json;
/**
 *  实例化类方法 带参数
 */
+(instancetype)jsonWithString:(NSString *)string;

#pragma mark - 解析方法
/**
 * 字典字符串解析字典
 */
+(NSDictionary *)analysisDictionaryWithString:(NSString *)string;//类方法
/**
 *  带json格式的对象(字典)转化成json字符串
 *
 *  @param jsonObject json对象
 *
 *  @return 带json格式的字符串
 */
+ (NSString *)jsonStringWithObject:(id)jsonObject;
/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  @param jsonString jsonString JSON格式的字符串
 *
 *  @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
-(NSDictionary *)analysisDictionaryWithString:(NSString *)string;//实例方法
/**
 * 数组字符串解析数组
 */
+(NSArray *)analysisArrayWithString:(NSString *)string;

#pragma mark - 拼接方法
/**
 * 将字典拼接字典符串
 */
+(NSString *)dictionaryToString:(NSDictionary *)dict;
/**
 * 拼接请求参数
 */
+(NSString *)appendUrlParamsFormat:(NSDictionary*)dict;;

#pragma mark - 工具方法
/**
 * key值判断是否
 */
-(BOOL)boolWithKeys:(NSString *)key;
/**
 * 通过Key获取字典的值
 */
-(NSString *)getStringforKey:(NSString *)key;


#pragma mark - 老方法 兼容
/**
 * 字符串解析字典
 */
-(void)BlJSONWithString:(NSString *)tempStr;

// 自动生成属性声明的代码 (模型)
+ (void)propertyCodeWithDictionary:(NSDictionary *)dict;


@end
