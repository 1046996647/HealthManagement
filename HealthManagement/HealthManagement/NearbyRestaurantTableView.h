//
//  NearbyRestaurantTableView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbyRestaurantTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIImageView *imgView1;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,strong) UIButton *besideBtn;


@end
