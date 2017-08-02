//
//  NearbyRestaurantVC.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

@interface NearbyRestaurantVC : BaseViewController<UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *modelArr;
@property(nonatomic,strong) NSNumber *latitude;// 纬度
@property(nonatomic,strong) NSNumber *longitude;// 经度
@property(nonatomic,assign) NSInteger pageNO;// 页数

@end
