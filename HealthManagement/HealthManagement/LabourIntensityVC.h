//
//  LabourIntensityVC.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/8/16.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^SendMsgBlock)(NSString *str);


@interface LabourIntensityVC : BaseViewController

@property (nonatomic, copy)SendMsgBlock block;


@end
