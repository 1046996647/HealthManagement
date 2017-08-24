//
//  NearbyRestaurantVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/27.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "DietArticleVC.h"
#import "DietArticleCell.h"
#import "DietArticleDetailVC.h"

@interface DietArticleVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UILabel *bodyLab;
@property(nonatomic,strong) UILabel *fitLab;
@property(nonatomic,strong) UILabel *possibleLab;
@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger pageNO;// 页数
@property(nonatomic,strong) NSMutableArray *modelArr;


@end

@implementation DietArticleVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-64-25)];
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
//    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    headerView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 6)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    [headerView addSubview:line1];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, line1.bottom+12, 46/2, 64/2)];
    imgView1.image = [UIImage imageNamed:@"text_3"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:imgView1];
    
    _bodyLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView1.right+10, imgView1.center.y-10, kScreen_Width-12-12, 20)];
    _bodyLab.font = [UIFont boldSystemFontOfSize:16];
    _bodyLab.textColor = [UIColor colorWithHexString:@"#58595A"];
//    _bodyLab.text = @"您的体质是XXXX";
    [headerView addSubview:_bodyLab];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(12, _bodyLab.bottom+20, imgView1.width, imgView1.height)];
    imgView2.image = [UIImage imageNamed:@"text_2"];
    imgView2.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:imgView2];

    _fitLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView2.right+10, imgView2.center.y-10, kScreen_Width-12-12, 20)];
    _fitLab.font = [UIFont boldSystemFontOfSize:16];
    _fitLab.textColor = [UIColor colorWithHexString:@"#58595A"];
//    _fitLab.text = @"适合吃XXXX";
    [headerView addSubview:_fitLab];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(12, _fitLab.bottom+20, imgView1.width, imgView1.height)];
    imgView3.image = [UIImage imageNamed:@"text_1"];
    imgView3.contentMode = UIViewContentModeScaleAspectFit;
    [headerView addSubview:imgView3];
    
    _possibleLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView3.right+10, imgView3.center.y-10, kScreen_Width-12-12, 20)];
    _possibleLab.font = [UIFont boldSystemFontOfSize:16];
    _possibleLab.textColor = [UIColor colorWithHexString:@"#58595A"];
//    _possibleLab.text = @"尽量少吃XXXX";
    [headerView addSubview:_possibleLab];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, _possibleLab.bottom+12, kScreen_Width, 6)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    [headerView addSubview:line2];
    
    headerView.height = line2.bottom;
    self.tableView.tableHeaderView = headerView;
    
    [self.view addSubview:self.tableView];
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self headerRefresh];
    }];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.modelArr.count > 0) {
            // 饮食文章列表
            [self getArticleListInfo];
        }
        
    }];
    
    self.pageNO = 1;
    self.modelArr = [NSMutableArray array];
    
    [self getArticleListInfo];
}

- (void)headerRefresh
{
    self.pageNO = 1;
    if (self.modelArr.count > 0) {
        [self.modelArr removeAllObjects];

    }
    [self getArticleListInfo];
}

// 饮食文章列表
- (void)getArticleListInfo
{
    if (self.pageNO == 1) {
        [SVProgressHUD show];

    }

    PersonModel *person = [InfoCache unarchiveObjectWithFile:Person];

    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:person.UserId forKey:@"Id"];
    [paramDic  setObject:@(self.pageNO) forKey:@"PageNo"];
    //    [paramDic  setObject:imgStr forKey:@"TypeValue"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:GetArticleListInfo dic:paramDic Succed:^(id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];


        
        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"ListData"];
        NSArray *arr2 = responseObject[@"ListData2"];
        if ([arr2 isKindOfClass:[NSArray class]] && arr.count > 0) {
            
            SuggestModel *model = [SuggestModel yy_modelWithJSON:[arr2 firstObject]];
//            _bodyLab.text = [NSString stringWithFormat:@"您的体质是%@",model.constitution];
            _bodyLab.text = model.constitution;
//            _fitLab.text = [NSString stringWithFormat:@"适合吃%@",model.SuitEat];
            _fitLab.text = model.SuitEat;
//            _possibleLab.text = [NSString stringWithFormat:@"尽量少吃%@",model.NotSuitEat];
            _possibleLab.text = model.NotSuitEat;

            
        }
        
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
            
            
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                ArticleModel *model = [ArticleModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }
            
            [self.modelArr addObjectsFromArray:arrM]; ;
            [self.tableView reloadData];
            
            self.pageNO++;
            
        }
        
        else {
            // 拿到当前的上拉刷新控件，变为没有更多数据的状态
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            //            _tableView.mj_footer.automaticallyHidden = YES;
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        
        NSLog(@"%@",error);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __block ArticleModel *articleModel = self.modelArr[indexPath.row];
    
    DietArticleDetailVC *vc = [[DietArticleDetailVC alloc] init];
    vc.title = @"推荐饮食";
    vc.model = articleModel;
    [self.navigationController pushViewController:vc animated:YES];
    vc.block = ^(ArticleModel *model) {
        articleModel = model;
        [self.tableView reloadData];
    };
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DietArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell"];
    if (cell == nil) {
        
        cell = [[DietArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"articleCell"];
        
    }
    
    if (self.modelArr.count > 0) {
        cell.model = self.modelArr[indexPath.row];

    }
    return cell;
}

@end
