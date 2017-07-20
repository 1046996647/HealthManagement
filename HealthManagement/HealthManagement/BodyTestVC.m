//
//  BaseBodyTestVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BodyTestVC.h"
#import "TestCell.h"
#import "TestResultVC.h"

@interface BodyTestVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;


@end

@implementation BodyTestVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, kScreen_Width, kScreen_Height-64-15)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    // 头视图
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 144/2)];
    headerView.text = @"  1、你的精神状况如何，有如下状况吗?";
    headerView.font = [UIFont systemFontOfSize:20];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    [self.view addSubview:footerView];
    
    UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 54/2, kScreen_Width, 18)];
    markLab.text = @"  * 共7道题，均为多选。";
    markLab.textColor = [UIColor colorWithHexString:@"#FF0423"];
    markLab.font = [UIFont systemFontOfSize:16];
    [footerView addSubview:markLab];
    
    if (self.tag == 1) {
        markLab.text = @"  * 共45道题，均为单选。";

    }
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(10, markLab.bottom+54/2, kScreen_Width-20, 100/2);
    enterBtn.layer.cornerRadius = 5;
    enterBtn.layer.masksToBounds = YES;
    [enterBtn setTitle:@"下一题" forState:UIControlStateNormal];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    enterBtn.backgroundColor = [UIColor colorWithHexString:@"#72AFE5"];
    [footerView addSubview:enterBtn];
    [enterBtn addTarget:self action:@selector(resultAction) forControlEvents:UIControlEventTouchUpInside];

    
    footerView.height = enterBtn.bottom;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resultAction
{
    TestResultVC *vc = [[TestResultVC alloc] init];
    vc.title = @"体质测试";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[TestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.wechatBtn addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.textLabel.text = @"情绪稳定，性格平和";
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#6D6D6D"];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (void)testAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

@end
