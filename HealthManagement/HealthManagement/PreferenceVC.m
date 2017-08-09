//
//  PreferenceVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PreferenceVC.h"
#import "RecipeModel.h"

@interface PreferenceVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *lastBtn;
@property (nonatomic,strong) NSString *Type_Like;
@property (nonatomic,strong) NSMutableArray *dataList;


@end

@implementation PreferenceVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-15)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
    
    NSArray *titleArr = @[@"  个人喜爱",@"  个人讨厌"];
    NSArray *imgArrNormal = @[@"love",@"recipes_6"];
//    NSArray *imgArrSelected = @[@"个人喜爱",@"个人讨厌"];
    for (int i=0; i<titleArr.count; i++) {
        
        UIButton *resBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        resBtn.tag = i;
        resBtn.frame = CGRectMake(i*kScreen_Width/2.0, (headerView.height-90/2)/2, kScreen_Width/2.0, 90/2);
        [resBtn setImage:[UIImage imageNamed:imgArrNormal[i]] forState:UIControlStateNormal];
//        [resBtn setImage:[UIImage imageNamed:imgArrSelected[i]] forState:UIControlStateSelected];
        [resBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [resBtn setTitleColor:[UIColor colorWithHexString:@"#989898"] forState:UIControlStateNormal];
        [resBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        resBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        resBtn.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:resBtn];
        [resBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake((headerView.width-1)/2, (headerView.height-22)/2, 1, 22)];
            line.backgroundColor = [UIColor colorWithHexString:@"#EEEFEF"];
            [headerView addSubview:line];
            
            self.lastBtn = resBtn;
            resBtn.selected = YES;
        }

    }
    
    self.tableView.tableHeaderView = headerView;
    self.Type_Like = @"foodlike";
    [self getSelectUserPreference];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.lastBtn = btn;
    
    if (btn.tag == 0) {

        self.Type_Like = @"foodlike";
        [self getSelectUserPreference];
    }
    if (btn.tag == 1) {
        
        self.Type_Like = @"foodunlike";
        [self getSelectUserPreference];
    }

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
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    NSArray *modelArr = self.dataList[indexPath.section];
    FoodModel *model = modelArr[indexPath.row];
    cell.textLabel.text = model.FoodName;
//    cell.textLabel.textColor = [UIColor colorWithHexString:@"#6D6D6D"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

- (void)testAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

@end
