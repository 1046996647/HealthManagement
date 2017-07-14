//
//  ResDetailVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/13.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "ResDetailVC.h"
#import "ResDetailHeaderView.h"
#import "ResDetailCell.h"
#import "CookbookDetailVC.h"

@interface ResDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) ResDetailHeaderView *resDetailHeaderView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;


@end

@implementation ResDetailVC
- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"餐厅详情";
    
    _resDetailHeaderView = [[ResDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    [self.view addSubview:_resDetailHeaderView];
    
    self.tableView.tableHeaderView = _resDetailHeaderView;
    [self.view addSubview:self.tableView];
    
    self.dataList = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        ResDetailModel *model = [[ResDetailModel alloc] init];
        [self.dataList addObject:model];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResDetailModel *model = self.dataList[indexPath.row];
    return model.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CookbookDetailVC *vc = [[CookbookDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[ResDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    ResDetailModel *model = self.dataList[indexPath.row];

    cell.model = model;
    //    cell.textLabel.text = self.dataArray[indexPath.row];
    //    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

@end
