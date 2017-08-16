//
//  ResDetailVC.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import "ResDetailModel.h"

@interface ResDetailVC : BaseViewController

//@property(nonatomic,strong) ResDetailModel *model;
@property(nonatomic,copy) NSString *resID;

@property(nonatomic,strong) NSNumber *latitude;// 纬度
@property(nonatomic,strong) NSNumber *longitude;// 经度

@end
