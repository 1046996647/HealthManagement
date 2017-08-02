//
//  SettingVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/19.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SettingVC.h"
#import "LoginVC.h"
#import "AppDelegate.h"
#import "NavigationController.h"
#import "registerVC.h"

@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *leftDataList;
@property(nonatomic,strong) NSArray *rightDataList;
@property(nonatomic,strong) UIImageView *headImg;


@end

@implementation SettingVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreen_Width, kScreen_Height-64-20-45)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftDataList = @[@"头像",@"名字",@"手机",@"密码"];
    
    if (!self.person.name) {
        self.person.name = @"";
    }
    if (!self.person.phone) {
        self.person.phone = @"尚未绑定";
    }
    self.rightDataList = @[@"",self.person.name,self.person.phone,@"修改"];
    
    [self.view addSubview:self.tableView];
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(0, kScreen_Height-45-64, kScreen_Width, 45);
    [exitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    exitBtn.backgroundColor = [UIColor whiteColor];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:exitBtn];
    [exitBtn addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)exitAction
{
    [InfoCache saveValue:@0 forKey:@"LoginedState"];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    LoginVC *loginVC = [[LoginVC alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:loginVC];
    delegate.window.rootViewController = nav;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 232/2;

    }
    return 116/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
    }
    if (indexPath.row == 1) {
        
    }
    if (indexPath.row == 2) {
        
    }
    if (indexPath.row == 3) {
        
        registerVC *vc = [[registerVC alloc] init];
        vc.title = @"修改密码";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = [UIColor whiteColor];

    }
    
    if (indexPath.row == 0) {
        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width-156/2-30, (232/2-156/2)/2, 156/2, 156/2)];
//        headImg.image = [UIImage imageNamed:@"head"];
        //        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:headImg];
        self.headImg = headImg;
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
