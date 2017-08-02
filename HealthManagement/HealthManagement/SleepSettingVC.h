//
//  SleepSettingVC.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/21.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"
#import "SleepModel.h"

typedef void (^SettingBlock)(void);


@interface SleepSettingVC : BaseViewController

@property (nonatomic,strong) SleepModel *model;

@property(nonatomic,copy) SettingBlock settingBlock;


@end
