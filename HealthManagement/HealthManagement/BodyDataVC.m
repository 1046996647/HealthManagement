//
//  BodyDataVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BodyDataVC.h"
#import "ZWLDatePickerView.h"
#import "InfoChangeController.h"

@interface BodyDataVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *leftDataList;
@property(nonatomic,strong) NSArray *rightDataList;
@property(nonatomic,strong) UIImageView *headImg;
@property(nonatomic,strong) UIImageView *maleImg;
@property(nonatomic,strong) UIImageView *femaleImg;


@end

@implementation BodyDataVC

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
    
    self.leftDataList = @[@"出生日期",@"身高",@"体重",@"劳动强度"];
    
    NSString *height = nil;
    NSString *weight = nil;
    if (!self.person.height) {
        height = @"";
    }
    else {
        height = [NSString stringWithFormat:@"%@ cm",self.person.height];

    }
    if (!self.person.weight) {
        weight = @"";
    }
    else {
        weight = [NSString stringWithFormat:@"%@ kg",self.person.weight];

    }
    if (!self.person.labourIntensity) {
        self.person.labourIntensity = @"";
    }

    
    self.rightDataList = @[self.person.BirthDay,height,weight,self.person.labourIntensity];
    
    // 头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 16)];
    view.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [headerView addSubview:view];
    
    UIImageView *maleImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2-35-150/2, view.bottom+45, 150/2, 90/2)];
    maleImg.userInteractionEnabled = YES;
    maleImg.tag = 100;

//    maleImg.image = [UIImage imageNamed:@"body_3"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:maleImg];
    self.maleImg = maleImg;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexAction:)];
    [maleImg addGestureRecognizer:tap];
    
    
    UIImageView *femaleImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2+35, view.bottom+45, 150/2, 90/2)];
//    femaleImg.image = [UIImage imageNamed:@"body_5"];
    //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    femaleImg.tag = 101;
    femaleImg.userInteractionEnabled = YES;
    [headerView addSubview:femaleImg];
    self.femaleImg = femaleImg;

    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexAction:)];
    [femaleImg addGestureRecognizer:tap1];
    
    headerView.height = femaleImg.bottom+45;
    
    if (self.person.sex.integerValue == 0) {
        maleImg.image = [UIImage imageNamed:@"body_3"];
        femaleImg.image = [UIImage imageNamed:@"body_5"];

    }
    else {
        
        maleImg.image = [UIImage imageNamed:@"body_4"];
        femaleImg.image = [UIImage imageNamed:@"body_2"];
        
    }
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
//    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(10, 25, kScreen_Width-20, 104/2);
    enterBtn.layer.cornerRadius = 5;
    enterBtn.layer.masksToBounds = YES;
    [enterBtn setTitle:@"保存" forState:UIControlStateNormal];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    enterBtn.backgroundColor = [UIColor colorWithHexString:@"#72AFE5"];
    [footerView addSubview:enterBtn];
    [enterBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    footerView.height = enterBtn.bottom+25;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = footerView;
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sexAction:(UIGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    if (tag == 100) {
        
        self.person.sex = @"true";
        self.maleImg.image = [UIImage imageNamed:@"body_4"];
        self.femaleImg.image = [UIImage imageNamed:@"body_2"];
        
    }
    else {
        
        self.person.sex = @"false";
        self.maleImg.image = [UIImage imageNamed:@"body_3"];
        self.femaleImg.image = [UIImage imageNamed:@"body_5"];
    }
}

- (void)saveAction
{
    [SVProgressHUD show];

    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.person.UserId forKey:@"UserId"];
    [paramDic  setValue:self.person.sex
                 forKey:@"UserSex"];
    [paramDic  setValue:self.person.BirthDay forKey:@"UserBirthTime"];
    [paramDic  setValue:self.person.height forKey:@"UserHeight"];
    [paramDic  setValue:self.person.weight forKey:@"UserWeight"];
    [paramDic  setValue:self.person.labourIntensity forKey:@"labInten"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:SetUserBodyInfo dic:paramDic Succed:^(id responseObject) {
        
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            [self getUserBodyInfo];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];

}

// 获取用户信息
- (void)getUserBodyInfo
{
    
    NSMutableDictionary *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    [paramDic  setValue:self.person.UserId forKey:@"Id"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetUserBodyInfo dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"%@",responseObject);
        
        NSNumber *code = [responseObject objectForKey:@"HttpCode"];
        
        if (200 == [code integerValue]) {
            
            NSArray *arr = [responseObject objectForKey:@"ListData"];
            PersonModel *model = [PersonModel yy_modelWithJSON:[arr firstObject]];
            [InfoCache archiveObject:model toFile:@"Person"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
        
    }];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 116/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取单元格
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        ZWLDatePickerView *datepickerView = [[ZWLDatePickerView alloc] initWithFrame:CGRectMake(0,kScreen_Height - 270, kScreen_Width, 270)];
        datepickerView.type = 1;
        datepickerView.dateStr = cell.detailTextLabel.text;
        datepickerView.dataBlock = ^(NSString *str,NSString *str1) {
            self.person.BirthDay = str1;
            cell.detailTextLabel.text = str;
        };
        
        UIViewController *birthdayCtrl = [[UIViewController alloc] init];
        birthdayCtrl.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        //淡出淡入
        birthdayCtrl.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        //            self.definesPresentationContext = YES; //不盖住整个屏幕
        //            birthdayCtrl.dateStr = cell.dataLab.text;
        birthdayCtrl.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        [birthdayCtrl.view addSubview:datepickerView];
        
        [self presentViewController:birthdayCtrl animated:YES completion:nil];
        
    }
    if (indexPath.row == 1) {
        
        InfoChangeController *vc = [[InfoChangeController alloc] init];
        vc.title = @"身高";
        vc.text = self.person.height;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *str) {
            self.person.height = str;
            
            if (str.length == 0) {
                cell.detailTextLabel.text = @"";

            }
            else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ cm",str];

            }

        };
        
    }
    if (indexPath.row == 2) {
        InfoChangeController *vc = [[InfoChangeController alloc] init];
        vc.title = @"体重";
        vc.text = self.person.weight;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block = ^(NSString *str) {
            self.person.weight = str;
            
            if (str.length == 0) {
                cell.detailTextLabel.text = @"";
                
            }
            else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ cm",str];
                
            }
        };
        
    }
    if (indexPath.row == 3) {
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    
    
    cell.textLabel.text = self.leftDataList[indexPath.row];
    //    cell.textLabel.textColor = [UIColor colorWithHexString:@"#6D6D6D"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    
    cell.detailTextLabel.text = self.rightDataList[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#898989"];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:17];
    return cell;
}
@end
