//
//  RegisterSuccessVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RegisterSuccessVC.h"
#import "BodyTestVC.h"

@interface RegisterSuccessVC ()

@end

@implementation RegisterSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *baseImg = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_Width-662/2*scaleWidth)/2.0, 14, 662/2*scaleWidth, 998/2*scaleWidth)];
    baseImg.image = [UIImage imageNamed:@"register_2"];
    baseImg.layer.cornerRadius = 5;
    baseImg.layer.masksToBounds = YES;
    [self.view addSubview:baseImg];
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(120/2, baseImg.bottom+23, kScreen_Width-120, 88/2);
    enterBtn.layer.cornerRadius = 5;
    enterBtn.layer.masksToBounds = YES;
    [enterBtn setTitle:@"进入体质测试" forState:UIControlStateNormal];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    enterBtn.backgroundColor = [UIColor colorWithHexString:@"#72AFE5"];
    [self.view addSubview:enterBtn];
    [enterBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextAction
{
    BodyTestVC *vc = [[BodyTestVC alloc] init];
    vc.title = @"体质测试";
    [self.navigationController pushViewController:vc animated:YES];
}

// 重写
- (void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
