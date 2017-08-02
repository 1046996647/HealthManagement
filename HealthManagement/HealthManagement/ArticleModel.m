//
//  ArticleModel.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *timeStr = dic[@"aTime"];
    _aTime = [timeStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    return YES;
}

@end


@implementation SuggestModel

@end
