//
//  IntergrationRecordVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "IntergrationRecordVC.h"
#import "IntergrationRecordCell.h"

@interface IntergrationRecordVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

// 原始数据
@property(nonatomic,strong) NSMutableArray *resourceArray;

@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,assign) NSInteger pageNO;// 页数
//@property(nonatomic,strong) NSMutableArray *modelArr;


@end

@implementation IntergrationRecordVC

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
    
    [self.view addSubview:self.tableView];
    
    self.resourceArray = [NSMutableArray array];
    
    self.pageNO = 1;
    [self getScoreList];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getScoreList)];
}

// 获得积分记录
- (void)getScoreList
{
    
    if (self.pageNO == 1) {
        [SVProgressHUD show];
        
    }
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setValue:@(self.pageNO) forKey:@"PageNo"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetScoreList dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];

        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"ListData"];
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {

            // 添加刷新的数据，再重新分类
            [self.resourceArray addObjectsFromArray:arr];
            
            NSMutableArray *arrM = [NSMutableArray array];
            NSMutableArray *arrM1 = [NSMutableArray array];
            
            // 去掉一样日期（如：2013-12）
            for (NSDictionary *dic in self.resourceArray) {
                IntergrationRecordModel *model = [IntergrationRecordModel yy_modelWithJSON:dic];
                if (![arrM containsObject:model.Time]) {
                    
                    [arrM addObject:model.Time];
                    
                    TimeModel *timeModel = [[TimeModel alloc] init];
                    timeModel.timeStr = model.Time;
                    [arrM1 addObject:timeModel];
                }
            }
            
            // 归类
            for (TimeModel *timeModel in arrM1) {
                
                for (NSDictionary *dic in self.resourceArray) {
                    
                    IntergrationRecordModel *model = [IntergrationRecordModel yy_modelWithJSON:dic];
                    
                    if ([timeModel.timeStr isEqualToString:model.Time]) {
                        [timeModel.headCellArray addObject:model];
                    }
                }
                
            }
            
            [self.tableView.mj_footer endRefreshing];

            self.dataArray = arrM1;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 142/2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TimeModel *timeModel = _dataArray[section];
    return timeModel.headCellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IntergrationRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[IntergrationRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TimeModel *timeModel = _dataArray[indexPath.section];
    cell.model = timeModel.headCellArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 72/2;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TimeModel *timeModel = _dataArray[section];

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width-12, 72/2)];
    lab.backgroundColor = [UIColor colorWithHexString:@"#F1EFF5"];
    lab.textColor = [UIColor colorWithHexString:@"#333333"];
    lab.font = [UIFont systemFontOfSize:16];
    lab.text = [NSString stringWithFormat:@"   %@",[NSString isSameMonth:timeModel.timeStr]];

    
    return lab;
}


@end
