//
//  LBSQLiteManager.m
//  LBDBDemo
//
//  Created by 吴龙波 on 16/12/17.
//  Copyright © 2016年 SleepWell. All rights reserved.
//

#import "LBSQLiteManager.h"
#import <FMDB.h>

@interface LBSQLiteManager ()

@property(nonatomic,strong)FMDatabaseQueue *dbQueue;

@end

@implementation LBSQLiteManager

+(instancetype)shareManager
{
    static LBSQLiteManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LBSQLiteManager alloc]init];
    });
    return instance;
}

-(instancetype)init
{
    if (self = [super init])
    {
        NSString* dataBasePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        
        self.dbQueue = [[FMDatabaseQueue alloc]initWithPath:[NSString stringWithFormat:@"%@/MuUser_%zd.db",dataBasePath,self.user_id]];
        
        //#warning 此处应以用户ID来建立数据库
//        FMDatabase *db = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/user_%zd/MuUser.db",dataBasePath,self.user_id]];
    }
    return self;
}


/*********** 用于缓存JSON数据 ***********/
///创建JSON表
-(void)creatJSONDataTableNamed:(NSString*)tableName
{
    NSString* sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@'(JSONName TEXT PRIMARY KEY, JSONContent TEXT);",tableName];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSError* error;
        [db executeUpdate:sql values:nil error:&error];
        if (error)
        {
            NSLog(@"创建数据表出错%@",error);
        }
    }];
}

///查某个JSON
-(void)searchJSONNamed:(NSString*)name InTable:(NSString*)tableName finishedBlock:(void(^)(FMResultSet *result))finishedBlock
{
    [self creatJSONDataTableNamed:tableName];
    
    NSString* sql = [NSString stringWithFormat:@"SELECT %@.JSONContent FROM %@ WHERE JSONName = '%@'",tableName,tableName,name];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next])
        {
            if (finishedBlock)
            {
                finishedBlock(result);
            }
        }
    }];
}

///增加一个JSON
-(void)insertJSONName:(NSString*)name JSONContent:(NSString*)content intoTable:(NSString*)tableName
{
    [self creatJSONDataTableNamed:tableName];
    
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO '%@' ( 'JSONName','JSONContent') VALUES ( '%@','%@');",tableName,name,content];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSError* error;
        FMResultSet* result = [db executeQuery:sql values:nil error:&error];
        if ([result next])
        {
            
        }
        if (error)
        {
            NSLog(@"添加数据出错%@",error);
        }
    }];
    
}

///改一个JSON
-(void)updateJSONName:(NSString*)name inTable:(NSString*)tableName toNewContent:(NSString*)newContent
{
    [self creatJSONDataTableNamed:tableName];
    
    NSString* sql = [NSString stringWithFormat:@"UPDATE %@ SET JSONContent = '%@' WHERE JSONName = '%@';",tableName,newContent,name];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSError* error;
        FMResultSet* result = [db executeQuery:sql values:nil error:&error];
        if ([result next])
        {
            
        }
        if (error)
        {
            NSLog(@"修改数据出错%@",error);
        }
    }];
}

///插入或者刷新一个JSON数据
-(void)insertOrUpdateJSONName:(NSString*)JSONName inTable:(NSString*)tableName WithContent:(NSString*)content
{
    [self creatJSONDataTableNamed:tableName];
    
    __block BOOL isExist = NO;
    [self searchJSONNamed:JSONName InTable:tableName finishedBlock:^(FMResultSet *result) {
        isExist = YES;
    }];
    if (isExist)
    {
        [self updateJSONName:JSONName inTable:tableName toNewContent:content];
    }
    else
    {
        [self insertJSONName:JSONName JSONContent:content intoTable:tableName];
    }
}


@end
