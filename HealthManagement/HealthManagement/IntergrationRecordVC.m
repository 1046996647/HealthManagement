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
@property(nonatomic,strong) NSMutableArray *dataArray;

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
    
    NSMutableArray *arrM = [NSMutableArray array];
    NSMutableArray *arrM1 = [NSMutableArray array];
    
    // 去掉一样日期（如：2013-12）
    
    for (int i=0; i<2; i++) {
        IntergrationRecordModel *model = [[IntergrationRecordModel alloc] init];
        
        if (i==0) {
            model.fullPayTime = @"2017-07-22 12:12";

        }
        else {
            model.fullPayTime = @"2017-06-22 12:12";

        }
        model.fullPayTime = [model.fullPayTime substringToIndex:10];
        model.payTime = [model.fullPayTime substringToIndex:7];

        if (![arrM containsObject:model.payTime]) {
            
            [arrM addObject:model.payTime];
            
            TimeModel *timeModel = [[TimeModel alloc] init];
            timeModel.timeStr = model.payTime;
            [arrM1 addObject:timeModel];
        }
    }

    _dataArray = arrM1;
    
    // 归类
    for (TimeModel *timeModel in arrM1) {
        
        for (int i=0; i<2; i++) {
            IntergrationRecordModel *model = [[IntergrationRecordModel alloc] init];
            
            if (i==0) {
                model.fullPayTime = @"2017-07-27 12:12";
                
            }
            else {
                model.fullPayTime = @"2017-06-22 12:12";
                
            }
            model.fullPayTime = [model.fullPayTime substringToIndex:10];
            model.payTime = [model.fullPayTime substringToIndex:7];
            
            if ([timeModel.timeStr isEqualToString:model.payTime]) {
                [timeModel.headCellArray addObject:model];
            }
        }
    
        
    }
    
    [self.view addSubview:self.tableView];
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
