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
#import "SleepModel.h"
#import <AVFoundation/AVFoundation.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#define ClockPath @"ClockPath"


@interface AppDelegate ()<BMKGeneralDelegate>
{
    SystemSoundID soundID;
}

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
    
    // 适配iOS11(iOS11后隐藏导航栏的MJRefresh下拉刷新控件会漏出来，但以下方法造成UIImagePickerController有问题)
    //    if (@available(iOS 11.0, *)){
    //        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    //
    //    }

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
        
        NSDate *nowDate = [NSDate date];
        int i  = [nowDate timeIntervalSinceDate:notification.fireDate];
        // 五分钟内进入弹出视图
        if (i/60 < 5) {
            [self userInfo:notification];
            
        }
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
        self.tabVC = tabVC;
        self.window.rootViewController = tabVC;
    }
}


// 本地通知回调函数，当应用程序在前台时直接调用，后台点击调用(闹钟)
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"noti:%@",notification);
    
    if (notification) {
        
        NSDate *nowDate = [NSDate date];
        int i  = [nowDate timeIntervalSinceDate:notification.fireDate];
        // 五分钟内进入弹出视图
        if (i/60 < 5) {
            [self userInfo:notification];

        }

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
    
    // 取出闹钟本地数据,进入前台就关掉闹钟
    SleepModel *_model = [InfoCache unarchiveObjectWithFile:ClockPath];
    if (_model.isOpen) {
        
        // 时间格式化
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString * startDate = nil;
        NSString * endDate = nil;
        NSDate *updateDate = nil;
        NSTimeInterval time = 0;
        
        // 就寝时
        if (_model.tag.integerValue == 0) {
            //转化为字符串
            startDate = [dateFormatter stringFromDate:_model.startDate];
            NSLog(@"！！！！！！！！！%@",startDate);
            
        }
        
        // 15分钟前
        if (_model.tag.integerValue == 1) {
            time = 15 * 60;
            updateDate = [_model.startDate dateByAddingTimeInterval:-time];
            //转化为字符串
            startDate = [dateFormatter stringFromDate:updateDate];
            NSLog(@"！！！！！！！！！%@",startDate);
            
        }
        // 30分钟前
        else if (_model.tag.integerValue == 2) {
            time = 30 * 60;
            updateDate = [_model.startDate dateByAddingTimeInterval:-time];
            //转化为字符串
            startDate = [dateFormatter stringFromDate:updateDate];
            NSLog(@"！！！！！！！！！%@",startDate);
        }
        // 1小时前
        else if (_model.tag.integerValue == 3) {
            time = 1 * 60 * 60;
            updateDate = [_model.startDate dateByAddingTimeInterval:-time];
            //转化为字符串
            startDate = [dateFormatter stringFromDate:updateDate];
            NSLog(@"！！！！！！！！！%@",startDate);
        }
        
        endDate = [dateFormatter stringFromDate:_model.endDate];
        
        // 就寝闹钟
        [AppDelegate shutdownClock:@"SleepID"];
        [AppDelegate postLocalNotification:@"SleepID" clockTime:startDate weekArr:_model.weekDay alertBody:@"该睡觉啦~" clockMusic:_model.musicName];
        
        // 起床闹钟 - 进入修身停止闹钟
        [AppDelegate shutdownClock:@"WakeupID"];
        [AppDelegate postLocalNotification:@"WakeupID" clockTime:endDate weekArr:_model.weekDay alertBody:@"该起床啦~" clockMusic:_model.musicName];
    }
    
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
    
    // 播放音频
    NSString *clockMusic = [notification.userInfo objectForKey:@"clockMusic"];
    NSString *path = [[NSBundle mainBundle]pathForResource:clockMusic ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    //    _audioPlayer.delegate = self;
    _audioPlayer.numberOfLoops = 0; // 不循环
    [_audioPlayer prepareToPlay]; // 准备播放，加载音频文件到缓存
    [self.audioPlayer play];
    
    
//    NSString *clockMusic = [notification.userInfo objectForKey:@"clockMusic"];
//    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",clockMusic,@"caf"];
//    if (clockMusic) {
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:clockMusic], &soundID);
//        AudioServicesPlaySystemSound(soundID);
//        
//    }
    
    self.clockView = [[ClockView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.clockView.info = notification.userInfo;
    [self.window addSubview:self.clockView];
    
    __weak typeof(self) weakSelf = self;
    self.clockView.block = ^{
        if ([weakSelf.audioPlayer isPlaying]) {
            [weakSelf.audioPlayer pause];
        }
    };
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

// 闹钟
+ (void)postLocalNotification:(NSString *)clockID clockTime:(NSString *)clockTime weekArr:(NSArray *)array alertBody:(NSString *)alertBody clockMusic:(NSString *)clockMusic
{
    
    //-----组建本地通知的fireDate-----------------------------------------------
    NSArray *clockTimeArray = [clockTime componentsSeparatedByString:@":"];
    NSDate *dateNow = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    //    [comps setTimeZone:[NSTimeZone timeZoneWithName:@"CMT"]];
    NSInteger unitFlags = NSCalendarUnitEra |
    NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond |
    NSCalendarUnitWeekOfYear |
    NSCalendarUnitWeekday |
    NSCalendarUnitWeekdayOrdinal |
    NSCalendarUnitQuarter;
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    [comps setHour:[[clockTimeArray objectAtIndex:0] intValue]];
    [comps setMinute:[[clockTimeArray objectAtIndex:1] intValue]];
    [comps setSecond:0];
    
    //------------------------------------------------------------------------
    Byte weekday = [comps weekday];
    //    NSArray *array = [[clockMode substringFromIndex:1] componentsSeparatedByString:@"、"];
    Byte i = 0;
    Byte j = 0;
    int days = 0;
    int	temp = 0;
    Byte count = [array count];
    Byte clockDays[7];
    
    //    NSArray *tempWeekdays = [NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"七", nil];
    NSArray *tempWeekdays = [NSArray arrayWithObjects:@"7",@"1",@"2",@"3",@"4",@"5",@"6", nil];
    //查找设定的周期模式
    for (i = 0; i < count; i++) {
        for (j = 0; j < 7; j++) {
            if ([[array objectAtIndex:i] isEqualToString:[tempWeekdays objectAtIndex:j]]) {
                clockDays[i] = j + 1;
                break;
            }
        }
    }
    
    for (i = 0; i < count; i++) {
        temp = clockDays[i] - weekday;
        days = (temp >= 0 ? temp : temp + 7);
        NSDate *newFireDate = [[calendar dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
        
        UILocalNotification *newNotification = [[UILocalNotification alloc] init];
        if (newNotification) {
            newNotification.fireDate = newFireDate;
            newNotification.alertBody = alertBody;
            //            newNotification.applicationIconBadgeNumber = 1;//应用程序右上角显示的未读消息数
            //            NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"alarm",@"caf"];
            
            //            newNotification.soundName = path;
            newNotification.soundName = [NSString stringWithFormat:@"%@.caf", @"梦幻"];
            
//            newNotification.alertAction = @"进入修身停止闹钟";
            newNotification.repeatInterval = NSCalendarUnitWeekOfYear;
            //            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:clockID forKey:@"ActivityClock"];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:clockID,@"ActivityClock",newNotification.soundName,@"clockMusic",clockTime,@"clockTime", nil];
            newNotification.userInfo = userInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
        }
        NSLog(@"添加本地通知:%@", [newNotification fireDate]);
        
    }
}

+ (void)shutdownClock:(NSString *)clockID
{
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in localNotifications)
    {
        if ([[[notification userInfo] objectForKey:@"ActivityClock"] isEqualToString:clockID]) {
            NSLog(@"移除本地通知:%@", [notification fireDate]);
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}


@end
