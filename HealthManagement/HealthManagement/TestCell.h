//
//  TestCell.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BodyModel.h"

typedef void(^SendEasyModelBlock)(ContenModel *model);


@interface TestCell : UITableViewCell

@property(nonatomic,strong) UIButton *wechatBtn;
@property(nonatomic,strong) ContenModel *model;
@property(nonatomic,copy) SendEasyModelBlock block;


@end
