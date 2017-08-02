//
//  TestProCell.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/28.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BodyModel.h"

typedef void(^SendProModelBlock)(ContenModel *model);


@interface TestProCell : UITableViewCell

@property(nonatomic,strong) UIButton *wechatBtn;
@property(nonatomic,strong) ContenModel *model;
@property(nonatomic,copy) SendProModelBlock block;

@end
