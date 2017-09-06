//
//  SearchVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "SearchVC.h"
#import "HXTagsView.h"
#import "HistorySearchCell.h"
#import "DeleteViewController.h"
#import "SearchResultVC.h"

#define HistoryPath @"HistoryPath"


@interface SearchVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) HXTagsView *tagsView;
@property(nonatomic,strong) UITableView *tableView;
//@property(nonatomic,copy) NSString *searchText;
@property(nonatomic,strong) NSMutableArray *hisArr;



@end

@implementation SearchVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.scrollEnabled = NO;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;// 滑动时收起键盘

        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 右上角按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 30, 18);
//    [btn2 setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [btn2 setTitle:@"搜索" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
//    [btn2 addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    
    //-----------搜索-----------
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 15)];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.image = [UIImage imageNamed:@"home_2"];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width-(80+118)/2, 25)];
    tf.layer.cornerRadius = tf.height/2.0;
    tf.delegate = self;
    //    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    tf.layer.masksToBounds = YES;
    tf.placeholder = @"餐厅/菜谱/食物";
    tf.font = [UIFont systemFontOfSize:12];
    [tf setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [tf setValue:[UIColor colorWithHexString:@"#868788"] forKeyPath:@"_placeholderLabel.textColor"];
    tf.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = leftView;
    tf.returnKeyType = UIReturnKeySearch;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    tf.tintColor = [UIColor blueColor];
    self.navigationItem.titleView = tf;
//    [self.navigationItem.titleView addSubview:tf];
    self.tf = tf;
//    [tf becomeFirstResponder];
    
    [self.view addSubview:self.tableView];
    
    // 搜索历史记录
    _hisArr = [[InfoCache getValueForKey:HistoryPath] mutableCopy];
    if (!_hisArr) {
        _hisArr = [NSMutableArray array];
        
    }
    
    [self getHotSearch];
    
}

- (void)initHotView:(NSArray *)tagArr
{
    // 头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 5)];
    view.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [headerView addSubview:view];
    
    UIImageView *hotImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 19, 19)];
    //    leftView.contentMode = UIViewContentModeScaleAspectFit;
    hotImg.image = [UIImage imageNamed:@"search_1"];
    [headerView addSubview:hotImg];
    
    UILabel *hotLab = [[UILabel alloc] initWithFrame:CGRectMake(hotImg.right+10, hotImg.center.y-7,200, 15)];
    hotLab.font = [UIFont boldSystemFontOfSize:13];
    hotLab.text = @"热门搜索";
    hotLab.textAlignment = NSTextAlignmentLeft;
    //        _lab1.textColor = [UIColor grayColor];
    [headerView addSubview:hotLab];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, hotImg.bottom+12, kScreen_Width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [headerView addSubview:view];
    
    //多行不滚动  ===============
    //    NSArray *tagAry = @[@"早餐",@"晚餐清蒸",@"红烧鲤鱼",@"红烧肉",@"晚餐",@"姜汁螺片",@"炝乌鱼花",@"老醋蜇头",@"红油香菇",@"各吃三鲜汤",@"海米扒油菜",@"炸麻团"];
    // 不需要设置高度,内部根据初始化参数自动计算高度
    _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, view.bottom, kScreen_Width, 0)];
    _tagsView.type = 0;
    //    _tagsView.tagSpace = 5;
    _tagsView.showsHorizontalScrollIndicator = NO;
    _tagsView.tagHeight = 20.0;
    _tagsView.titleSize = 12.0;
    _tagsView.tagVerticalSpace = 15.0;
    //    _tagsView.tagOriginX = 0.0;
    _tagsView.titleColor = [UIColor blackColor];
    _tagsView.cornerRadius = 3;
    _tagsView.backgroundColor = [UIColor clearColor];
    _tagsView.borderColor = [UIColor grayColor];
    [_tagsView setTagAry:tagArr delegate:self];
    [headerView addSubview:_tagsView];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, _tagsView.bottom, kScreen_Width, 5)];
    view.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [headerView addSubview:view];
    
    UIImageView *hositoryImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, view.bottom+14, 12, 17)];
    //    leftView.contentMode = UIViewContentModeScaleAspectFit;
    hositoryImg.image = [UIImage imageNamed:@"search_2"];
    [headerView addSubview:hositoryImg];
    
    UILabel *hositoryLab = [[UILabel alloc] initWithFrame:CGRectMake(hositoryImg.right+10, hositoryImg.center.y-7,200, 15)];
    hositoryLab.font = [UIFont boldSystemFontOfSize:13];
    hositoryLab.text = @"历史搜索";
    hositoryLab.textAlignment = NSTextAlignmentLeft;
    //        _lab1.textColor = [UIColor grayColor];
    [headerView addSubview:hositoryLab];
    
    
    // 删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(kScreen_Width-20-12, hositoryImg.center.y-10, 15, 17);
    [deleteBtn setImage:[UIImage imageNamed:@"search_4"] forState:UIControlStateNormal];
    //    [btn2 setTitle:@"搜索" forState:UIControlStateNormal];
    //    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, hositoryImg.bottom+14, kScreen_Width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"EEEEEE"];
    [headerView addSubview:view];
    
    headerView.height = view.bottom;
    
    self.tableView.tableHeaderView = headerView;
}

