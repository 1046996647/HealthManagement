//
//  BaseBodyTestVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BodyProTestVC.h"
#import "TestProCell.h"
//#import "TestResultVC.h"

@interface BodyProTestVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UILabel *headerView;
@property(nonatomic,strong) UILabel *markLab;
@property(nonatomic,strong) UIButton *enterBtn;

@property(nonatomic,strong) NSMutableArray *dataList;
@property(nonatomic,assign) NSInteger i;
@property(nonatomic,strong) NSMutableArray *idArr;
@property(nonatomic,strong) ContenModel *model;
@property(nonatomic,strong) BodyModel *bodyModel;



@end

@implementation BodyProTestVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, kScreen_Width, kScreen_Height-64-15)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    // 头视图
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 144/2)];
    //    headerView.text = @"  1、你的精神状况如何，有如下状况吗?";
    headerView.font = [UIFont systemFontOfSize:20];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    [self.view addSubview:footerView];
    
    UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 54/2, kScreen_Width, 18)];
    markLab.textColor = [UIColor colorWithHexString:@"#FF0423"];
    markLab.font = [UIFont systemFontOfSize:16];
    [footerView addSubview:markLab];
    self.markLab = markLab;
    
//    if (self.tag == 1) {
//        markLab.text = @"  * 共45道题，均为单选。";
//        
//    }
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(10, markLab.bottom+54/2, kScreen_Width-20, 100/2);
    enterBtn.layer.cornerRadius = 5;
    enterBtn.layer.masksToBounds = YES;
    [enterBtn setTitle:@"下一题" forState:UIControlStateNormal];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    enterBtn.backgroundColor = [UIColor colorWithHexString:@"#72AFE5"];
    [footerView addSubview:enterBtn];
    [enterBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    self.enterBtn = enterBtn;
    
    footerView.height = enterBtn.bottom;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = footerView;
    
    self.i = 0;
    self.idArr = [NSMutableArray array];
    
    [self getQuestionProfessionList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextAction:(UIButton *)btn
{
    
    if (self.model.isSelected) {
        
        NSString *str = [NSString stringWithFormat:@"%@,%@",self.bodyModel.QuestionId,self.model.OptionId];
        self.model.isSelected = NO;

        // 为最后一页判断
        NSString *lastStr = [self.idArr lastObject];
        if ([lastStr containsString:self.bodyModel.QuestionId]) {
            [self.idArr removeLastObject];
        }
        [self.idArr addObject:str];

        NSLog(@"----%@",self.idArr);

        
    }
    
    
    if ([btn.currentTitle isEqualToString:@"提交"]) {

        
        if (self.idArr.count == 0) {
            [self.view makeToast:@"未选择"];
            return;
        }
        
        
        [self getSubmitQusttion];
    }

    
    if (self.i < self.dataList.count-1) {
        
        self.i++;
        
        BodyModel *model = self.dataList[self.i];
        self.headerView.text = [NSString stringWithFormat:@"  %ld、%@",self.i+1,model.QuestionContent];
        [self.tableView reloadData];
        
        if (self.i == self.dataList.count-1) {
            [btn setTitle:@"提交" forState:UIControlStateNormal];
            
            //            TestResultVC *vc = [[TestResultVC alloc] init];
            //            vc.title = @"体质测试";
            //            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

// 提交结果
-(void)getSubmitQusttion
{
    [SVProgressHUD show];
    
    NSString *answer = [self.idArr componentsJoinedByString:@"|"];
    
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:model.UserId forKey:@"UserId"];
    [paramDic  setValue:answer forKey:@"Answer"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetSubmitQusttion dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        
        if (200 == [code integerValue]) {
            
//            TestResultVC *vc = [[TestResultVC alloc] init];
//            vc.title = @"体质测试";
//            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


-(void)getQuestionProfessionList
{
    [SVProgressHUD show];
    
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:model.UserId forKey:@"Id"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetQuestionProfessionList dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        
        if (200 == [code integerValue]) {
            
            NSArray *arr = [responseObject objectForKey:@"ListData"];
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                
                BodyModel *model = [BodyModel yy_modelWithJSON:dic];
                
                for (NSDictionary *dic1 in model.Options) {
                    ContenModel *contenModel = [ContenModel yy_modelWithJSON:dic1];
                    [model.conten addObject:contenModel];
                    
                }
                
                [arrM addObject:model];
                
            }
            
            self.dataList = arrM;
            BodyModel *model = self.dataList[self.i];
            self.headerView.text = [NSString stringWithFormat:@"  %ld、%@",self.i+1,model.QuestionContent];
            self.markLab.text = [NSString stringWithFormat:@"  * 共%ld道题，均为单选。",self.dataList.count];
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    BodyModel *model = self.dataList[self.i];
    self.bodyModel = model;
    return model.conten.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestProCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[TestProCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.block = ^(ContenModel *model) {
            
            if (self.model != model) {
                self.model.isSelected = NO;
                model.isSelected = YES;
                self.model = model;

            }

            [self.tableView reloadData];
        };
    }
    
    BodyModel *model = self.dataList[self.i];
    ContenModel *contenModel = model.conten[indexPath.row];
    
    cell.textLabel.text = contenModel.OptionContent;
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#6D6D6D"];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    
    cell.model = contenModel;
    return cell;
}



@end
