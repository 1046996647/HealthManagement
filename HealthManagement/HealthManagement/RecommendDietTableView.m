//
//  RecommendDietTableView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/12.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "RecommendDietTableView.h"
#import "RecommendDietCell.h"
#import "CookbookDetailVC.h"

@implementation RecommendDietTableView

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 36, kScreen_Width, self.height-36)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 36)];
        baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:baseView];
        
        NSArray *titleArr = @[@"适合我的",@"销量最高",@"距离最近",@"类型"];
        CGFloat width = kScreen_Width/titleArr.count;
        for (int i=0; i<titleArr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width*i, 0, width, baseView.height);
            //    _nearbyBtn.backgroundColor = [UIColor redColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            //            _recommendBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
            //    _recommendBtn.selected = YES;
            btn.tag = 100+i;
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if (i < titleArr.count-1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width*(i+1), (baseView.height-14)/2, 1, 14)];
                line.backgroundColor = [UIColor colorWithHexString:@"#EDEEEE"];
                [self addSubview:line];
            }
            
            if (i == titleArr.count-1) {
                
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
                
                _imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+15, (baseView.height-10)/2, 15, 10)];
                _imgView1.image = [UIImage imageNamed:@"down"];
                //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
                [btn addSubview:_imgView1];
            }
            
            if (i == 0) {
                self.lastBtn = btn;
                btn.selected = YES;
                
            }
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, baseView.bottom-.5, kScreen_Width, .5)];
        view.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
        [self addSubview:view];
        
        // 表视图
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 6)];
        headerView.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
        self.tableView.tableHeaderView = headerView;
        
        // 表视图
        [self addSubview:self.tableView];
        self.modelArr = [NSMutableArray array];

        
        //        // 下拉刷新
        //        self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //
        //
        //            [self.tableView.mj_header endRefreshing];
        //
        //        }];
        
        // 上拉刷新
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            // 请求饮食列表
            [self getRecipeListByGPS];
            
        }];

        
    }
    return self;
}

// 请求饮食列表
- (void)getRecipeListByGPS
{
    
    if (self.pageNO == 1) {
        [SVProgressHUD show];
        
    }
    
    if (self.longitude) {
        
        PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];
        
        NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
        [paramDic  setValue:self.longitude forKey:@"CoordX"];
        [paramDic  setValue:self.latitude forKey:@"CoordY"];
        [paramDic  setValue:self.groupBy forKey:@"GroupBy"];
        [paramDic  setValue:@(self.pageNO) forKey:@"PageNo"];
        [paramDic  setObject:person.UserId forKey:@"UserId"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:RecipeListByGPS dic:paramDic Succed:^(id responseObject) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"%@",responseObject);
            
            NSArray *arr = responseObject[@"ListData"];
            if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                
                if (self.pageNO == 1) {
                    [self.modelArr removeAllObjects];
                    
                    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
                    
                }
                
                NSMutableArray *arrM = [NSMutableArray array];
                for (NSDictionary *dic in arr) {
                    RecipeModel *model = [RecipeModel yy_modelWithJSON:dic];
                    [arrM addObject:model];
                }
                [self.tableView.mj_footer endRefreshing];
                
                [self.modelArr addObjectsFromArray:arrM]; ;
                [self.tableView reloadData];
                
                self.pageNO++;
                
                
            }
            
            else {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                //            _tableView.mj_footer.automaticallyHidden = YES;
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            
            NSLog(@"%@",error);
            
        }];
    }
    else {
        [SVProgressHUD dismiss];
        
    }
    
}

- (void)exchangeAction:(UIButton *)btn
{
    
    if (btn.tag < 103) {
        self.lastBtn.selected = NO;
        btn.selected = YES;
        
        if (self.lastBtn.tag != btn.tag) {
            if (btn.tag == 100) {
                self.pageNO = 1;
                self.groupBy = @"SuitMe";
                
            }
            else if (btn.tag == 101) {
                self.pageNO = 1;
                self.groupBy = @"SalesVolume";
            }
            else if (btn.tag == 102) {
                self.pageNO = 1;
                self.groupBy = @"Distance";
            }
            //            else if (btn.tag == 103) {
            //
            //                if (btn.selected) {
            //                    _imgView1.image = [UIImage imageNamed:@"up"];
            //
            //                }
            //                else {
            //                    _imgView1.image = [UIImage imageNamed:@"down"];
            //
            //                }
            //
            //            }
            // 请求餐厅列表
//            [self getRestaurantListInfo];
            
        }
        
        self.lastBtn = btn;
    }

}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    RecipeModel *model = self.modelArr[indexPath.row];
    
    return 144;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CookbookDetailVC *vc = [[CookbookDetailVC alloc] init];
    vc.model = self.modelArr[indexPath.row];
    vc.mark = 1;
    vc.latitude = self.latitude;
    vc.longitude = self.longitude;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecommendDietCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[RecommendDietCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.model = self.modelArr[indexPath.row];

    return cell;
}

- (void)setGroupBy:(NSString *)groupBy
{
    _groupBy = groupBy;
    
    self.pageNO = 1;
    // 请求餐厅列表
    [self getRecipeListByGPS];
    
}

@end
