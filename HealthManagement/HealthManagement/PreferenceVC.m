//
//  PreferenceVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PreferenceVC.h"
#import "RecipeModel.h"
#import "NearbyRestaurantTableViewCell.h"
#import "ResDetailVC.h"

@interface PreferenceVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *lastBtn;
@property (nonatomic,strong) NSString *Type_Like;
@property (nonatomic,strong) NSString *idStr;
@property (nonatomic,strong) NSMutableArray *dataList;
@property(nonatomic,assign) NSInteger pageNO;// 页数


@end

@implementation PreferenceVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-15)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    // 头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 128/2)];
    [self.view addSubview:headerView];
    
    NSArray *titleArr = @[@"  个人喜爱",@"  个人讨厌",@"  餐厅收藏"];
    NSArray *imgArrNormal = @[@"recipes_1",@"recipes_6",@"collection_2"];
    NSArray *imgArrSelected = @[@"love",@"recipes_2",@"collection_1"];
//    NSArray *imgArrSelected = @[@"个人喜爱",@"个人讨厌"];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *resBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        resBtn.tag = i;
        resBtn.frame = CGRectMake(i*kScreen_Width/titleArr.count, (headerView.height-90/2)/2, kScreen_Width/titleArr.count, 90/2);
        [resBtn setImage:[UIImage imageNamed:imgArrNormal[i]] forState:UIControlStateNormal];
        [resBtn setImage:[UIImage imageNamed:imgArrSelected[i]] forState:UIControlStateSelected];
        [resBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [resBtn setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
        [resBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        resBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        resBtn.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:resBtn];
        [resBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i<imgArrNormal.count-1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(resBtn.width-1, (resBtn.height-22)/2, 1, 22)];
            line.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
            [resBtn addSubview:line];
            

        }
        
        if (i==0) {
            self.lastBtn = resBtn;
            resBtn.selected = YES;
        }

    }
    
    self.tableView.tableHeaderView = headerView;
    self.Type_Like = @"foodlike";
    
    [self getSelectUserPreference];
    
    self.dataList = [NSMutableArray array];
    self.pageNO = 1;

    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    if (self.lastBtn.tag == 2) {
//        
//        [self getUserPreferenceRest];
//        
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 餐厅收藏
- (void)getUserPreferenceRest
{
    
    if (self.pageNO == 1) {
        [SVProgressHUD show];
        
    }
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:[InfoCache getValueForKey:@"longitude"] forKey:@"CoordX"];
    [paramDic  setObject:[InfoCache getValueForKey:@"latitude"] forKey:@"CoordY"];
    [paramDic  setValue:@(self.pageNO) forKey:@"PageNo"];

    
    [AFNetworking_RequestData requestMethodPOSTUrl:UserPreferenceRest dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];

        
        NSLog(@"%@",responseObject);
        
        if (self.pageNO == 1) {
            [self.dataList removeAllObjects];
            
            [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
            
        }
        
        NSMutableArray *arrM = [NSMutableArray array];

        NSArray *arr = responseObject[@"ListData"];
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
            
            
            for (NSDictionary *dic in arr) {

                ResDetailModel *model = [ResDetailModel yy_modelWithJSON:dic];
                
                NSArray *modelArr = [NSArray arrayWithObject:model];
                [arrM addObject:modelArr];
            }
            
            self.pageNO++;


        }
        else {
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.dataList addObjectsFromArray:arrM];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];

        NSLog(@"%@",error);
        
    }];
    
}


// 用户偏好
- (void)getSelectUserPreference
{
    
    [SVProgressHUD show];

    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setValue:self.Type_Like forKey:@"Type_Like"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:SelectUserPreference dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        if (self.pageNO == 1) {
            [self.dataList removeAllObjects];
            
            [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
            
        }
        
        NSArray *arr = responseObject[@"ListData"];
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                FoodModel *model = [FoodModel yy_modelWithJSON:dic];
                
                NSArray *modelArr = [NSArray arrayWithObject:model];
                [arrM addObject:modelArr];
            }
            self.dataList = arrM;
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",error);
        
    }];
    
}


- (void)btnAction:(UIButton *)btn
{
    
    self.lastBtn.selected = NO;
    btn.selected = YES;
    
    if (self.lastBtn.tag != btn.tag) {
        
        self.pageNO = 1;

        if (btn.tag == 0) {
            
            // 上拉刷新
            self.tableView.mj_footer = nil;

            
            self.Type_Like = @"foodlike";
            [self getSelectUserPreference];
        }
        if (btn.tag == 1) {
            
            // 上拉刷新
            self.tableView.mj_footer = nil;
            
            self.Type_Like = @"foodunlike";
            [self getSelectUserPreference];
        }
        if (btn.tag == 2) {
            
            // 上拉刷新
            self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                
                // 请求餐厅列表
                [self getUserPreferenceRest];
                
            }];
            
            self.Type_Like = @"restlike";
            [self getUserPreferenceRest];
        }
    }

    self.lastBtn = btn;


}

// 喜好请求
- (void)getCustomerLikeOrNot:(NSIndexPath *)indexPath
{
//    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:self.idStr forKey:@"OtherId"];
    [paramDic  setObject:self.Type_Like forKey:@"Type_Like"];
    [paramDic  setObject:@"Delete" forKey:@"Opertion"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:CustomerLikeOrNot dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            
        }

        
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
}


#pragma mark - UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *modelArr = self.dataList[section];
    return modelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.lastBtn.tag == 2) {
        return 131-6;
    }
    return 52;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//修改左滑的按钮的字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    
    return @"删除";

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *modelArr = self.dataList[indexPath.section];
    
    if (self.lastBtn.tag == 2) {
        
        ResDetailModel *model = modelArr[indexPath.row];
        self.idStr = model.ID;

    }
    else {
        FoodModel *model = modelArr[indexPath.row];
        
        self.idStr = model.FoodId;

    }
    [self getCustomerLikeOrNot:indexPath];
    
    if (self.dataList.count > 0) {
        [self.dataList removeObjectAtIndex:indexPath.section];
        [self.tableView reloadData];
        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.lastBtn.tag == 2) {
        
        NSArray *modelArr = self.dataList[indexPath.section];
        ResDetailModel *model = modelArr[indexPath.row];
        
        ResDetailVC *vc = [[ResDetailVC alloc] init];
        vc.resID = model.ID;
        //    vc.model = self.modelArr[indexPath.row];
        vc.latitude = [InfoCache getValueForKey:@"latitude" ];
        vc.longitude = [InfoCache getValueForKey:@"longitude"];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.lastBtn.tag == 2) {
        
        NearbyRestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (cell == nil) {
            
            cell = [[NearbyRestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
            
        }
        NSArray *modelArr = self.dataList[indexPath.section];
        ResDetailModel *model = modelArr[indexPath.row];
        cell.model = model;
        
        return cell;
        
    }
    else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSArray *modelArr = self.dataList[indexPath.section];
        FoodModel *model = modelArr[indexPath.row];
        cell.textLabel.text = model.FoodName;
        //    cell.textLabel.textColor = [UIColor colorWithHexString:@"#6D6D6D"];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
        
        return cell;
    }
    
    return nil;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}


@end
