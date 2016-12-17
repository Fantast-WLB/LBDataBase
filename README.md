# LBDB用于在本地存取模型数组数据
整合封装了数据库工具FMDB 和 模型转换工具MJExtension
所以使用前需要先在项目中导入上述两个框架
# 使用方法
在控制器#import "LBDB.h"


        ///从本地名为DataTableName的表中取得保存名为DataName的LBModel模型数组
        
        [LBModel lb_objectArrayNamed:DataName InTable:DataTableName FinishedBlock:^(NSArray *models) {
        
                if (models == nil)
                {
                    NSLog(@"本地无数据");
                    ///模拟向服务器请求数据模型
                    weakSelf.models = [LBModel lb_models];
            
                    ///请求到数据后可以保存到本地
                    [weakSelf.models lb_saveToDBNamed:DataName InTable:DataTableName];
                }
                else
                {
                    ///取得本地缓存模型数组
                    weakSelf.models = models;
                }
        }];
        
        
        ///在本地保存模型数组到名为DataTableName的表里，保存名为DataName
        
        [weakSelf.models lb_saveToDBNamed:DataName InTable:DataTableName];
