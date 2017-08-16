//
//  IntergrationModel.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/8/15.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "IntergrationModel.h"

@implementation IntergrationModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    
    NSString *timeStr = dic[@"Time"];
    _Time = [timeStr substringWithRange:NSMakeRange(5, 5)];
    
    
    return YES;
}

@end
