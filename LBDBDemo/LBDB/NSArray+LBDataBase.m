//
//  NSArray+LBDataBase.m
//  LBDBDemo
//
//  Created by 吴龙波 on 16/12/17.
//  Copyright © 2016年 SleepWell. All rights reserved.
//

#import "NSArray+LBDataBase.h"
#import "LBSQLiteManager.h"
#import "NSObject+LBModel.h"
@implementation NSArray (LBDataBase)


/**
 *  将一个模型数组转成JSON字符串存入本地,如果没有该数据则插入，已有该数据则覆盖
 *
 *  @param name        表中JSON的名字
 *  @param tableName   表的名字
 *
 *  return 模型数组
 */
-(void)lb_saveToDBNamed:(NSString*)name InTable:(NSString*)tableName
{
    NSArray *dicts = [NSObject lb_keyValuesArrayWithObjectArray:self];
    
    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicts options:NSJSONWritingPrettyPrinted error:&err];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [[LBSQLiteManager shareManager] insertOrUpdateJSONName:name inTable:tableName WithContent:jsonStr];
}


@end
