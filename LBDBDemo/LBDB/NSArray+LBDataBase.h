//
//  NSArray+LBDataBase.h
//  LBDBDemo
//
//  Created by 吴龙波 on 16/12/17.
//  Copyright © 2016年 SleepWell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LBDataBase)

/**
 *  将一个模型数组转成JSON字符串存入本地,如果没有该数据则插入，已有该数据则覆盖
 *
 *  @param name        表中JSON的名字
 *  @param tableName   表的名字
 *
 *  return 模型数组
 */
-(void)lb_saveToDBNamed:(NSString*)name InTable:(NSString*)tableName;

@end
