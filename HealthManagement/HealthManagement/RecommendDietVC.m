//
//  RecommendDietVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RecommendDietVC.h"
#import "RecommendDietTableView.h"

@interface RecommendDietVC ()
@property(nonatomic,strong) RecommendDietTableView *recommendDietTableView;


@end

@implementation RecommendDietVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"推荐饮食";
    
    // 推荐饮食视图
    _recommendDietTableView = [[RecommendDietTableView alloc] initWithFrame:CGRectMake(0, 3, kScreen_Width, kScreen_Height-64-3)];
    _recommendDietTableView.latitude = self.latitude;
    _recommendDietTableView.longitude = self.longitude;
    _recommendDietTableView.groupBy = @"SuitMe";
    [self.view addSubview:_recommendDietTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
