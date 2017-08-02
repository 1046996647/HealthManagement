//
//  NearbyRestaurantTableView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NearbyRestaurantTableView.h"
#import "NearbyRestaurantTableViewCell.h"
#import "ResDetailVC.h"


@implementation NearbyRestaurantTableView

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 37+5, kScreen_Width, self.height-(37+5))];
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
        
        NSArray *titleArr = @[@"距离最近",@"销量最高",@"适合我的",@"类型"];
        CGFloat width = kScreen_Width/titleArr.count;
        for (int i=0; i<titleArr.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(width*i, 0, width, baseView.height);
            //    _nearbyBtn.backgroundColor = [UIColor redColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
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
            
            if (self.modelArr.count > 0) {
                // 请求餐厅列表
                [self getRestaurantListInfo];
            }

        }];
        
        // 右下角视图
        _besideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _besideBtn.frame = CGRectMake(self.width-140, self.height-80-40, 140, 50);
//        _besideBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_besideBtn setImage:[UIImage imageNamed:@"Restaurant_4"] forState:UIControlStateNormal];
        [self addSubview:_besideBtn];
        


        
    }
    return self;
}

//- (void)headerRefresh
//{
//    self.pageNO = 1;
//    [self getRestaurantListInfo];
//}

// 请求餐厅列表
- (void)getRestaurantListInfo
{
    
    if (self.pageNO == 1) {
        [SVProgressHUD show];

    }
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

    if (self.longitude) {
        
        NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
        [paramDic  setValue:self.longitude forKey:@"CoordX"];
        [paramDic  setValue:self.latitude forKey:@"CoordY"];
        [paramDic  setValue:self.groupBy forKey:@"GroupBy"];
        [paramDic  setValue:@(self.pageNO) forKey:@"PageNo"];
        //    [paramDic  setObject:imgStr forKey:@"TypeValue"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:GetRestaurantListInfo dic:paramDic Succed:^(id responseObject) {
            
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
                    ResDetailModel *model = [ResDetailModel yy_modelWithJSON:dic];
                    [arrM addObject:model];
                    
                    NSLog(@"---%@",model.name);

                }
                [self.tableView.mj_footer endRefreshing];
                
                [self.modelArr addObjectsFromArray:arrM]; ;
                [self.tableView reloadData];
                
                self.pageNO++;
                
            }
            
            else {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            
            NSLog(@"%@",error);
            
        }];
    }
    
}


- (void)exchangeAction:(UIButton *)btn
{
//    btn.selected = !btn.selected;
    if (btn.tag < 103) {
        self.lastBtn.selected = NO;
        btn.selected = YES;
        
        if (self.lastBtn.tag != btn.tag) {
            if (btn.tag == 100) {
                self.pageNO = 1;
                self.groupBy = @"Distance";
                
            }
            else if (btn.tag == 101) {
                self.pageNO = 1;
                self.groupBy = @"SalesVolume";
            }
            else if (btn.tag == 102) {
                self.pageNO = 1;
                self.groupBy = @"SuitMe";
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
            [self getRestaurantListInfo];
            
        }
        
        self.lastBtn = btn;
    }
    

    
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    ResDetailModel *model = self.modelArr[indexPath.row];

    return 131;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return self.modelArr.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ResDetailVC *vc = [[ResDetailVC alloc] init];
    vc.model = self.modelArr[indexPath.row];
    vc.latitude = self.latitude;
    vc.longitude = self.longitude;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NearbyRestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[NearbyRestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    ResDetailModel *model = self.modelArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:.35 animations:^{
        _besideBtn.left = kScreen_Width-_besideBtn.width/3;
        
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"----%d",(int)scrollView.contentOffset.x);

    [UIView animateWithDuration:.35 animations:^{
        _besideBtn.left = kScreen_Width-_besideBtn.width;
        
    }];

}


- (void)setGroupBy:(NSString *)groupBy
{
    _groupBy = groupBy;
    
    self.pageNO = 1;
    // 请求餐厅列表
    [self getRestaurantListInfo];

}


@end
