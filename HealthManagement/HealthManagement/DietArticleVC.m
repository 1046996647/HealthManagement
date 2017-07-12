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

@property(nonatomic,strong) UIButton *bodyBtn;
@property(nonatomic,strong) UIButton *fitBtn;
@property(nonatomic,strong) UIButton *possibleBtn;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation DietArticleVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, kScreen_Width, kScreen_Height-49-64-self.headerView.height)];
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
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 6)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    [headerView addSubview:line1];
    
    _bodyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bodyBtn.frame = CGRectMake(12, line1.bottom+12, kScreen_Width-12-12, 20);
    [_bodyBtn setImage:[UIImage imageNamed:@"text_1"] forState:UIControlStateNormal];
    //    _nearbyBtn.backgroundColor = [UIColor redColor];
    _bodyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    _bodyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    _bodyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_bodyBtn setTitleColor:[UIColor colorWithHexString:@"#58595A"] forState:UIControlStateNormal];
    [_bodyBtn setTitle:@"您的体质是XXXX" forState:UIControlStateNormal];
    [headerView addSubview:_bodyBtn];
    
    _fitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _fitBtn.frame = CGRectMake(_bodyBtn.left, _bodyBtn.bottom+12, _bodyBtn.width, _bodyBtn.height);
    [_fitBtn setImage:[UIImage imageNamed:@"text_2"] forState:UIControlStateNormal];
    //    _nearbyBtn.backgroundColor = [UIColor redColor];
    _fitBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    _fitBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    _fitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_fitBtn setTitleColor:[UIColor colorWithHexString:@"#58595A"] forState:UIControlStateNormal];
    [_fitBtn setTitle:@"适合吃XXXXX" forState:UIControlStateNormal];
    [headerView addSubview:_fitBtn];
    
    _possibleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _possibleBtn.frame = CGRectMake(_bodyBtn.left, _bodyBtn.bottom+12, _bodyBtn.width, _bodyBtn.height);
    [_possibleBtn setImage:[UIImage imageNamed:@"text_3"] forState:UIControlStateNormal];
    //    _nearbyBtn.backgroundColor = [UIColor redColor];
    _possibleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    _possibleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    _possibleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_possibleBtn setTitleColor:[UIColor colorWithHexString:@"#58595A"] forState:UIControlStateNormal];
    [_possibleBtn setTitle:@"尽量少吃XXXXX" forState:UIControlStateNormal];
    [headerView addSubview:_possibleBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _possibleBtn.bottom+10, kScreen_Width, 6)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    [headerView addSubview:line2];
    
    headerView.height = line2.bottom;
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
