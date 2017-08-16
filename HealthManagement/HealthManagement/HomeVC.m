
//
//  ViewController.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HomeVC.h"
#import "DietRecordCell.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import "ResDetailModel.h"

#import "HeaderView.h"

@interface HomeVC ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) BMKLocationService *locService;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) HeaderView *headView;
@property(nonatomic,strong) NSNumber *latitude;// 纬度
@property(nonatomic,strong) NSNumber *longitude;// 经度
@property(nonatomic,assign) NSInteger pageNO;// 页数
@property (nonatomic,strong) NSMutableArray *dataArr;
//@property (nonatomic,assign) BOOL isFirst;
@property (nonatomic,assign) BOOL isRefresh;



@end

@implementation HomeVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49-25)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 让内容置顶显示
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.backButton = nil;
    
    // 初始化视图
    [self initSubviews];
    
    //初始化BMKLocationService定位服务
    _locService = [[BMKLocationService alloc]init];
    //    _locService.delegate = self;
    
    // 反检索
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //    _geocodesearch.delegate = self;
    
    //启动LocationService
    [_locService startUserLocationService];
    
    // 页数
    self.pageNO = 1;
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self headerRefresh];
    }];
    
}

- (void)headerRefresh
{
//    self.pageNO = 1;
    [self getTitlePage];
    self.isRefresh = YES;
}

// 请求首页列表
- (void)getTitlePage
{
    
    PersonModel *model = [InfoCache unarchiveObjectWithFile:Person];

    if (!self.isRefresh) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD show];

    }

    NSMutableDictionary *paramDic=[NSMutableDictionary dictionary];
    [paramDic  setObject:self.longitude forKey:@"CoordX"];
    [paramDic  setObject:self.latitude forKey:@"CoordY"];
    [paramDic  setObject:model.UserId forKey:@"UserId"];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:TitlePage dic:paramDic Succed:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];

        NSLog(@"%@",responseObject);
        
        NSArray *arr = responseObject[@"ListData"];
        if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
//            self.pageNO++;

            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                ResDetailModel *model = [ResDetailModel yy_modelWithJSON:dic];
                [arrM addObject:model];
            }

//            self.dataArr = arrM;
            self.headView.nearbyResView.latitude = self.latitude;
            self.headView.nearbyResView.longitude = self.longitude;
//            self.headView.nearbyResView.pageNO = self.pageNO;
            self.headView.nearbyResView.modelArr = arrM;
            
        }
        
        NSArray *arr2 = responseObject[@"ListData2"];
        if ([arr2 isKindOfClass:[NSArray class]] && arr2.count > 0) {
            //            self.pageNO++;
            
            NSMutableArray *arrM2 = [NSMutableArray array];
            for (NSDictionary *dic in arr2) {
                RecipeModel *model = [RecipeModel yy_modelWithJSON:dic];
                [arrM2 addObject:model];
            }
            
            self.headView.recommendDietView.latitude = self.latitude;
            self.headView.recommendDietView.longitude = self.longitude;
            self.headView.recommendDietView.modelArr = arrM2;
            
        }
        
        NSArray *arr3 = responseObject[@"ListData3"];
        if ([arr3 isKindOfClass:[NSArray class]] && arr3.count > 0) {
            
            NSMutableArray *arrM3 = [NSMutableArray array];
            for (NSDictionary *dic in arr3) {
                ArticleModel *model = [ArticleModel yy_modelWithJSON:dic];
                [arrM3 addObject:model];
            }
            
            self.headView.articleModel = arrM3;

        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
        NSLog(@"%@",error);
        [SVProgressHUD dismiss];

    }];
}

- (void)initSubviews
{
    // 头视图
    HeaderView *headView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    self.tableView.tableHeaderView = headView;
    [self.view addSubview:self.tableView];
    self.headView = headView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(locationAction:)];
    [self.headView.userLocationLab addGestureRecognizer:tap];


}

// 重新定位
- (void)locationAction:(UIGestureRecognizer *)tap
{
    [_locService startUserLocationService];
}

-(void)viewWillAppear:(BOOL)animated {
    
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

-(void)viewWillDisappear:(BOOL)animated {
    
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    [self.headView.tf resignFirstResponder];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
     //带动画结果在切换tabBar的时候viewController会有闪动的效果不建议这样写
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    [_locService stopUserLocationService];//定位完成停止位置更新(导致反检索失败)
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);

    self.latitude = @(userLocation.location.coordinate.latitude);
    self.longitude = @(userLocation.location.coordinate.longitude);
    
    [InfoCache saveValue:self.latitude forKey:@"latitude"];
    [InfoCache saveValue:self.longitude forKey:@"longitude"];
    
    //地理反编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
        NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
        NSLog(@"反geo检索发送失败");
        
    }
}


#pragma mark -------------地理反编码的delegate---------------

-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error

{
    NSLog(@"%@----%i",result,error);

    if (result) {
        
//        NSLog(@"address:%@----%@",result.addressDetail,result.address);

        // 定位
        BMKPoiInfo *poiInfo = [result.poiList firstObject];
        self.headView.userLocationLab.text = poiInfo.name;
        
        self.headView.latitude = self.latitude;
        self.headView.longitude = self.longitude;
        
//        if (!self.isFirst) {// 避免自动多次定位导致多次请求
//            
//            self.isFirst = YES;
//
//        }
        // 请求餐厅列表
        [self getTitlePage];
    }
    else {
        
        self.headView.userLocationLab.text = @"定位失败";

    }

    
    //addressDetail:     层次化地址信息
    
    //address:    地址名称
    
    //businessCircle:  商圈名称
    
    // location:  地址坐标
    
    //  poiList:   地址周边POI信息，成员类型为BMKPoiInfo
    
    //    for (BMKPoiInfo *info in result.poiList) {
    //        NSLog(@"address:%@----%@",info.name,info.address);
    //
    //    }
    
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArray.count;
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DietRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[DietRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    cell.textLabel.text = self.dataArray[indexPath.row];
//    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