// 请求热门搜索
- (void)getHotSearch
{
    [SVProgressHUD show];
    
    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:HotSearch dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];

        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"ListData"];
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
            [self initHotView:arr];
            
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];
        
    }];
}


- (void)deleteAction
{
    // 删除
    DeleteViewController *deleteViewController = [[DeleteViewController alloc] init];
    deleteViewController.titleStr = @"清除历史记录";
    deleteViewController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    deleteViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //self.definesPresentationContext = YES; //不盖住整个屏幕
    [self presentViewController:deleteViewController animated:YES completion:nil];
    deleteViewController.fileDeleteBlock = ^(void)
    {
        [self.hisArr removeAllObjects];
        [self.tableView reloadData];
        [InfoCache saveValue:self.hisArr forKey:HistoryPath];
    };

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hisArr.count;
//    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HistorySearchCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self pushAction:cell.hositoryLab.text];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HistorySearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[HistorySearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    cell.hositoryLab.text = self.hisArr[indexPath.row];
    cell.hositoryLab.textColor = [UIColor colorWithHexString:@"#606060"];

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

#pragma mark HXTagsViewDelegate

/**
 *  tagsView代理方法
 *
 *  @param tagsView tagsView
 *  @param sender   tag:sender.titleLabel.text index:sender.tag
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.currentTitle,(long)sender.tag);
    
    [self pushAction:sender.currentTitle];
    
    if (![self.hisArr containsObject:sender.currentTitle]) {
        [self.hisArr addObject:sender.currentTitle];
        [InfoCache saveValue:_hisArr forKey:HistoryPath];
        [self.tableView reloadData];
    }

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length == 0) {
        [self.tf resignFirstResponder];
        
        return YES;
    }
    
    [self.tf resignFirstResponder];
    [self pushAction:textField.text];
    if (![self.hisArr containsObject:textField.text]) {
        [self.hisArr addObject:textField.text];
        [InfoCache saveValue:_hisArr forKey:HistoryPath];
        [self.tableView reloadData];
    }

    return YES;
}

// 搜索结果
- (void)pushAction:(NSString *)text
{
    SearchResultVC *vc = [[SearchResultVC alloc] init];
    vc.title = @"搜索结果";
    vc.longitude = self.longitude;
    vc.latitude = self.latitude;
    vc.searchText = text;
    [self.navigationController pushViewController:vc animated:YES];
}

// 重写返回方法
- (void)back{
    
    [self.tf resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
