//
//  ViewController.m
//  LBDBDemo
//
//  Created by 吴龙波 on 16/12/17.
//  Copyright © 2016年 SleepWell. All rights reserved.
//

#import "ViewController.h"
#import "LBDB.h"
#import "LBModel.h"

#define DataName @"LBModel"
#define DataTableName @"LocalDataTable"

@interface ViewController ()

@property(nonatomic,strong)NSArray *models;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof(self)weakSelf = self;
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
    
    NSLog(@"%@",self.models);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
