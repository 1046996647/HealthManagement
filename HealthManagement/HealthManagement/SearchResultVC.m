//
//  SearchResultVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SearchResultVC.h"
#import "NearbyRestaurantTableViewCell.h"
#import "DietArticleCell.h"
#import "RecommendDietCell.h"

@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIButton *nearbyBtn;
@property(nonatomic,strong) UIButton *recommendBtn;
@property(nonatomic,strong) UIView *bottomLine;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,assign) NSInteger tag;

@end

@implementation SearchResultVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bottomLine.bottom, kScreen_Width, kScreen_Height-64-self.bottomLine.bottom)];
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
    
    // 附近餐厅按钮
    _nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nearbyBtn.frame = CGRectMake(0, 0, kScreen_Width/2.0, 50);
    [_nearbyBtn setImage:[UIImage imageNamed:@"icon_shop"] forState:UIControlStateNormal];
    [_nearbyBtn setImage:[UIImage imageNamed:@"Restaurant_1"] forState:UIControlStateSelected];
    _nearbyBtn.backgroundColor = [UIColor whiteColor];
    _nearbyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    _nearbyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    _nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_nearbyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_nearbyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    _nearbyBtn.tag = 100;
    [_nearbyBtn setTitle:@"附近餐厅" forState:UIControlStateNormal];
    [_nearbyBtn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    _nearbyBtn.selected = YES;
    [self.view addSubview:_nearbyBtn];
    
    // 推荐饮食按钮
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(kScreen_Width/2.0, _nearbyBtn.top, kScreen_Width/2.0, 50);
    [_recommendBtn setImage:[UIImage imageNamed:@"Restaurant_2"] forState:UIControlStateNormal];
    [_recommendBtn setImage:[UIImage imageNamed:@"diet_2"] forState:UIControlStateSelected];
    _recommendBtn.backgroundColor = [UIColor whiteColor];
    //    _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_recommendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    _recommendBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    _recommendBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    //    _recommendBtn.selected = YES;
    _recommendBtn.tag = 101;
    [_recommendBtn setTitle:@"推荐饮食" forState:UIControlStateNormal];
    [_recommendBtn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_recommendBtn];
    
    // 底线
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _recommendBtn.bottom, kScreen_Width/2.0, 3)];
    _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#EA3D00"];
    [self.view addSubview:_bottomLine];
    
    // 默认显示附近餐厅
    self.tag = _nearbyBtn.tag;

    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)exchangeAction:(UIButton *)btn
{
    self.tag = btn.tag;
    [_tableView reloadData];

    if (btn.tag == 100) {
        
        _nearbyBtn.selected = YES;
        _recommendBtn.selected = NO;
        
        [UIView animateWithDuration:.35 animations:^{
            _bottomLine.left = 0;
            
        }];
        
    }
    else {
        _nearbyBtn.selected = NO;
        _recommendBtn.selected = YES;
        
        [UIView animateWithDuration:.35 animations:^{
            _bottomLine.left = kScreen_Width/2;
            
        }];
        
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        if (self.tag == 100) {
            
            return 117;

        }
        else {
            return 117+5;

        }
        
    }
    return 70+24+10-9;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    if (section == 0) {
        return 3;
    }
    else {
        return 9;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else {
        return 25;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 25)];
        headerView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        
        UILabel *hotLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 2,198/2, 15)];
        hotLab.font = [UIFont boldSystemFontOfSize:13];
        hotLab.text = @"   推荐饮食文章";
//        hotLab.textAlignment = NSTextAlignmentLeft;
        hotLab.textColor = [UIColor colorWithHexString:@"#595959"];
        [headerView addSubview:hotLab];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(hotLab.right, hotLab.center.y-.25, kScreen_Width-hotLab.right-10, .5)];
        view.backgroundColor = [UIColor grayColor];
        [headerView addSubview:view];
        return headerView;

    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    ResDetailVC *vc = [[ResDetailVC alloc] init];
//    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        if (self.tag == 100) {

            NearbyRestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
            
            if (cell == nil) {
                cell = [[NearbyRestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
                
            }
            //    cell.textLabel.text = self.dataArray[indexPath.row];
            //    cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
        }
        else {
            
            RecommendDietCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];
            if (cell == nil) {
                
                cell = [[RecommendDietCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"threeCell"];
                
            }
            //    cell.textLabel.text = self.dataArray[indexPath.row];
            //    cell.textLabel.font = [UIFont systemFontOfSize:14];
            return cell;
            
        }
        


    }
    else {
        DietArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        if (cell == nil) {
            
            cell = [[DietArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondCell"];
        }
        cell.type = 1;

    //    cell.textLabel.text = self.dataArray[indexPath.row];
    //    cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;

    }
    return nil;

}

@end
