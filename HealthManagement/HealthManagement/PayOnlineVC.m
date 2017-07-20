//
//  PayOnlineVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "PayOnlineVC.h"

@interface PayOnlineVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *leftDataList;
@property(nonatomic,strong) NSArray *rightDataList;
@property(nonatomic,strong) NSArray *sectionDataList;
@property(nonatomic,strong) NSArray *imgArr;
@property(nonatomic,strong) UIButton *lastBtn;


@end

@implementation PayOnlineVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftDataList = @[@"支付金额",@"商家",@"到店时间"];
    self.rightDataList = @[@"￥ 56",@"肯德基",@"2017年12月12日16:12"];
    self.sectionDataList = @[@"  订单信息",@"  选择支付方式"];
    self.imgArr = @[@"online_2",@"online_1"];
    
    // 尾视图
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    //    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    
    UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    enterBtn.frame = CGRectMake(140/2, 25, kScreen_Width-140, 45);
    enterBtn.layer.cornerRadius = 5;
    enterBtn.layer.masksToBounds = YES;
    [enterBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    enterBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    enterBtn.backgroundColor = [UIColor colorWithHexString:@"#FF6500"];
    [footerView addSubview:enterBtn];
//    [enterBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    
    footerView.height = enterBtn.bottom+25;
    
    self.tableView.tableFooterView = footerView;
    [self.view addSubview:self.tableView];

    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionDataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.dataArray.count;
    
    if (section == 0) {
        return self.rightDataList.count;

    }
    else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 96/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 74/2;

}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *hotLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 2,kScreen_Width, 74/2)];
    hotLab.font = [UIFont systemFontOfSize:16];
    hotLab.text = self.sectionDataList[section];
    hotLab.textAlignment = NSTextAlignmentLeft;
    hotLab.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
//    hotLab.textColor = [UIColor colorWithHexString:@"#595959"];
    return hotLab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        UIButton *btn = (UIButton *)[cell viewWithTag:100];
        
        self.lastBtn.selected = NO;
        btn.selected = YES;
        self.lastBtn = btn;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        
    }
    
    if (indexPath.section == 0) {
        
        // 设置为NO字体颜色将改变不了
//        cell.userInteractionEnabled = NO;
        
        cell.textLabel.text = self.leftDataList[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#898989"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        cell.detailTextLabel.text = self.rightDataList[indexPath.row];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#898989"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
        
        if (indexPath.row == 0) {
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#FB6A00"];

        }

    }
    else {
        
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(10, (96/2-20)/2, 20, 20);
        [selectBtn setImage:[UIImage imageNamed:@"point1"] forState:UIControlStateNormal];
        selectBtn.tag = 100;
        [selectBtn setImage:[UIImage imageNamed:@"point2"] forState:UIControlStateSelected];
        [cell.contentView addSubview:selectBtn];
        
        UIImageView *payImg = [[UIImageView alloc] initWithFrame:CGRectMake(selectBtn.right+20, selectBtn.center.y-15, 230/2, 30)];
        payImg.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
        payImg.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:payImg];
        
        if (indexPath.row == 0) {
            payImg.left = selectBtn.right+5;
            
            self.lastBtn = selectBtn;
            selectBtn.selected = YES;
        }
    }


    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
