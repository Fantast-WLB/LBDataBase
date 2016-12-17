//
//  NSObject+LBModel.m
//  LBDBDemo
//
//  Created by 吴龙波 on 16/12/17.
//  Copyright © 2016年 SleepWell. All rights reserved.
//

#import "NSObject+LBModel.h"
#import <MJExtension.h>
@implementation NSObject (LBModel)

/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @return 新建的对象
 */
+(instancetype)lb_objectWithKeyValues:(id)keyValues
{
    return [self mj_objectWithKeyValues:keyValues];
}

/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @return 模型数组
 */
+(NSArray*)lb_objectArrayWithKeyValuesArray:(NSArray*)keyValuesArray
{
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

/**
 *  当模型中有数组，数组中有其他模型，可以用于设置数组中模型的类型
 *  @param dictionary 字典(格式-> "数组名":"类名" 例->@"models":@"Model" )
 *  设置完后调用lb_objectWithKeyValues即可。
 */
+(void)lb_setupObjectClassInArray:(NSDictionary*)dictionary
{
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return dictionary;
    }];
}

/**
 *  模型中的属性名和字典中的key不相同
 *  @param dictionary 字典(格式-> "属性名":"key" 例->@"ID":@"id" )
 *  设置完后调用lb_objectWithKeyValues即可。
 */
+(void)lb_setupReplacedKeyFromPropertyName:(NSDictionary*)dictionary
{
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return dictionary;
    }];
}

///将一个模型转成字典
-(NSMutableDictionary*)lb_keyVales
{
    return self.mj_keyValues;
}

///将一个模型数组转成字典数组
+(NSArray*)lb_keyValuesArrayWithObjectArray:(NSArray*)objectArray
{
    return [self mj_keyValuesArrayWithObjectArray:objectArray];
}
@end
