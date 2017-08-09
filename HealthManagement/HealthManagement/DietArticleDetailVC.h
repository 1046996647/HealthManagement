//
//  DietArticleDetailVC.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import "ArticleModel.h"

typedef void(^ArticleRefreshBlock)(ArticleModel *model);



@interface DietArticleDetailVC : BaseViewController

@property(nonatomic,strong) ArticleModel *model;

@property (nonatomic,copy) ArticleRefreshBlock block;



@end
