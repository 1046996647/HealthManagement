//
//  NearbyRestaurantVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "DietArticleVC.h"
#import "DietArticleCell.h"

@interface DietArticleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UILabel *bodyLab;
@property(nonatomic,strong) UILabel *fitLab;
@property(nonatomic,strong) UILabel *possibleLab;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation DietArticleVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-64-25)];
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
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headerView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 6)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    [headerView addSubview:line1];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, line1.bottom+12, 20, 30)];
    imgView1.image = [UIImage imageNamed:@"text_3"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:imgView1];
    
    _bodyLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView1.right+10, imgView1.center.y-10, kScreen_Width-12-12, 20)];
    _bodyLab.font = [UIFont systemFontOfSize:14];
    _bodyLab.textColor = [UIColor colorWithHexString:@"#58595A"];
    _bodyLab.text = @"您的体质是XXXX";
    [headerView addSubview:_bodyLab];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(12, _bodyLab.bottom+20, 20, 30)];
    imgView2.image = [UIImage imageNamed:@"text_2"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:imgView2];

    _fitLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView2.right+10, imgView2.center.y-10, kScreen_Width-12-12, 20)];
    _fitLab.font = [UIFont systemFontOfSize:14];
    _fitLab.textColor = [UIColor colorWithHexString:@"#58595A"];
    _fitLab.text = @"适合吃XXXX";
    [headerView addSubview:_fitLab];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(12, _fitLab.bottom+20, 20, 30)];
    imgView3.image = [UIImage imageNamed:@"text_1"];
    imgView3.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:imgView3];
    
    _possibleLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView3.right+10, imgView3.center.y-10, kScreen_Width-12-12, 20)];
    _possibleLab.font = [UIFont systemFontOfSize:14];
    _possibleLab.textColor = [UIColor colorWithHexString:@"#58595A"];
    _possibleLab.text = @"尽量少吃XXXX";
    [headerView addSubview:_possibleLab];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _possibleLab.bottom+12, kScreen_Width, 6)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    [headerView addSubview:line2];
    
    headerView.height = line2.bottom;
    self.tableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70+24+10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DietArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[DietArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    //    cell.textLabel.text = self.dataArray[indexPath.row];
    //    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

@end
