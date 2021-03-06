//
//  SleepModel.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/18.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SleepModel.h"

@implementation SleepModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.weekDay = [NSMutableArray array];
        
        // 初始值
        self.weekDay = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
        self.tag = @(0);
        self.musicName = @"布谷鸟";
        
        self.weekValue = [NSMutableArray array];

        for (int i=0; i<7; i++) {
            [self.weekValue addObject:@0.0];
        }
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}

@end
