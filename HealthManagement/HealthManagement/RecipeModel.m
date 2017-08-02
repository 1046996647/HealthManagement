//
//  RecipeModel.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/25.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RecipeModel.h"

@implementation RecipeModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}


@end

@implementation RecipeItemModel



@end

@implementation RecipeItem1Model



@end

@implementation FoodModel



@end
