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

    
    // 请求餐厅详情
    [self getRestaurantInfoById];
}

// 请求餐厅详情
- (void)getRestaurantInfoById
{
    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:self.resID forKey:@"id"];
    [paramDic  setObject:self.longitude forKey:@"CoordX"];
    [paramDic  setObject:self.latitude forKey:@"CoordY"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetRestaurantInfoById dic:paramDic Succed:^(id responseObject) {
        
        
        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"ListData"];
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
            
            [self getRecipeListInfoByDRId];
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                ResDetailModel *model = [ResDetailModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            _resDetailHeaderView.model = [arrM firstObject];
             
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
}

// 请求菜谱列表
- (void)getRecipeListInfoByDRId
{
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:self.resID forKey:@"id"];
//    [paramDic  setObject:self.longitude forKey:@"CoordX"];
//    [paramDic  setObject:self.latitude forKey:@"CoordY"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetRecipeListInfoByDRId dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"ListData"];
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {

            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                RecipeModel *model = [RecipeModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            self.dataList = arrM;
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecipeModel *model = self.dataList[indexPath.row];
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
    vc.model = self.dataList[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ResDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[ResDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.reloadBlock = ^{
            [tableView reloadData];
        };
    }
    
    //删除alphaView的所有子视图
    while ([cell.alphaView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.alphaView.subviews lastObject] removeFromSuperview];
    }
    
    //删除view1的所有子视图
    while ([cell.view1.subviews lastObject] != nil)
    {
        [(UIView*)[cell.view1.subviews lastObject] removeFromSuperview];
    }
    
    RecipeModel *model = self.dataList[indexPath.row];

    cell.model = model;
    //    cell.textLabel.text = self.dataArray[indexPath.row];
    //    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

@end
