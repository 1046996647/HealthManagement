//
//  SearchResultVC.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchResultVC : BaseViewController

@property(nonatomic,strong) NSNumber *latitude;// 纬度
@property(nonatomic,strong) NSNumber *longitude;// 经度
@property(nonatomic,copy) NSString *searchText;

@end
