//
//  BodyDataVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BodyDataVC.h"

@interface BodyDataVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *leftDataList;
@property(nonatomic,strong) NSArray *rightDataList;
@property(nonatomic,strong) UIImageView *headImg;


@end

@implementation BodyDataVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftDataList = @[@"出生日期",@"身高",@"体重",@"劳动强度"];
    self.rightDataList = @[@"2012年12月12日",@"165 cm",@"56 kg",@"一般"];
    
    // 头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 16)];
    view.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [headerView addSubview:view];
    
    UIImageView *maleImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2-35-150/2, view.bottom+45, 150/2, 90/2)];
    maleImg.image = [UIImage imageNamed:@"body_3"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:maleImg];
    
    UIImageView *femaleImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2+35, view.bottom+45, 150/2, 90/2)];
    femaleImg.image = [UIImage imageNamed:@"body_5"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:femaleImg];
    
    headerView.height = femaleImg.bottom+45;
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
//    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(10, 25, kScreen_Width-20, 104/2);
    enterBtn.layer.cornerRadius = 5;
    enterBtn.layer.masksToBounds = YES;
    [enterBtn setTitle:@"保存" forState:UIControlStateNormal];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    enterBtn.backgroundColor = [UIColor colorWithHexString:@"#72AFE5"];
    [footerView addSubview:enterBtn];
    [enterBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    footerView.height = enterBtn.bottom+25;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = footerView;
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveAction
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 116/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    
    
    cell.textLabel.text = self.leftDataList[indexPath.row];
    //    cell.textLabel.textColor = [UIColor colorWithHexString:@"#6D6D6D"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    
    cell.detailTextLabel.text = self.rightDataList[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#898989"];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:17];
    return cell;
}
@end
