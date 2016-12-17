//
//  LBModel.m
//  LBDBDemo
//
//  Created by 吴龙波 on 16/12/17.
//  Copyright © 2016年 SleepWell. All rights reserved.
//

#import "LBModel.h"

@interface LBModel ()

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)NSInteger age;

@end

@implementation LBModel

+(NSArray*)lb_models
{
    LBModel *one = [LBModel new];
    one.name = @"one";
    one.age = 15;
    
    LBModel *two = [LBModel new];
    two.name = @"two";
    two.age = 18;
    
    return @[one,two];
}

@end
