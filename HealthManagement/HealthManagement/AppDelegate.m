//
//  AppDelegate.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/6/26.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "NavigationController.h"
#import "ClockView.h"
#import <AVFoundation/AVFoundation.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

@interface AppDelegate ()<BMKGeneralDelegate>

@property (strong, nonatomic) BMKMapManager *mapManager;
@property (strong, nonatomic) ClockView *clockView;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation AppDelegate

+ (AppDelegate *)share
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

// 计步单例
- (CMPedometer *)sharedPedometer
{
    static CMPedometer *sharedsharedPedometerrInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedsharedPedometerrInstance = [[CMPedometer alloc] init];
    });
    return sharedsharedPedometerrInstance;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor colorWithHexString:@"#EDEEEF"];
    [self.window makeKeyAndVisible];
    
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"YdHoRfn7jAMmcjVaCuChMdX9WLkTEEae"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    // 判断登录状态
    [self isLoginedState];
    
    
    // 是否是第一次启动(针对本地推送 应用删除再安装还会出现之前的本地推送设置)
    if (![InfoCache getValueForKey:@"IsFirstLaunch"]) {
        [InfoCache saveValue:@(YES) forKey:@"IsFirstLaunch"];
        UIApplication *app = [UIApplication sharedApplication];
        // 删除所有本地推送
        [app cancelAllLocalNotifications];
    }
    
    
    //接收通知参数(本地)
    UILocalNotification *notification=[launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (notification) {
        [self userInfo:notification];

    }

    
    return YES;
}

// 判断登录状态
- (void)isLoginedState
{
    if (![[InfoCache getValueForKey:@"LoginedState"] integerValue]) {
        LoginVC *loginVC = [[LoginVC alloc] init];
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = nav;
    }
    else {
        TabBarController *tabVC = [[TabBarController alloc] init];
        self.window.rootViewController = tabVC;
    }
}


// 本地通知回调函数，当应用程序在前台时调用(闹钟)
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"noti:%@",notification);
    
    if (notification) {
        
        [self userInfo:notification];
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 闹钟提醒试图
- (void)userInfo:(UILocalNotification *)notification
{
    // 获取通知所带的数据
    NSString *clockTime = [notification.userInfo objectForKey:@"clockTime"];
    
    // 播放音频
    NSString *clockMusic = [notification.userInfo objectForKey:@"clockMusic"];
    NSString *path = [[NSBundle mainBundle]pathForResource:clockMusic ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    //    _audioPlayer.delegate = self;
    _audioPlayer.numberOfLoops = 0; // 不循环
    [_audioPlayer prepareToPlay]; // 准备播放，加载音频文件到缓存
    [self.audioPlayer play];
    
    NSString *clockID = [notification.userInfo objectForKey:@"ActivityClock"];
    
    if ([clockID isEqualToString:@"WakeupID"]) {
        self.clockView = [[ClockView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        self.clockView.timeStr = clockTime;
        [self.window addSubview:self.clockView];
        
        __weak typeof(self) weakSelf = self;
        self.clockView.block = ^{
            if ([weakSelf.audioPlayer isPlaying]) {
                [weakSelf.audioPlayer pause];
            }
        };
    }
}


#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


@end
