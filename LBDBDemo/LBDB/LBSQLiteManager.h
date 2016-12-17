//
//  LBSQLiteManager.h
//  LBDBDemo
//
//  Created by 吴龙波 on 16/12/17.
//  Copyright © 2016年 SleepWell. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;
@interface LBSQLiteManager : NSObject

///用户ID，不同用户建立不同的数据库
@property(nonatomic,assign)NSInteger user_id;

///单例数据库管理对象
+(instancetype)shareManager;

///创建JSON表
-(void)creatJSONDataTableNamed:(NSString*)tableName;
///查某个JSON
-(void)searchJSONNamed:(NSString*)name InTable:(NSString*)tableName finishedBlock:(void(^)(FMResultSet *result))finishedBlock;
///增加一个JSON
-(void)insertJSONName:(NSString*)name JSONContent:(NSString*)content intoTable:(NSString*)tableName;
///改一个JSON
-(void)updateJSONName:(NSString*)name inTable:(NSString*)tableName toNewContent:(NSString*)newContent;
///插入或者刷新一个JSON数据
-(void)insertOrUpdateJSONName:(NSString*)JSONName inTable:(NSString*)tableName WithContent:(NSString*)content;

@end
