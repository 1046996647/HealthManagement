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


#import "HeaderView.h"

@interface HomeVC ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) BMKLocationService *locService;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) HeaderView *headView;


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
    
}

- (void)initSubviews
{
    // 头视图
    HeaderView *headView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    self.tableView.tableHeaderView = headView;
    [self.view addSubview:self.tableView];
    self.headView = headView;

}

-(void)viewWillAppear:(BOOL)animated {
    
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    
    [self.navigationController.navigationBar setHidden:NO];

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
    
    NSLog(@"address:%@----%@",result.addressDetail,result.address);
    
    // 定位
    [self.headView.userLocationBtn  setTitle:result.address forState:UIControlStateNormal];
    
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
