//
//  IntergrationDesVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/9/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "IntergrationDesVC.h"

@interface IntergrationDesVC ()

@end

@implementation IntergrationDesVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.text = @"1.餐饮模块，每一次下单就餐提供1积分，每天最高获得2积分，一周最高获得10积分。\n\n2.运动模块，男生每次30分钟内步数超过3000步，距离超过3.3km，积一分，女生30分钟内超过3000步，距离超过2.7公里，积一分，每天最多积一分，每周最多积四分。\n\n3.睡眠模块，每天11点前睡积0.5分，11.30前睡积0.3分，可以每天都积分。\n\n4.健康小树:小树状态:\n0-5分       身体孱弱\n5-15分      健健康康\n15-30分   生龙活虎\n30-50分   百楼不喘        每周掉2分\n50-70分   生病是什么?  每周掉4分\n70-90分   飞天遁地        每周掉6分\n90-110分  斩妖除魔        每周掉8分\n110-以上  长生不死         每周掉10分";
    textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
