//
//  TimeModel.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headCellArray = [NSMutableArray array];
    }
    return self;
}

@end

@implementation IntergrationRecordModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    
    self.fullPayTime = dic[@"Time"];
    self.fullPayTime = [self.fullPayTime substringToIndex:10];
    //        self.payTime = dic[@"payTime"];
    self.Time = [self.fullPayTime substringToIndex:7];
    
    
    return YES;
}


@end
