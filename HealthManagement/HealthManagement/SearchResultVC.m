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
#import "UITableView+EmptyData.h"


@interface SearchResultVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UIButton *nearbyBtn;
@property(nonatomic,strong) UIButton *recommendBtn;
@property(nonatomic,strong) UIView *bottomLine;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *lastBtn;
@property(nonatomic,assign) NSInteger tag;

@property(nonatomic,strong) NSMutableArray *resArr;
@property(nonatomic,strong) NSMutableArray *dietArr;
@property(nonatomic,strong) NSMutableArray *articleArr;


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
    _nearbyBtn.frame = CGRectMake(0, 0, kScreen_Width/2.0, 40);
    [_nearbyBtn setImage:[UIImage imageNamed:@"icon_shop"] forState:UIControlStateNormal];
    [_nearbyBtn setImage:[UIImage imageNamed:@"Restaurant_1"] forState:UIControlStateSelected];
    _nearbyBtn.backgroundColor = [UIColor whiteColor];
    _nearbyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    _nearbyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    _nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_nearbyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_nearbyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    _nearbyBtn.tag = 100;
    [_nearbyBtn setTitle:@"附近餐厅" forState:UIControlStateNormal];
    [_nearbyBtn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    _nearbyBtn.selected = YES;
    [self.view addSubview:_nearbyBtn];
    
    // 推荐饮食按钮
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(kScreen_Width/2.0, _nearbyBtn.top, kScreen_Width/2.0, 40);
    [_recommendBtn setImage:[UIImage imageNamed:@"Restaurant_2"] forState:UIControlStateNormal];
    [_recommendBtn setImage:[UIImage imageNamed:@"diet_2"] forState:UIControlStateSelected];
    _recommendBtn.backgroundColor = [UIColor whiteColor];
    //    _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
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
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _recommendBtn.bottom, kScreen_Width/2.0, 1)];
    _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#EA3D00"];
    [self.view addSubview:_bottomLine];
    
    // 默认显示附近餐厅
    self.tag = _nearbyBtn.tag;

    [self.view addSubview:self.tableView];
    
    [self searchVagueRestaurant];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 搜索
- (void)searchVagueRestaurant
{
    
    [SVProgressHUD show];
    
    if (self.longitude) {
        
        NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
        [paramDic  setValue:self.longitude forKey:@"CoordX"];
        [paramDic  setValue:self.latitude forKey:@"CoordY"];
        [paramDic  setValue:@(1) forKey:@"PageNo"];
        [paramDic  setObject:self.searchText forKey:@"Name"];
        [paramDic  setObject:@"All" forKey:@"SearchType"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:SearchVagueRestaurant dic:paramDic Succed:^(id responseObject) {
            
            [SVProgressHUD dismiss];
            [self.tableView.mj_footer endRefreshing];

            
            NSLog(@"%@",responseObject);
            
            NSNumber *code = responseObject[@"HttpCode"];
            
            if (code.integerValue == 200) {
                
                NSArray *arr = responseObject[@"ListData"];
                if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                    
                    NSMutableArray *arrM = [NSMutableArray array];
                    for (NSDictionary *dic in arr) {
                        ResDetailModel *model = [ResDetailModel yy_modelWithJSON:dic];
                        [arrM addObject:model];
                        
                        
                    }
                    self.resArr = arrM;
                    
                    
                }
                
                NSArray *arr2 = responseObject[@"ListData2"];
                if ([arr2 isKindOfClass:[NSArray class]] && arr2.count > 0) {
                    
                    NSMutableArray *arrM2 = [NSMutableArray array];
                    for (NSDictionary *dic in arr2) {
                        ArticleModel *model = [ArticleModel yy_modelWithJSON:dic];
                        [arrM2 addObject:model];
                        
                        
                    }
                    self.articleArr = arrM2;

                    
                }
                
                NSArray *arr3 = responseObject[@"ListData3"];
                if ([arr3 isKindOfClass:[NSArray class]] && arr3.count > 0) {
                    
                    NSMutableArray *arrM3 = [NSMutableArray array];
                    for (NSDictionary *dic in arr3) {
                        RecipeModel *model = [RecipeModel yy_modelWithJSON:dic];
                        [arrM3 addObject:model];
                        
                        
                    }
                    self.dietArr = arrM3;
                    
                    
                }
                
                [self.tableView reloadData];

            }
            

            
        } failure:^(NSError *error) {
            
            [SVProgressHUD dismiss];
            
            [self.tableView.mj_footer endRefreshing];

            
            NSLog(@"%@",error);
            
        }];
    }
    
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
            
            return 131;

        }
        else {
            return 144;

        }
        
    }
    return 70+24+6;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.resArr.count==0 && self.dietArr.count==0 && self.articleArr.count==0) {
        [tableView tableViewDisplayWitMsg:@"搜索无结果~" ifNecessaryForRowCount:0];
    }
    else {
        [tableView tableViewDisplayWitMsg:@"搜索无结果~" ifNecessaryForRowCount:1];

    }
    
    if (section == 0) {
        
        if (self.tag == 100) {
            return self.resArr.count;

        }
        else {
            return self.dietArr.count;

        }
    }
    else {
        return self.articleArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else {
        
        if (self.articleArr.count > 0) {
            return 25;

        }
        else {
            return 0;

        }
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
            
            ResDetailModel *model = self.resArr[indexPath.row];
            cell.model = model;

            return cell;
        }
        else {
            
            RecommendDietCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];
            if (cell == nil) {
                
                cell = [[RecommendDietCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"threeCell"];
                
            }
            RecipeModel *model = self.dietArr[indexPath.row];
            cell.model = model;

            return cell;
            
        }
        


    }
    else {
        DietArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
        if (cell == nil) {
            
            cell = [[DietArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondCell"];
        }
//        cell.type = 1;
        ArticleModel *model = self.articleArr[indexPath.row];
        cell.model = model;

        return cell;

    }
    return nil;

}

@end
