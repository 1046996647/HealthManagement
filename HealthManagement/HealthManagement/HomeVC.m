//
//  ViewController.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "HomeVC.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface HomeVC ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (strong, nonatomic) BMKLocationService *locService;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    //初始化BMKLocationService定位服务
    _locService = [[BMKLocationService alloc]init];
    //    _locService.delegate = self;
    
    // 反检索
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //    _geocodesearch.delegate = self;
    
    //启动LocationService
    [_locService startUserLocationService];
}

-(void)viewWillAppear:(BOOL)animated {
    
    _locService.delegate = self;
    _geocodesearch.delegate = self;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
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


@end
