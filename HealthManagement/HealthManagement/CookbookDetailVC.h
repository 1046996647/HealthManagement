//
//  CookbookDetailVC.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import "RecipeModel.h"

@interface CookbookDetailVC : BaseViewController

@property(nonatomic,strong) RecipeModel *model;
@property(nonatomic,strong) NSNumber *latitude;// 纬度
@property(nonatomic,strong) NSNumber *longitude;// 经度

@property(nonatomic,assign) NSInteger mark;


@end
