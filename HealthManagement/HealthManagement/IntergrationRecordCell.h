//
//  IntergrationRecordCell.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeModel.h"
#import "NSStringExt.h"


@interface IntergrationRecordCell : UITableViewCell


@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab4;
@property(nonatomic,strong) IntergrationRecordModel *model;

@end
