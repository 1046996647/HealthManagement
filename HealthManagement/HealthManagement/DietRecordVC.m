//
//  DietRecordVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/8/14.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "DietRecordVC.h"
#import "DietRecordCell.h"
#import "DietRecordDetailVC.h"

@interface DietRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataList;
@property(nonatomic,assign) NSInteger pageNO;// 页数


@end

@implementation DietRecordVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.backgroundColor = [UIColor redColor];
        _tableView.tableFooterView = [[UIView alloc] init];

    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        // 获得订单信息列表
        [self getOrderList];
        
    }];


    self.dataList = [NSMutableArray array];
    self.pageNO = 1;

    // 获得订单信息列表
    [self getOrderList];
}

// 获得订单信息列表
- (void)getOrderList
{
    if (self.pageNO == 1) {
        [SVProgressHUD show];
        
    }
    if (self.longitude) {
        
        NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
        [paramDic  setValue:@(self.pageNO) forKey:@"PageNo"];
        //    [paramDic  setObject:imgStr forKey:@"TypeValue"];
        
        [AFNetworking_RequestData requestMethodPOSTUrl:OrderList dic:paramDic Succed:^(id responseObject) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"%@",responseObject);
            
            NSArray *arr = responseObject[@"ListData"];
            if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                
                NSMutableArray *arrM4 = [NSMutableArray array];
                for (NSDictionary *dic in arr) {
                    
                    RecipeModel *model = [RecipeModel yy_modelWithJSON:dic];
                    [arrM4 addObject:model];
                    
                    NSMutableString *strM  = [NSMutableString string];
                    for (NSDictionary *dic in model.foodRecipe) {
                        RecipeItemModel *model = [RecipeItemModel yy_modelWithJSON:dic];
                        [strM appendString:model.ListFood];
                    }
                    model.recordItem = strM;
                }
                [self.tableView.mj_footer endRefreshing];
                
                [self.dataList addObjectsFromArray:arrM4];
                [self.tableView reloadData];
                
                self.pageNO++;
                
            }
            
            else {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } failure:^(NSError *error) {
            
            [SVProgressHUD dismiss];
            [self.tableView.mj_footer endRefreshing];
            
            NSLog(@"%@",error);
            
        }];
    }
    else {
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
        
    }
    
}

- (void)deleteOrder:(RecipeModel *)model
{
//    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:model.OrderId
                 forKey:@"OrderId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:DeleteOrder dic:paramDic Succed:^(id responseObject) {
        
//        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            
            
        }
        else {
            [self.view makeToast:[responseObject objectForKey:@"Message"]];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
//        [SVProgressHUD dismiss];
        
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
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
    RecipeModel *model = self.dataList[indexPath.section];
    [self deleteOrder:model];

    
    [self.dataList removeObject:model];
    [self.tableView reloadData];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RecipeModel *model = self.dataList[indexPath.row];
    
    DietRecordDetailVC *vc = [[DietRecordDetailVC alloc] init];
    vc.title = @"订单详情";
    vc.OrderId = model.OrderId;
    vc.latitude = self.latitude;
    vc.longitude = self.longitude;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DietRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[DietRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //删除scrollView的所有子视图
    while ([cell.scrollView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.scrollView.subviews lastObject] removeFromSuperview];
    }
    
    cell.model = self.dataList[indexPath.row];
    return cell;
}


@end
