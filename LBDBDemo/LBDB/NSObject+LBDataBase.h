//
//  NSObject+LBDataBase.h
//  LBDBDemo
//
//  Created by 吴龙波 on 16/12/17.
//  Copyright © 2016年 SleepWell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LBDataBase)


/**
 *  在一个表里查找一条JSON数据并转成模型数组
 *
 *  @param name          表中JSON的名字
 *  @param tableName     表的名字
 *  @param finishedBlock 回调(如果无法从本地取得模型，则在回调中从服务器请求)
 *
 */
+(void)lb_objectArrayNamed:(NSString*)name InTable:(NSString*)tableName FinishedBlock:(void(^)(NSArray *models))finishedBlock;
@end
