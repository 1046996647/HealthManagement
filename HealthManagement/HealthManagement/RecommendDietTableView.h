//
//  RecommendDietTableView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendDietTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIImageView *imgView1;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *lastBtn;

@end
